import 'package:flutter/material.dart';
import 'package:share_app/pages/audit_page.dart';
import 'package:share_app/pages/bonus_detail_page.dart';
import 'package:share_app/pages/contributors_page.dart';
import 'package:share_app/pages/edit_info_page.dart';
import 'package:share_app/pages/exchange_page.dart';
import 'package:share_app/pages/home_page.dart';
import 'package:share_app/pages/login_page.dart';
import 'package:share_app/pages/my_contributors_page.dart';
import 'package:share_app/pages/setting_page.dart';
import 'package:share_app/utils/SpUtils.dart';
import 'package:share_app/utils/request.dart';

import 'common/themes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Request request = Request();

void main() async {
  request.init(
    // baseUrl: 'http://api.w2gd.top:10001/api/v1/', // 远程环境
    baseUrl: 'http://localhost:10001/api/v1/', // 本地环境
    // baseUrl: 'https://875c-221-226-155-12.jp.ngrok.io/api/v1/', // 内网地址穿透
    responseFormat: HttpResponseFormat('code', 'data', 'msg', '1'),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtils.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Share App',
      theme: defaultTheme,
      initialRoute: 'index',
      onGenerateRoute: onGenerateRoute,
    );
  }
}

/// 命名路由 和 路由拦截
Route<dynamic> onGenerateRoute(RouteSettings settings) {
  String? routeName;
  routeName = routeBeforeHook(settings);
  return MaterialPageRoute(builder: (context) {
    /// 注意：如果路由的形式为: '/a/b/c'
    /// 那么将依次检索 '/' -> '/a' -> '/a/b' -> '/a/b/c'
    /// 所以，我这里的路由命名避免使用 '/xxx' 形式
    switch (routeName) {
      case "index":
        return const IndexTab();
      case "login":
        return const LoginPage();
      case "audit":
        return AuditPage();
      case "setting":
        return const SettingPage();
      case "edit":
        return const EditInfoPage();
      case "exchange":
        return const ExchangePage();
      case "my_contribute":
        return const MyContributorsPage();
      case "contribute":
        return const ContributorsPage();
      case "bonus":
        return const BonusDetailPage();
      default:
        return const Scaffold(
          body: Center(
            child: Text("页面不存在"),
          ),
        );
    }
  });
}

String? routeBeforeHook(RouteSettings settings) {
  final String token = SpUtils.getString('token') ?? '';
  if (token != '') {
    if (settings.name == 'login') {
      return 'index';
    }
    return settings.name;
  }
  return 'login';
}
