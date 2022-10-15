import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_app/constant.dart';
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
  // 保持启动画面
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // 请求单例初始化
  request.init(
    baseUrl: baseUrlLocal,
    responseFormat: HttpResponseFormat('code', 'data', 'msg', '1'),
  );
  await SpUtils.getInstance();
  // 启动
  runApp(const MyApp());
  // 删除启动画面
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Share App',
        theme: defaultTheme,
        initialRoute: 'index',
        onGenerateRoute: onGenerateRoute,
      ),
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
