// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

/// FileName config
/// @Description 全局配置类
class Config {
  /// 主题颜色
  static const int _primaryColorValue = 0xFF8AA58D;
  static const Color primaryColor = Color(_primaryColorValue);
  static const MaterialColor primarySwatchColor = MaterialColor(
    _primaryColorValue,
    <int, Color>{
      50: Color(0xFFBED6C1),
      100: Color(0xFFA9C2AC),
      200: Color(_primaryColorValue),
      300: Color(0xFF6C896F),
      400: Color(0xFF2C646E),
      500: Color(0xFF1A4B57),
      600: Color(0xFF0B3946),
      700: Color(0xFF022D3B),
      800: Color(0xFF092C50),
      900: Color(0xFF2C2647),
    },
  );
}
