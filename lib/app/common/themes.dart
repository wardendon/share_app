import 'package:flutter/material.dart';

import 'colors.dart';
import 'config.dart';
import 'text_styles.dart';

/// FileName themes
///
/// @Author mqxu
/// @Date 2022/9/29 09:03
///
/// @Description 自定义主题

final ThemeData defaultTheme = buildDefaultTheme();

ThemeData buildDefaultTheme() {
  return ThemeData(
    useMaterial3: true,
    primarySwatch: Config.primarySwatchColor,
    primaryColor: Config.primaryColor,
    scaffoldBackgroundColor: bgColor,
    appBarTheme: AppBarTheme(
      backgroundColor: Config.primarySwatchColor.shade300,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(inherit: true, color: Colors.white, fontSize: 20),
    ),
    textTheme: TextTheme(button: buttonText), //文本样式
    buttonTheme: ButtonThemeData(
      //按钮主题，最窄150，按钮文本主题复用ButtonTextTheme，圆角边框10，水平垂直留空
      minWidth: 150,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
    ),
    inputDecorationTheme: InputDecorationTheme(
      //文本输入框主题，圆角，内边距
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      contentPadding: const EdgeInsets.all(16.0),
    ),
  );
}

ThemeData appDarkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.red,
  scaffoldBackgroundColor: Colors.black,
);
