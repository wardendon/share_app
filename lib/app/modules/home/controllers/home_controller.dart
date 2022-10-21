// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_app/app/utils/SpUtils.dart';

import '../../../../main.dart';
import '../../../model/shares_list_model.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  // 刷新控制器，初始化刷新为false，自定义初始化在 initState 中
  final RefreshController refreshController = RefreshController(initialRefresh: false);

  // 分页参数
  final pageNum = 0.obs;
  final pageSize = 5.obs;
  // 数据列表
  var itemList = <ShareListItem>[].obs;

  var token = SpUtils.getString('token') != "" ? SpUtils.getString('token') : null;

  /// 请求shares列表
  Future<List<ShareListItem>> contentList() async {
    var data = await request.post('shares/all', headers: {'X-ToKen': token});
    ShareListModel shareList = ShareListModel.fromJson({'data': data['content']});
    // 如果为空 则 标记没有更多
    if (shareList.data.isEmpty) {
      refreshController.loadNoData();
      return Future(() => []);
    } else {
      return shareList.data;
    }
  }

  /// 刷新 重新赋值
  void onRefresh() async {
    // 为了显示动画 延迟加载
    await Future.delayed(const Duration(milliseconds: 1000));
    //还原请求参数
    pageNum.value = 0;
    pageSize.value = 5;
    contentList().then((value) => itemList.assignAll(value));
    refreshController.refreshCompleted();
    // 为了重置 没有更多 的显示
    refreshController.loadComplete();
  }

  /// 加载 addAll()
  void onLoading() async {
    // 为了显示动画 延迟加载
    await Future.delayed(const Duration(milliseconds: 1000));
    // 页码 加一 size不变
    pageNum.value++;
    List<ShareListItem> moreData = await contentList();
    itemList.addAll(moreData);
    refreshController.loadComplete();
  }

  @override
  void onInit() {
    super.onInit();
    contentList().then((value) => itemList.assignAll(value));
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
