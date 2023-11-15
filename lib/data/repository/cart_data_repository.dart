import 'package:glamcode/data/model/coupons.dart';
import 'package:glamcode/data/model/my_cart/wallet_data.dart';
import 'package:glamcode/data/repository/shopping_repository.dart';

import '../api/api_helper.dart';
import '../model/auth.dart';
import '../model/cart_data.dart';
import 'coupon_repository.dart';

class CartDataRepository {
  Auth auth = Auth.instance;
  DioClient dioClient = DioClient.instance;
  ShoppingRepository shoppingRepository;
  CouponRepository couponRepository;

  // CartDataBloc cartDataBloc;

  CartDataRepository(
      {required this.auth,
      required this.dioClient,
      // required this.cartDataBloc,
      required this.shoppingRepository,
      required this.couponRepository});

  Future<CartData> loadItems() async {
    num? couponId;
    num? userId;
    num? originalAmount;
    num? discount;
    num? couponDiscount;
    num? discountPercent;
    num? mincheck;
    String? taxName;
    num? taxPercent;
    num? extraFees;
    final num? distanceFee;
    final num? amountToPay;
    try {
      await Auth.instance.currentUser.then((value) => userId = value.id);
      originalAmount = shoppingRepository.getTotalPrice();
      
      couponRepository.currentCoupon.then((value) {
        couponId = value.id;
        if (value.amount == null) {
          discount = (originalAmount ?? 0 - (value.amount ?? 0)) / 100;
          //  * (value.percent ?? 0)) / 100;
        } else {
          discount = value.amount;
        }
        couponDiscount = discount;
        discountPercent = (value.amount ?? 0);
      });

      await dioClient.getAnyDataCall().then((value) {
        if (value != null) {
          if (value.tax != null && value.tax!.isNotEmpty) {
            taxName = value.tax![0].taxName;
            taxPercent = value.tax![0].percent;
          }
          if (value.extraFees != null && value.extraFees!.isNotEmpty) {
            extraFees = value.extraFees![0].amount;
          }
          if (value.mincheck != null && value.mincheck!.isNotEmpty) {
            mincheck = num.parse(value.mincheck![0].amount ?? "0");
          }
        }
      });

      amountToPay = (((originalAmount) + (extraFees ?? 0)
              //  -
              //  (couponDiscount ?? 0)
              ) *
              100) /
          100;

      CartData cartData = CartData(
          couponId: couponId,
          userId: userId,
          originalAmount: originalAmount,
          discount: discount,
          couponDiscount: couponDiscount,
          discountPercent: discountPercent,
          taxName: taxName,
          mincheck: mincheck,
          taxPercent: taxPercent,
          extraFees: extraFees,
          amountToPay: amountToPay.round());
          shoppingRepository.clearSharePrefs();
      return cartData;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<CartData> updateCart(CartData cartData, bool isWalletEnabled) async {
    num? originalAmount;
    num? amountToPay;
    num? couponId;
    num? discount;
    num? couponDiscount;
    num walletBalance = 0;
    bool isWalletUsed = false;
    // num? discountPercent;
    num minimumPurchaseAmount = 0;

    try {
      originalAmount = shoppingRepository.getTotalPrice();
      amountToPay = originalAmount;
      minimumPurchaseAmount = originalAmount;

      //TODO:0 recalculating coupon

      await couponRepository.currentCoupon.then((value) {
        couponId = value.id;
        if (value.amount == null) {
          // discount = (originalAmount ?? 0 - (value.amount ?? 0)) / 100;
          //  * (value.percent ?? 0)) / 100;
        } else {
          discount = value.amount;
        }
        couponDiscount = discount;
        // discountPercent = (value.amount ?? 0);
        minimumPurchaseAmount =
            value.minimumPurchaseAmount ?? originalAmount ?? 0;
        print(
            'current coupon coupon discount - $originalAmount $amountToPay *** $couponDiscount *** ${cartData.couponDiscount} (minimum ${value.minimumPurchaseAmount})  (coupon id $couponId)');
      });
      print(
          'coupon discount - $originalAmount $amountToPay *** $couponDiscount *** ${cartData.couponDiscount}');

      if (amountToPay < minimumPurchaseAmount && couponId != null) {
        print('coupon not applied ');
        amountToPay = (((originalAmount) + (cartData.extraFees ?? 0)
                // -
                // (cartData.discount ?? 0)
                ) *
                // -
                // (cartData.couponDiscount ?? 0)) *
                100) /
            100;
        couponDiscount = 0;
        couponId = null;
      } else if (amountToPay == minimumPurchaseAmount && couponId == null) {
        print('coupon not applied ');
        amountToPay = (((originalAmount) + (cartData.extraFees ?? 0)
                // -
                // (cartData.discount ?? 0)
                ) *
                // -
                // (cartData.couponDiscount ?? 0)) *
                100) /
            100;
        couponDiscount = 0;
        couponId = null;
      } else if (amountToPay >= minimumPurchaseAmount) {
        print('coupon applied');
        amountToPay = (((originalAmount) +
                    (cartData.extraFees ?? 0) -
                    (couponDiscount ?? 0)) *
                // -
                // (cartData.couponDiscount ?? 0)) *
                100) /
            100;
      }

      WalletData? walletData = await dioClient.getWalletData();

      if (walletData != null) {
        if (walletData.wallet!.isEmpty) {
          walletBalance = 0;
        } else {
          walletBalance = walletData.wallet?.first as num;
        }

        if (couponId == null && isWalletEnabled) {
          discount = getAppliedWalletDiscount(
              walletData.usage!, cartData, walletBalance);
          amountToPay = amountToPay = (((originalAmount) +
                      (cartData.extraFees ?? 0) -
                      (discount ?? 0)) *
                  // -
                  // (cartData.couponDiscount ?? 0)) *
                  100) /
              100;
          isWalletUsed = true;
        } else {
          discount = 0;
          isWalletUsed = false;
        }
      }

      return cartData.copyWith(
        originalAmount: originalAmount,
        couponId: couponId,
        couponCheck: true,
        amountToPay: amountToPay.round(),
        couponDiscount: couponDiscount,
        walletBalance: walletBalance,
        isWalletUsed: isWalletUsed,
        discount: discount,
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  CartData updateBookingSlot(CartData cartData, String bookingSlot) {
    try {
      return cartData.copyWith(bookingDateTime: bookingSlot);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<CartData> updateCoupon(
      CartData cartData, CouponData? couponData) async {
    try {
      couponRepository.updateCurrentCouponInstance(couponData);

      // await updateCart(cartData);
      return couponData == null
          ? cartData
          : cartData.copyWith(
              couponId: couponData.id,
              couponDiscount: couponData.amount,
              discountPercent: couponData.percent);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  num getAppliedWalletDiscount(
      List<Usage> usage, CartData cartData, num wallet) {
    List<Usage> updatedUsageList = [];
    num discount = 0;
    for (var element in usage) {
      if (cartData.amountToPay! >= element.price) {
        updatedUsageList.add(element);
      }
    }
    for (var element in updatedUsageList) {
      if (wallet >= element.min) {
        if (wallet >= element.max) {
          discount = element.max;
        } else {
          discount = wallet;
        }
      }
    }
    return discount;
  }
}
