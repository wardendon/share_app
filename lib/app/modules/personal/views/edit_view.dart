import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/config.dart';
import '../../../utils/SpUtils.dart';
import '../../../utils/post_file_to_oss.dart';
import '../controllers/personal_controller.dart';

class EditView extends GetView<PersonalController> {
  const EditView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    controller.nicknameController.text = controller.user.value.nickname;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        title: const Text('编辑个人资料'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          /// 修改头像
          Center(
            child: Hero(
              tag: 'avatar',
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile == null) return;
                      File? img = File(pickedFile.path);
                      uploadImage(img).then((value) {
                        controller.updateAvatar(value).then((_) {
                          controller.user.update((user) {
                            user?.avatar = value;
                          });
                          SpUtils.setString('avatar', value);
                        });
                      });
                    },
                    child: Obx(() {
                      return CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(controller.user.value.avatar),
                      );
                    }),
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
              controller: controller.nicknameController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurpleAccent),
                ),
                labelText: '昵称',
                labelStyle: const TextStyle(fontSize: 30),
                helperText: '修改昵称后点击右边按钮保存',
                suffixIcon: GestureDetector(
                  onTap: () => controller.updateName(context),
                  child: const Icon(Icons.verified, size: 40),
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
