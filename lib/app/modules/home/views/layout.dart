// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:share_app/app/modules/home/views/home_view.dart';
import 'package:share_app/app/modules/personal/views/personal_view.dart';
import 'package:share_app/app/modules/search/views/search_view.dart';
import 'package:share_app/app/widget/fancy_tab_bar.dart';

/// 创建时间：2022/10/20
/// 作者：w2gd
/// 描述：Layout 底部导航切换

class Layout extends StatefulWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int selectedIndex = 1;
  List containerList = [
    SearchView(),
    HomeView(),
    PersonalView(),
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
        extendBody: true,
        bottomNavigationBar: FancyTabBar(),
        body: containerList[selectedIndex],
      ),
    );
  }
}
