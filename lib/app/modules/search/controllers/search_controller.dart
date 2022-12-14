// ignore_for_file: unnecessary_overrides

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../model/shares_list_model.dart';
import '../../../utils/SpUtils.dart';

class SearchController extends GetxController {
  //TODO: Implement SearchController

  final list = <ShareListItem>[].obs;
  final searchController = TextEditingController();

  var token = SpUtils.getString('token') != "" ? SpUtils.getString('token') : null;
  // 获取搜索数据
  getList() async {
    Map<String, dynamic> formData = {
      'summary': searchController.text,
    };
    var data = await request
        .post('shares/all',
            params: {'pageNum': 0, 'pageSize': 20}, data: formData, headers: {'X-ToKen': token})
        .catchError((_) {
      Get.snackbar('网络异常', '请重试');
    });

    ShareListModel shareList = ShareListModel.fromJson({'data': data['content']});
    list.value = shareList.data;
  }

  /// 配合 interval 防抖限流
  final _count = 0.obs;
  add() => _count.value++;

  @override
  void onInit() {
    super.onInit();
    // 更改后一秒回调
    debounce(_count, (value) {
      getList();
    }, time: const Duration(seconds: 1));
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
