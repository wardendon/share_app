// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

/// 创建时间：2022/10/13
/// 作者：w2gd
/// 描述：我的兑换

class ExchangePage extends StatelessWidget {
  const ExchangePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        title: Text('我的兑换'),
      ),
      body: Container(),
    );
  }
}
