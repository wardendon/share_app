// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_app/common/config.dart';
import 'package:share_app/main.dart';
import 'package:share_app/utils/post_file_to_oss.dart';
import 'package:share_app/widget/custom_alert_dialog.dart';

import '../utils/SpUtils.dart';

/// 创建时间：2022/10/10
/// 作者：w2gd
/// 描述：编辑个人资料

class EditInfoPage extends StatefulWidget {
  const EditInfoPage({Key? key}) : super(key: key);

  @override
  State<EditInfoPage> createState() => _EditInfoPageState();
}

class _EditInfoPageState extends State<EditInfoPage> {
  final nicknameController = TextEditingController();
  String? avatarUrl = SpUtils.getString('avatar');

  final ImagePicker _picker = ImagePicker();

  /// 修改昵称
  Future<void> _updateName() async {
    var formData = {'id': SpUtils.getInt('id'), 'nickname': nicknameController.text};
    await request.post('users/update', data: formData, headers: {
      'X-Token': SpUtils.getString('token'),
    });
  }

  /// 修改头像
  Future<void> _updateAvatar(String url) async {
    var formData = {'id': SpUtils.getInt('id'), 'avatar': url};
    await request.post('users/update', data: formData, headers: {
      'X-Token': SpUtils.getString('token'),
    });
  }

  @override
  void initState() {
    super.initState();
    nicknameController.text = SpUtils.getString('nickname') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        title: Text('编辑个人资料'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),

          /// 修改头像
          Center(
            child: Hero(
              tag: 'avatar',
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final XFile? pickedFile =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile == null) return;
                      File? img = File(pickedFile.path);
                      setState(() {
                        uploadImage(img).then((value) {
                          _updateAvatar(value).then((_) {
                            setState(() {
                              avatarUrl = value;
                              SpUtils.setString('avatar', value);
                            });
                          });
                        });
                      });
                    },
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(avatarUrl!),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Icon(Icons.camera, size: 40, color: Config.primarySwatchColor.shade200),
                  ),
                ],
              ),
            ),
          ),

          /// 修改用户名
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 40, 28, 20),
            child: TextField(
              controller: nicknameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                enabledBorder:
                    OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurpleAccent)),
                labelText: '昵称',
                labelStyle: TextStyle(fontSize: 30),
                helperText: '修改昵称后点击右边按钮保存',
                suffixIcon: GestureDetector(
                  onTap: () {
                    _updateName().then((_) {
                      SpUtils.setString('nickname', nicknameController.text);
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
                  },
                  child: Icon(Icons.verified, size: 40),
                ),
                hintText: '请输入昵称',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
