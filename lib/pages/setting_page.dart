// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_app/common/config.dart';

import '../utils/SpUtils.dart';

/// 创建时间：2022/10/10
/// 作者：w2gd
/// 描述：设置

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        title: Text('设置'),
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
            InkWell(child: ListTile(title: Text('账号与安全'), subtitle: Text('管理账号安全，修改账号密码等'))),
            SizedBox(height: 100),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  SpUtils.clear();
                  Navigator.of(context)..pop();
                },
                style: TextButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('退出账号', style: TextStyle(fontSize: 26)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
