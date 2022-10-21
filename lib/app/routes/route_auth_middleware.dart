import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:share_app/app/routes/app_pages.dart';
import 'package:share_app/app/utils/SpUtils.dart';

/// 创建时间：2022/10/21
/// 作者：w2gd
/// 描述：中间件--路由拦截

class RouteAuthMiddleware extends GetMiddleware {
  @override
  // TODO: implement priority
  int? get priority => -1; // 设置优先级priority，优先级越低越先执行
  //重定向，当正在搜索被调用路由的页面时，将调用该函数
  @override
  RouteSettings? redirect(String? route) {
    var token = SpUtils.getString('token');
    if (token == '') {
      Future.delayed(const Duration(seconds: 1), () => Get.snackbar("提示", "请先登录APP"));
      return const RouteSettings(name: Routes.LOGIN);
    } else {
      return super.redirect(route);
    }
  }
}
