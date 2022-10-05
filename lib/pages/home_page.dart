// ignore_for_file: prefer_const_constructors
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:share_app/main.dart';
import 'package:share_app/model/notice_model.dart';
import 'package:share_app/pages/personal_center.dart';
import 'package:share_app/pages/share_list.dart';
import 'package:share_app/widget/fancy_tab_bar.dart';
import 'package:share_app/widget/shares_grid.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/notice_list_model.dart';
import '../widget/marquee_widget.dart';

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

  _launchUrl(u) async {
    if (!await launchUrl(Uri.parse(u))) {
      throw 'Could not launch $u';
    }
  }

  List<String> _loopList = ["测试公告"];

  /// 最新公告
  _getNotice() async {
    Map<String, dynamic> data = await request.get('notice/latest');

    NoticeModel notice = NoticeModel.fromJson(data);

    setState(() {
      _notice = notice.content;
    });
  }

  /// 获取公告列表
  _getNoticeList() async {
    Map<String, dynamic> data =
        await request.get('http://127.0.0.1:8084/notice/page-notices?pageNum=0&pageSize=2');

    NoticeListModel noticeList = NoticeListModel.fromJson({'content': data["content"]});
    setState(() {
      for (var value in noticeList.content) {
        _loopList.add(value.content);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getNoticeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => _launchUrl(swiperList[index].adUrl),
                    child: Image.network(
                      swiperList[index].imgUrl,
                      fit: BoxFit.fill,
                    ),
                  );
                },
                itemCount: swiperList.length,
                pagination: SwiperPagination(),
                control: SwiperControl(),
                autoplay: true,
              ),
            ),
            SizedBox(
              height: 30,
              // color: Colors.yellow,
              child: buildMarqueeWidget(_loopList), // 公告滚动
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 70),
              child: SharesGrid(),
            ),
          ],
        ),
      ),
    );
  }

  ///上下轮播
  Widget buildMarqueeWidget(List<String> loopList) {
    return MarqueeWidget(
      //子Item构建器
      itemBuilder: (BuildContext context, int index) {
        String itemStr = loopList[index];
        //通常可以是一个 Text文本
        return Row(
          children: [
            SizedBox(width: 15),
            Icon(Icons.notifications_active),
            Text(itemStr, style: TextStyle(color: Colors.blue, fontSize: 20)),
          ],
        );
      },
      //循环的提示消息数量
      count: loopList.length,
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
