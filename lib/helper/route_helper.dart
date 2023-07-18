import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamcode/view/screens/dashboard/dashboard_screen.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';

  static String getInitialRoute() => initial;

  static List<GetPage> routes = [
    GetPage(
        name: initial,
        page: () => getRoute(const DashboardScreen(pageIndex: 0))),
  ];

  static getRoute(Widget navigateTo) {
    //   int minimumVersion = 0;
    //   if(GetPlatform.isAndroid) {
    //     minimumVersion = Get.find<SplashController>().configModel.appMinimumVersionAndroid;
    //   }else if(GetPlatform.isIOS) {
    //     minimumVersion = Get.find<SplashController>().configModel.appMinimumVersionIos;
    //   }
    //   return AppConstants.APP_VERSION < minimumVersion ? const UpdateScreen(isUpdate: true) : navigateTo;
    return navigateTo;
  }
}
