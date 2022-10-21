// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../model/shares_list_model.dart';
import '../../../utils/SpUtils.dart';

class ContributeController extends GetxController {
  //TODO: Implement ContributeController

  final list = <ShareListItem>[].obs;
  // 获取我的投稿
  getMyShares() async {
    List<dynamic> data = await request.get('shares/my-shares?userId=${SpUtils.getInt('id')}');
    ShareListModel shareList = ShareListModel.fromJson({'data': data});
    list.value = shareList.data;
  }

  String shareStatus(String status) {
    switch (status) {
      case 'PASS':
        return '审核通过';
      case 'NOT_YET':
        return '尚未审核';
      case 'REJECT':
        return '审核被拒';
      default:
        return '尚未审核';
    }
  }

  @override
  void onInit() {
    super.onInit();
    getMyShares();
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
