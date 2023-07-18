import 'dart:convert';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:glamcode/data/model/additional_fee_model.dart';
import 'package:glamcode/data/model/addon_model/addon_model.dart';
import 'package:glamcode/data/model/address_details_model.dart';
import 'package:glamcode/data/model/about.dart';
import 'package:glamcode/data/model/auth.dart';
import 'package:glamcode/data/model/booking_slots_model.dart';
import 'package:glamcode/data/model/bookings.dart';
import 'package:glamcode/data/model/coupons.dart';
import 'package:glamcode/data/model/gallery.dart';
import 'package:glamcode/data/model/home_page.dart';
import 'package:glamcode/data/model/location_model.dart';
import 'package:glamcode/data/model/main_categories_model.dart';
import 'package:glamcode/data/model/my_cart/my_cart.dart';
import 'package:glamcode/data/model/my_cart/wallet_data.dart';
import 'package:glamcode/data/model/packages_model/packages_model.dart';
import 'package:glamcode/data/model/payments/PaymentResponse.dart';
import 'package:glamcode/data/model/privacy.dart';
import 'package:glamcode/data/model/terms.dart';
import 'package:glamcode/data/model/user.dart';
import 'package:glamcode/util/app_constants.dart';
import 'package:intl/intl.dart';

import '../../view/screens/select_booking/bookingslotmodel.dart';
import '../model/packages_model/preferred_pack_model.dart';

class DioClient {
  final Dio _dio = Dio();
  final _baseUrl = 'https://admin.glamcode.in/api';
  final CookieJar cookieJar = CookieJar();
  final Auth auth = Auth.instance;

  static final instance = DioClient();

  DioClient() {
    _dio.interceptors
      ..add(TokenInterceptor())
      ..add(DioCacheInterceptor(options: options))
      ..add(CookieManager(cookieJar));
    cookieJar.loadForRequest(Uri.parse("https://admin.glamcode.in/"));
  }

  Future<HomePageModel?> getHomePage() async {
    HomePageModel? homePage;
    try {
      Response homePageData = await _dio.get('$_baseUrl/home');
      homePage = HomePageModel.fromJson(homePageData.data);
    } on DioError catch (e) {
      if (e.response != null) {
      } else {}
    }
    return homePage;
  }

  Future<WalletData?> getWalletData() async {
    WalletData? walletData;
    try {
      int? userId = (await auth.currentUser).id;
      if (userId != null) {
        Response walletDataResponse =
            await _dio.get('$_baseUrl/user_wallet_data/$userId');
        walletData = WalletData.fromJson(walletDataResponse.data);
      }
    } on DioError catch (e) {
      if (e.response != null) {
      } else {}
    }
    return walletData;
  }

  Future<Gallery?> getGallery() async {
    Gallery? gallery;
    try {
      Response galleryData = await _dio.get('$_baseUrl/gallery');
      gallery = Gallery.fromJson(galleryData.data);
    } on DioError catch (e) {
      if (e.response != null) {
      } else {}
    }
    return gallery;
  }

  Future<TermsModel?> getTerms() async {
    TermsModel? terms;
    try {
      Response termsData = await _dio.get('$_baseUrl/pages/terms');
      terms = TermsModel.fromJson(termsData.data);
    } on DioError catch (e) {
      if (e.response != null) {
      } else {}
    }
    return terms;
  }

  Future<About?> getAbout() async {
    About? about;
    try {
      Response aboutData = await _dio.get('$_baseUrl/pages/about');
      about = About.fromJson(aboutData.data);
    } on DioError catch (e) {
      if (e.response != null) {
      } else {}
    }
    return about;
  }

  Future<Privacy?> getPrivacy() async {
    Privacy? privacy;
    try {
      Response privacyData = await _dio.get('$_baseUrl/pages/privacy');
      privacy = Privacy.fromJson(privacyData.data);
    } on DioError catch (e) {
      if (e.response != null) {
      } else {}
    }
    return privacy;
  }

  Future<LocationModel?> getLocation() async {
    LocationModel? locationModel;
    try {
      Response locationModelData = await _dio.get('$_baseUrl/location');
      locationModel = LocationModel.fromJson(locationModelData.data);
    } on DioError catch (e) {
      if (e.response != null) {
      } else {}
    }
    return locationModel;
  }

  // Future<UserAddress?> getUser() async {
  //   UserAddress? userAddress;
  //   try {
  //     Response userAddressData =
  //         await _dio.get("https://admin.glamcode.in/api/address/103");
  //     userAddress = UserAddress.fromJson(userAddressData.data);
  //   } on DioError catch (e) {
  //     if (e.response != null) {
  //     } else {}
  //   }
  //   return userAddress;
  // }

  Future<MainCategoriesModel?> getMainCategories() async {
    MainCategoriesModel? mainCategoriesModel;
    try {
      Response mainCategoriesModelData = await _dio.get(
          '$_baseUrl/main-categories/${Auth.instance.prefs.getInt("selectedLocationId")}');
      mainCategoriesModel =
          MainCategoriesModel.fromJson(mainCategoriesModelData.data);
    } on DioError catch (e) {
      if (e.response != null) {
      } else {}
    }
    return mainCategoriesModel;
  }

  Future<Coupons?> getCoupons() async {
    Coupons? couponsModel;
    try {
      Response couponsModelData = await _dio.get(AppConstants.getCouponsList);
      print('coupen model response from server: $couponsModelData');
      couponsModel = Coupons.fromMap(couponsModelData.data);
    } on DioError catch (e) {
      if (e.response != null) {
        const Text("No any Coupans!");
      } else {}
    }
    return couponsModel;
  }

  Future<AddressDetailsModel?> getAddress() async {
    AddressDetailsModel? addressDetailsModel;
    try {
      User currentUser = await auth.currentUser;
      Response addressDetailsModelData =
          await _dio.get("${AppConstants.getAddressDetails}/${currentUser.id}");
      addressDetailsModel =
          AddressDetailsModel.fromJson(addressDetailsModelData.data);
    } on DioError catch (e) {
      if (e.response != null) {
      } else {}
    }
    return addressDetailsModel;
  }

  Future<PreferredPackModel?> getPreferredPack() async {
    PreferredPackModel? preferredPackModel;
    try {
      Response preferredPackModelData = await _dio.get(
          '$_baseUrl/preferred-pack/${Auth.instance.prefs.getInt("selectedLocationId")}');
      preferredPackModel =
          PreferredPackModel.fromMap(preferredPackModelData.data);
    } on DioError catch (e) {
      print(
          "========================================+++++++++++++++++++++++++> $e");
      if (e.response != null) {
      } else {}
    } catch (e) {
      print(
          "========================================+++++++++++++++++++++++++> $e");
    }
    return preferredPackModel;
  }

  Future<PackagesModel?> getAllPackages(int id) async {
    PackagesModel? packagesModel;
    try {
      Response packagesModelData = await _dio.get(
          '$_baseUrl/categorys/$id/${Auth.instance.prefs.getInt("selectedLocationId")}');
      // print("====================================================> ${PreferredPackModel.fromMap(preferredPackModelData.data)}");
      packagesModel = PackagesModel.fromMap(packagesModelData.data);
    } on DioError catch (e) {
      print(
          "========================================+++++++++++++++++++++++++> $e");
      return null;
    } catch (e) {
      print(
          "========================================+++++++++++++++++++++++++> ${e.toString()}");
      return null;
    }
    return packagesModel;
  }

  Future<BookingsModel?> getBookings() async {
    BookingsModel? bookingsModel;
    try {
      User currentUser = await auth.currentUser;
      Response bookingsModelData =
          await _dio.get('$_baseUrl/bookings/${currentUser.id}');
      bookingsModel = BookingsModel.fromJson(bookingsModelData.data);
    } on DioError catch (e) {
      if (e.response != null) {
      } else {}
    }
    return bookingsModel;
  }

  Future<MyCart?> getCart() async {
    MyCart? myCartModel;
    try {
      User currentUser = await auth.currentUser;
      Response myCartModelData =
          await _dio.get('$_baseUrl/mycart/${currentUser.id}');
      myCartModel = MyCart.fromMap(myCartModelData.data);
    } on DioError catch (e) {
      print("==========================================> ${e.response}");
    } catch (e) {
      print("-=-=-=-=-=-=-=-=-=-=-=-=-=-=--=-==-=--==-=-=> ${e.toString()}");
    }
    return myCartModel;
  }

  Future<AddressDetails?> addAddress(AddressDetails addressDetails) async {
    String jsonData = json.encode(addressDetails.toJson());
    AddressDetails res = AddressDetails();
    try {
      Response response = await _dio.post(
        AppConstants.addAddress,
        data: jsonData,
      );
      res = AddressDetails.fromJson(response.data["addressDetail"]);
      print(res.toJson());
    } on DioError catch (e) {
      if (e.response != null) {
      } else {}
      return null;
    }
    return res;
  }

  Future<bool> setPrimaryAddress(AddressDetails addressDetails) async {
    try {
      Response response = await _dio.post(
        "${AppConstants.setPrimaryAddress}/${addressDetails.addressId}",
      );
    } on DioError catch (e) {
      if (e.response != null) {
      } else {}
      return false;
    }
    return true;
  }

  Future<AddressDetails?> editAddress(AddressDetails addressDetails) async {
    String jsonData = json.encode(addressDetails.toJson());
    AddressDetails res = AddressDetails();
    try {
      Response response = await _dio.post(
        AppConstants.addAddress,
        data: jsonData,
      );
      res = AddressDetails.fromJson(response.data["addressDetail"]);
      print(res.toJson());
    } on DioError catch (e) {
      if (e.response != null) {
      } else {}
      return null;
    }
    return res;
  }

  Future<bool> editProfile(User user) async {
    String jsonData = user.toJson();
    print(jsonData);
    try {
      Response response = await _dio.post(
          "${AppConstants.editProfile}${user.id}",
          data: jsonData,
          options: Options(
              contentType: 'application/json',
              followRedirects: true,
              validateStatus: (status) => true,
              headers: {
                "Accept": "application/json",
              }));
      print(response);
    } on DioError catch (e) {
      if (e.response != null) {
      } else {}
      return false;
    }
    return true;
  }

  Future<bool> deleteAddress(int id) async {
    try {
      User currentUser = await auth.currentUser;
      Response response = await _dio.delete(
        "${AppConstants.deleteAddress}/${currentUser.id}/$id",
      );
      print(response);
    } on DioError catch (e) {
      if (e.response != null) {
      } else {}
      return false;
    }
    return true;
  }

  Future<AddonModel?> getAddons() async {
    AddonModel? addonModel;
    try {
      Response addonsModelData = await _dio.get(AppConstants.addonDetails);
      addonModel = AddonModel.fromMap(addonsModelData.data);
    } on DioError catch (e) {
      print("==========================================> ${e.response}");
    } catch (e) {
      print("-=-=-=-=-=-=-=-=-=-=-=-=-=-=--=-==-=--==-=-=> ${e.toString()}");
    }
    return addonModel;
  }

  Future<AdditionalFeeModel?> getAnyDataCall() async {
    AdditionalFeeModel additionalFeeModel;
    Map<String, dynamic> data = {
      "appid": r"Qswde@#$@ESCDdreghreiue#%$#^fkjhdhR$$#hvjkdhkdf%^$$#hdgjdf",
      "coldata": [
        {
          "qrycol": "3",
          "loccol": Auth.instance.prefs.getInt("selectedLocationId"),
          "diskmcol": "10"
        }
      ]
    };

    try {
      Response response = await _dio.post(
        AppConstants.getanydatacall,
        data: data,
      );
      additionalFeeModel = AdditionalFeeModel.fromJson(response.data);
      print(response);
    } on DioError catch (e) {
      if (e.response != null) {
      } else {}
      return null;
    }
    return additionalFeeModel;
  }

  // Future<BookingSlotsModel?> getBookingSlots(DateTime dateTime) async {
  //   User currentUser = await auth.currentUser;
  //   BookingSlotsModel bookingSlotsModel;
  //   final df = DateFormat('yyyy-MM-dd');
  //   Map<String, dynamic> data = {"bookingDate": df.format(dateTime)};
  // try {
  //   Response response = await _dio.post(
  //     '${AppConstants.slotDetails}${currentUser.id}',
  //     //https://admin.glamcode.in/api/booking-slots/
  //     data: data,
  //   );
  //   print(response.toString());
  //   bookingSlotsModel = BookingSlotsModel.fromJson(response.data);
  //   print(response);
  // } on DioError catch (e) {
  //   if (e.response != null) {
  //   } else {}
  //   return null;
  // }
  // return bookingSlotsModel;
  // }

  Future<BookingSlotModel?> getBookingSlots(DateTime dateTime) async {
    User currentUser = await auth.currentUser;
    BookingSlotModel bookingSlotModel;
    final df = DateFormat('yyyy-MM-dd');
    Map<String, dynamic> data = {
      "bookingDate": df.format(dateTime),
      "location_id": 2.toString()
    };
    try {
      Response response = await _dio.post(
        'https://admin.glamcode.in/api/booking-slots',
        //https://admin.glamcode.in/api/booking-slots/
        data: data,
      );
      print(response.toString());
      bookingSlotModel = BookingSlotModel.fromJson(response.data);
      print(response);
    } on DioError catch (e) {
      if (e.response != null) {
      } else {}
      return null;
    }
    return bookingSlotModel;
  }

  Future<PaymentResponseModel?> makePayment(String jsonData) async {
    print("In the data full folder");
    print(jsonData);
    PaymentResponseModel paymentResponseModel = PaymentResponseModel();
    try {
      Response response = await _dio.post(
        AppConstants.bookingDataFull,
        data: jsonData,
      );
      paymentResponseModel = PaymentResponseModel.fromJson(response.data);
      print("print(paymentResponseModel.coupon);");
      print(paymentResponseModel.coupon);
      print(response);
    } on DioError catch (e) {
      if (e.response != null) {
      } else {}
      return null;
    }
    return paymentResponseModel;
  }

  Future<bool?> sendOtp(String phoneNumber, String referlcode) async {
    Map<String, dynamic> data = {
      "mobile": phoneNumber,
      "calling_code": "+91",
      "reffer_code": referlcode,
    };
    String jsonData = json.encode(data);
    try {
      Response response = await _dio.post(
        AppConstants.apiLogin,
        data: data,
      );
      print(response);
    } on DioError catch (e) {
      if (e.response != null) {
      } else {}
      return false;
    }
    return true;
  }

  Future<User?> verifyOtp(String otp, String phoneNumber) async {
    Map<String, dynamic> data = {
      "calling_code": "+91",
      "mobile": phoneNumber,
      "otp": otp
    };
    String jsonData = json.encode(data);
    try {
      Response response = await _dio.post(
        AppConstants.apiOtpVerify,
        data: data,
      );
      return User.fromJson(jsonEncode(response.data["user"]));
    } on DioError catch (e) {
      if (e.response != null) {
      } else {}
      return null;
    }
  }

  Dio get dio => _dio;
}

class TokenInterceptor extends Interceptor {
  //String? authToken = GetStorage().read('authToken');
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //options.headers["authorization"] = "Bearer $authToken";
    print(options.headers);
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}'
        'DATA => ${response.data}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    print(err.response?.data);
    return super.onError(err, handler);
  }
}

// Global options
final options = CacheOptions(
  store: MemCacheStore(),
  policy: CachePolicy.request,
  hitCacheOnErrorExcept: [401, 403],
  maxStale: const Duration(hours: 1),
  priority: CachePriority.high,
);
