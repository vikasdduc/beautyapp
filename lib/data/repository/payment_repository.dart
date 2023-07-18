import 'dart:convert';
import 'dart:developer';
import 'package:glamcode/data/api/api_helper.dart';
import 'package:glamcode/data/model/cart_data.dart';
import 'package:glamcode/data/model/coupons.dart';
import 'package:glamcode/data/model/payments/PaymentResponse.dart';
import 'package:glamcode/data/model/payments/booking_data_model.dart';
import 'package:glamcode/data/model/payments/booking_data_services_model.dart';
import 'package:glamcode/data/model/payments/payments_data_model.dart';
import 'package:glamcode/data/model/user.dart';
import 'package:glamcode/data/repository/coupon_repository.dart';
import 'package:glamcode/data/repository/shopping_repository.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../blocs/cart/cart_bloc.dart';
import '../model/addon_model/addon_datum.dart';
import '../model/auth.dart';
import '../model/packages_model/service.dart';

class PaymentRepository {
  Auth auth = Auth.instance;
  DioClient dioClient = DioClient.instance;

  late CartBloc cartBloc;

  Future<PaymentResponseModel?> bookingsApi(
      CartData cartData, String payment) async {
    print("This is cart Data");
    print(cartData);
    try {
      CouponData couponData = await CouponRepository.instance.currentCoupon;
      User user = await auth.currentUser;
      BookingDataModel bookingDataModel = BookingDataModel(
          // couponId: couponData.id == 0 ? null : "${couponData.id}",
          couponId: null,
          userId: user.id,
          bookingDateTime: cartData.bookingDateTime ?? "",
          status: 'pending',
          paymentGateway: payment == "cash" ? "cash" : "RazorPay",
          originalAmount: cartData.originalAmount,
          discount: cartData.discount ?? 0,
          couponDiscount: cartData.couponDiscount ?? 0,
          discountPercent: cartData.discountPercent ?? 0,
          taxName: "",
          taxPercent: 0,
          extraFees: cartData.extraFees ?? 0,
          distanceFee: 0,
          amountToPay: cartData.amountToPay ?? 0,
          paymentStatus: payment == "cash" ? "pending" : "completed",
          source: "online",
          additionalNotes: "");

      PaymentsDataModel paymentsDataModel = PaymentsDataModel(
          currencyId: '2',
          bookingId: '0',
          amount: cartData.amountToPay,
          gateway: payment == "cash" ? "cash" : "RazorPay",
          transactionId: payment == "cash"
              ? "cash_${cartData.amountToPay}${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())}"
              : payment,
          status: payment == "cash" ? "pending" : "completed",
          paidOn: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()));

      List<ServiceData> serviceDataList = [];
      List<AddOn> addonDataList = [];
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      ShoppingRepository shoppingRepository = ShoppingRepository(
          auth: auth,
          dioClient: dioClient,
          sharedPreferences: sharedPreferences);

      Map<ServicePackage, int> servicesList =
          await shoppingRepository.loadCartItems();
      servicesList.forEach((key, value) {
        serviceDataList.add(ServiceData(
            bookingId: "0",
            businessServiceId: key.id,
            quantity: value,
            unitPrice: key.discountedPrice,
            amount: key.discountedPrice));
      });

      List<AddonDatum> addonList = await shoppingRepository.loadAddonItems();
      print(addonList);
      for (var element in addonList) {
        log(jsonEncode(element.toMap()));
        addonDataList.add(AddOn(
            bookingId: "0",
            addName: element.name,
            quantity: 1,
            amount: num.parse(element.price ?? "")));
      }

      BookingDataServicesModel bookingDataServicesModel =
          BookingDataServicesModel(
              serviceData: serviceDataList, addOn: addonDataList);
      print(bookingDataModel.couponId);
      Map<String, dynamic> bookingDataHead = {
        "bookingData": [bookingDataModel.toJson()],
        "paymentsData": [paymentsDataModel.toJson()],
        "servicesData": [bookingDataServicesModel.toJson()]
      };

      var jsonData = jsonEncode(bookingDataHead);
      print("Check For Json data while in payment repositry");
      print(jsonData.toString());
      final response = await dioClient.makePayment(jsonData);
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
