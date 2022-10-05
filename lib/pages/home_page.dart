// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:share_app/pages/personal_center.dart';
import 'package:share_app/pages/test_page.dart';
import 'package:share_app/widget/fancy_tab_bar.dart';

import '../widget/shares_grid.dart';

/// 创建时间：2022/9/23
/// 作者：w2gd
/// 描述：首页

class IndexTab extends StatefulWidget {
  const IndexTab({Key? key}) : super(key: key);

  @override
  State<IndexTab> createState() => _IndexTab();
}

/// Custom BottomAppBar
class _IndexTab extends State<IndexTab> {
  int selectedIndex = 1;
  List containerList = [
    TestPage(),
    // ShareList(),
    HomePage(),
    PersonalCenter(),
  ];

  @override
  Widget build(BuildContext context) {
    return NotificationListener<TabNotification>(
      onNotification: (tabIndex) {
        setState(() {
          selectedIndex = tabIndex.tabIndex;
        });
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.red,
        extendBody: true,
        bottomNavigationBar: FancyTabBar(),
        body: containerList[selectedIndex],
      ),
    );
  }
}

/// 首页
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SharesGrid(),
    );
  }
}

List swiperList = <Advertising>[
  Advertising(
      adUrl: 'https://pub.dev/packages/card_swiper',
      imgUrl: 'http://img.w2gd.top/up/iTab-pkr6ve.png'),
  Advertising(
      adUrl: 'https://pub.dev/packages/card_swiper',
      imgUrl: 'http://img.w2gd.top/up/20220921211845.png'),
];

class Advertising {
  String imgUrl;
  String adUrl;
  Advertising({required this.imgUrl, required this.adUrl});
}
