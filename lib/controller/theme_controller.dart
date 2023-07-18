import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:glamcode/util/app_constants.dart';

class ThemeController extends GetxController implements GetxService {
  late SharedPreferences sharedPreferences;

  @override
  void onInit() async {
    super.onInit();
    sharedPreferences = await SharedPreferences.getInstance().then((value) {
      _loadCurrentTheme();
      return value;
    });
  }

  bool _darkTheme = false;
  Color? _lightColor;
  Color? _darkColor;

  bool get darkTheme => _darkTheme;
  Color? get darkColor => _darkColor;
  Color? get lightColor => _lightColor;

  void toggleTheme() {
    _darkTheme = !_darkTheme;
    sharedPreferences.setBool(AppConstants.THEME, _darkTheme);
    update();
  }

  void changeTheme(Color lightColor, Color darkColor) {
    _lightColor = lightColor;
    _darkColor = darkColor;
    update();
  }

  void _loadCurrentTheme() async {
    sharedPreferences = await SharedPreferences.getInstance();
    _darkTheme = sharedPreferences.getBool(AppConstants.THEME) ?? false;
    update();
  }
}
