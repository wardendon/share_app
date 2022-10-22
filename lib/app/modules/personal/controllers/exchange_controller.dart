import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../model/exchange_model.dart';
import '../../../utils/SpUtils.dart';

/// 创建时间：2022/10/22
/// 作者：w2gd
/// 描述：

class ExchangeController extends GetxController {
  final list = <ExchangeItem>[].obs;
  // 获取我的投稿
  getMyExchange() async {
    var data = await request.get(
      'shares/exchange-record',
      params: {'pageNum': 0, 'pageSize': 99},
      headers: {'X-Token': SpUtils.getString('token')},
    );
    ExchangeModel exchangeList = ExchangeModel.fromJson({'content': data['content']});
    list.assignAll(exchangeList.content);
  }

  @override
  void onInit() {
    super.onInit();
    getMyExchange();
  }
}
