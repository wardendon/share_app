// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../model/user.dart';
import '../../../utils/SpUtils.dart';
import '../../../widget/custom_alert_dialog.dart';

class PersonalController extends GetxController {
  //TODO: Implement PersonalController
  final user = User(
    id: SpUtils.getInt('id') as int,
    nickname: SpUtils.getString('nickname') as String,
    roles: SpUtils.getString('roles') as String,
    avatar: SpUtils.getString('avatar') as String,
    bonus: SpUtils.getInt('bonus') as int,
    mobile: SpUtils.getString('mobile') as String,
  ).obs;

  /// 用户信息初始化
  initUserInfo() {
    user(User(
      id: SpUtils.getInt('id') as int,
      nickname: SpUtils.getString('nickname') as String,
      roles: SpUtils.getString('roles') as String,
      avatar: SpUtils.getString('avatar') as String,
      bonus: SpUtils.getInt('bonus') as int,
      mobile: SpUtils.getString('mobile') as String,
    ));
  }

  _getBonus() async {
    var data = await request.get('users/bonus', params: {"id": SpUtils.getInt('id')});
    user.update((user) => user?.bonus = data['bonus']);
  }

  final nicknameController = TextEditingController();

  /// 修改昵称
  Future<void> _updateName() async {
    var formData = {'id': SpUtils.getInt('id'), 'nickname': nicknameController.text};
    await request.post('users/update', data: formData, headers: {
      'X-Token': SpUtils.getString('token'),
    });
  }

  updateName(context) {
    _updateName().then((_) {
      SpUtils.setString('nickname', nicknameController.text);
      user.update((val) {
        val?.nickname = nicknameController.text;
      });
      showDialog(
        context: context,
        builder: (_) => CustomAlertDialog(
          type: AlertDialogType.SUCCESS,
          title: "修改成功",
        ),
      );
    }).catchError((_) {
      showDialog(
        context: context,
        builder: (_) => CustomAlertDialog(
          type: AlertDialogType.ERROR,
          title: "修改失败，请重试",
        ),
      );
    });
  }

  /// 修改头像
  Future<void> updateAvatar(String url) async {
    var formData = {'id': SpUtils.getInt('id'), 'avatar': url};
    await request.post('users/update', data: formData, headers: {
      'X-Token': SpUtils.getString('token'),
    });
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
