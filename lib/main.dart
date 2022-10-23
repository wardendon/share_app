import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_app/app/common/themes.dart';

import 'app/data/constant.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/SpUtils.dart';
import 'app/utils/request.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Request request = Request();

void main() async {
  // 请求单例初始化
  request.init(
    baseUrl: baseUrlLocal,
    responseFormat: HttpResponseFormat('code', 'data', 'msg', '1'),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtils.getInstance();
  // 启动
  runApp(
    ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      builder: (context, _) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Share App',
        theme: defaultTheme,
        darkTheme: appDarkTheme,
        themeMode: ThemeMode.light,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    ),
  );
}
