import 'package:flutter/material.dart';
import 'package:glamcode/util/dimensions.dart';

ThemeData light({Color color = const Color(0xFFFFFFFF)}) => ThemeData(
      fontFamily: 'Roboto',
      appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(color: Colors.black),
          color: Colors.white,
          titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: Dimensions.fontSizeExtraLarge,
              fontWeight: FontWeight.bold)),
      primaryColor: color,
      scaffoldBackgroundColor: const Color(0xFFFFF1F1),
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            foregroundColor: color,
            backgroundColor: const Color(0xFFA854FC),
            minimumSize: const Size(
                double.infinity, Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE),
            padding: const EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_DEFAULT),
            textStyle: TextStyle(fontSize: Dimensions.fontSizeExtraLarge)),
      ), colorScheme: const ColorScheme.light(
          primary: Colors.black, secondary: Colors.white).copyWith(background: const Color(0xFFFFF1F1)),
    );
