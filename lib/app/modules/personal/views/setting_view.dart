import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/config.dart';
import '../../../utils/SpUtils.dart';
import '../controllers/personal_controller.dart';

class SettingView extends GetView<PersonalController> {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        title: const Text('设置'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '账号设置',
              style: TextStyle(
                  color: Config.primarySwatchColor.shade400,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const InkWell(
              child: ListTile(
                title: Text('账号与安全'),
                subtitle: Text('管理账号安全，修改账号密码等'),
              ),
            ),
            const SizedBox(height: 100),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await SpUtils.clear();
                  await controller.initUserInfo();
                  Get.back();
                },
                style: TextButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('退出账号', style: TextStyle(fontSize: 26)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
