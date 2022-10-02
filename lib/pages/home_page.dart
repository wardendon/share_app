// ignore_for_file: prefer_const_constructors
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:share_app/common/config.dart';
import 'package:share_app/main.dart';
import 'package:share_app/model/notice_model.dart';
import 'package:share_app/pages/personal_center.dart';
import 'package:share_app/pages/share_list.dart';
import 'package:share_app/widget/fancy_tab_bar.dart';

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
    ShareList(),
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
  String _notice = '';

  _getNotice() async {
    Map<String, dynamic> data = await request.get('notice/latest');

    NoticeModel notice = NoticeModel.fromJson(data);

    setState(() {
      _notice = notice.content;
    });
  }

  @override
  void initState() {
    super.initState();
    _getNotice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 300,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.network(
                  swiperList[index],
                  fit: BoxFit.fill,
                );
              },
              itemCount: swiperList.length,
              pagination: SwiperPagination(),
              control: SwiperControl(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Text(
              '最新公告: $_notice',
              style: TextStyle(fontSize: 25, color: Config.primarySwatchColor[400]),
            ),
          ),
        ],
      ),
    );
  }
}

final swiperList = [
  "http://img.w2gd.top/up/iTab-pkr6ve.png",
  "http://img.w2gd.top/up/20220921211845.png"
];
