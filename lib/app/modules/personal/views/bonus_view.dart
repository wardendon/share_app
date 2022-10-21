import 'package:flutter/material.dart';

import 'package:get/get.dart';

class BonusView extends GetView {
  const BonusView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BonusView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'BonusView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
