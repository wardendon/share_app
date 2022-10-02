import 'package:flutter/material.dart';
import 'package:share_app/pages/home_page.dart';
import 'package:share_app/pages/login_page.dart';
import 'package:share_app/pages/share_list.dart';
import 'package:share_app/utils/SpUtils.dart';
import 'package:share_app/utils/request.dart';

import 'common/themes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Request request = Request();

void main() async {
  request.init(
    baseUrl: 'http://api.w2gd.top:10001/api/v1/',
    responseFormat: HttpResponseFormat('code', 'data', 'msg', '1'),
  );

  runApp(const MyApp());

  WidgetsFlutterBinding.ensureInitialized();
  await SpUtils.getInstance();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Share App',
      theme: defaultTheme,
      initialRoute: '/login',
      routes: {
        '/': (context) => const IndexTab(),
        '/login': (context) => const LoginPage(),
        '/allShares': (context) => const ShareList(),
      },
    );
  }
}
