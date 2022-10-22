import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../model/bonus_record_model.dart';
import '../../../utils/SpUtils.dart';

/// 创建时间：2022/10/22
/// 作者：w2gd
/// 描述：

class BonusController extends GetxController {
  final list = <BonusRecord>[].obs;
  // 获取我的积分明细
  getBonusRecord() async {
    var data = await request.get(
      'users/bonus-record',
      params: {'pageNum': 0, 'pageSize': 99},
      headers: {'X-Token': SpUtils.getString('token')},
    );
    BonusRecordModel bonusRecord = BonusRecordModel.fromJson({'content': data['content']});
    for (var item in bonusRecord.content) {
      list.addIf(item.value != null, item);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getBonusRecord();
  }
}
