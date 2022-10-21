// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

/// 创建时间：2022/10/21
/// 作者：w2gd
/// 描述：404

class UnknownView extends StatelessWidget {
  const UnknownView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('404'),
      ),
      body: Center(
        child: Text('你来到来没有知识到荒漠！', style: TextStyle(fontSize: 40)),
      ),
    );
  }
}
