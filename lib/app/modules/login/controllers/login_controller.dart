import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_app/app/modules/personal/controllers/personal_controller.dart';

import '../../../../main.dart';
import '../../../model/user.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/SpUtils.dart';
import '../../../widget/beautiful_alert_dialog.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  PersonalController pc = Get.find();

  /// 用户登录
  Future<void> _login() async {
    var res = await request.post('users/login',
        data: {"mobile": mobileController.text, "password": passwordController.text});

    SpUtils.setString('token', res['token']);
    SpUtils.setInt('id', res['id']);

    /// 获取用户信息并存储
    request.get('users/${res['id']}', headers: {'X-Token': res['token']}).then((data) {
      User user = User.fromJson(data);
      SpUtils.setInt('id', user.id);
      SpUtils.setString('mobile', user.mobile);
      SpUtils.setString('roles', user.roles);
      SpUtils.setString('nickname', user.nickname);
      SpUtils.setString('avatar', user.avatar);
      SpUtils.setInt('bonus', user.bonus);
    }).then((_) {
      // 更新状态
      pc.initUserInfo();
    });
  }

  void login(context) async {
    _login().then((_) {
      Get.offAllNamed(Routes.HOME);
    }).catchError((e) {
      showDialog(
        context: context,
        builder: (_) => BeautifulAlertDialog(
          title: '错误！',
          tip: '请输入正确的账号与密码',
          tapOk: () {
            passwordController.text = '';
          },
        ),
      );
    });
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    mobileController.text = '17314433312';
    passwordController.text = '123123';
  }

  @override
  void onClose() {
    mobileController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
