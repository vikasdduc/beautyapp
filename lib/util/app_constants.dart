import 'dart:core';

import 'package:glamcode/data/model/packages_model/service.dart';

class AppConstants {
  static const String APP_NAME = 'Glam Code';
  static const double APP_VERSION = 1.6;
  static const String THEME = '6ammart_theme';

  static const String domain = "https://admin.glamcode.in/";
  static const String base_url = "https://admin.glamcode.in/api";
//    static const String base_url = "http://18.217.118.237:8081/api"

  static const String home = "$base_url/home/$LOCALIZATION_KEY";
  static const String apiGetPackageById = "$base_url/service";
  // static const String apiBlog = "${base_url}/blogs";
  static const String apiBlog = "https://glamcode.in/blog/wp-json/wp/v2/posts";
  static const String apiCategory = "$base_url/category";
  static const String apiLogin = "$base_url/send-otp-code";
  static const String apiOtpVerify = "$base_url/verify-otp-phone";
  static const String updateProfile = "$base_url/profile/";
  static const String gallery = "$base_url/gallery";
  static const String bookings = "$base_url/bookings/";
  static const String aboutdetails = "$base_url/pages/about";
  static const String privacydetails = "$base_url/pages/privacy";
  static const String termsDetails = "$base_url/pages/terms";
  static const String addonDetails = "$base_url/addons";
  static const String editProfile = "$base_url/profile/"; //{id}
  static const String slotDetails = "$base_url/booking-slots/"; //{id}
  static const String slotLocationWiseDetails = "$base_url/time-slot/";
  
  static const String addOrUpdateProduct = "$base_url/add-or-update-product";
  static const String deleteProduct = "$base_url/delete-cart-product";
  static const String updateCoupon = "$base_url/update-coupon";
  static const String applyCoupon = "$base_url/apply-coupon";
  static const String makePayment =
      "$base_url/make-payment"; //params ?bookingId=470&userId=575

  static const String searchQuery = "$base_url/search?search_term=";
  static const String addAddress = "$base_url/add-address";
  static const String setPrimaryAddress = "$base_url/set-primary-address";
  static const String getAddressDetails = "$base_url/address-details";
  static const String deleteAddress = "$base_url/delete-address";
  static const String updateAddress = "$base_url/update-address";
  static const String myCart = "$base_url/mycart";

  static const String getLocations = "$base_url/location";
  static const String getMainCategories = "$base_url/main-categories";
  static const String getCategories = "$base_url/categorys";
  static const String getPreferredPackages = "$base_url/preferred-pack";
  static const String getCouponsList = "$base_url/couponslist";
  static const String bookingData = "$base_url/booking-data";
  static const String payments = "$base_url/payments";
  static const String bookService = "$base_url/bookservice";
  static const String getExtraFees = "$base_url/extrafees";
  static const String bookingDetails = "$base_url/bookingDetails";
  static const String bookingDataFull = "$base_url/booking-datafull";

  static const String appkeyid =
      r"Qswde@#$@ESCDdreghreiue#%$#^fkjhdhR$$#hvjkdhkdf%^$$#hdgjdf";
  static const String getanydatacall = "$base_url/getanydatacall";

  static const String postcancelreschedule = "$base_url/cancelreschedule";

  static const String TOPIC = 'all_zone_customer';
  static const String ZONE_ID = 'zoneId';
  static const String MODULE_ID = 'moduleId';
  static const String LOCALIZATION_KEY = 'X-localization';

  static const Map<String, dynamic> sampleServicePackageData = {
    "id": 502,
    "name": "Legs Show Off",
    "slug": "legs-show-off-noida",
    "description":
        "<p>&nbsp; Honey Wax - FA ,UA &amp; FL.</p><p>&nbsp; Threading: Eye Brows &amp; Upper Lips&nbsp;</p>",
    "mobile_long_description": null,
    "mobile_long_description2": null,
    "mobile_long_description3": null,
    "mobile_long_description4": null,
    "long_description": null,
    "price": 858,
    "time": 60,
    "sort": null,
    "time_type": "minutes",
    "discount": 50,
    "discount_type": "percent",
    "main_category_id": 33,
    "category_id": 244,
    "sub_category_id": null,
    "packages_id": 0,
    "location_id": 6,
    "image": ["da5d0189bcddf2c6dae17132c5a9cfd5.jpeg.webp"],
    "default_image": "da5d0189bcddf2c6dae17132c5a9cfd5.jpeg.webp",
    "status": "active",
    "prefered_service": "Yes",
    "location_city": "Noida",
    "seo_title": null,
    "seo_desc": null,
    "seo_key": null,
    "created_at": "2021-12-15 03:49:54",
    "updated_at": "2022-12-11 03:54:05",
    "rating_per": "4.75",
    "rating_pop": 12000,
    "service_image_url":
        "https://admin.glamcode.in/user-uploads/service/502/da5d0189bcddf2c6dae17132c5a9cfd5.jpeg.webp",
    "service_detail_url":
        "https://admin.glamcode.in/499-store/legs-show-off-noida",
    "discounted_price": 429,
    "category": {
      "id": 244,
      "main_category_id": "33",
      "name": "499 Store",
      "slug": "499-store",
      "image": "3840a99398a49a9ff7edeaa00976da60.png.webp",
      "status": "active",
      "sort_order": null,
      "created_at": "2021-12-14 21:52:46",
      "updated_at": "2022-11-19 03:24:11",
      "rating_per": "4.75",
      "rating_pop": 12000,
      "category_image_url":
          "https://admin.glamcode.in/user-uploads/subcategory/3840a99398a49a9ff7edeaa00976da60.png.webp"
    }
  };
  static ServicePackage sampleServicePackage =
      ServicePackage.fromMap(sampleServicePackageData);
}
