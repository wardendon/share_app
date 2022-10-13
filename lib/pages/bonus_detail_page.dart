// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

/// 创建时间：2022/10/13
/// 作者：w2gd
/// 描述：积分明细

class BonusDetailPage extends StatelessWidget {
  const BonusDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        title: Text('积分明细'),
      ),
      body: Container(),
    );
  }
}
