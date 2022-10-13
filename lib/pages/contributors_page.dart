// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

/// 创建时间：2022/10/13
/// 作者：w2gd
/// 描述：投稿

class ContributorsPage extends StatefulWidget {
  const ContributorsPage({Key? key}) : super(key: key);

  @override
  State<ContributorsPage> createState() => _ContributorsPageState();
}

class _ContributorsPageState extends State<ContributorsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        title: Text('投稿'),
      ),
      body: Container(),
    );
  }
}
