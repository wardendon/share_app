import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ExchangeView extends GetView {
  const ExchangeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExchangeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ExchangeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
