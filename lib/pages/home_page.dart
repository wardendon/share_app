// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:share_app/model/notice_resp.dart';
import 'package:share_app/pages/personal_center.dart';
import 'package:share_app/utils/SpUtils.dart';

/// 创建时间：2022/9/23
/// 作者：w2gd
/// 描述：首页

/// Navbar
class IndexTab extends StatefulWidget {
  const IndexTab({Key? key}) : super(key: key);

  @override
  State<IndexTab> createState() => _IndexTabState();
}

class _IndexTabState extends State<IndexTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: TabBarView(
          children: const [
            HomePage(),
            HomePage(),
            HomePage(),
            PersonalCenter(),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: const Color(0xffc0869b),
          shape: CircularNotchedRectangle(),
          notchMargin: 8,
          child: TabBar(
            tabs: const [
              Tab(icon: Icon(Icons.home), text: '首页'),
              Tab(icon: Icon(Icons.video_camera_back), text: '想法'),
              Tab(icon: Icon(Icons.share), text: '分享'),
              Tab(icon: Icon(Icons.person), text: '我的'),
            ],
            unselectedLabelColor: Colors.white,
            labelColor: Colors.pink,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.pinkAccent,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xffc0869b),
          onPressed: () {
            SpUtils.clear();
            setState(() {});
          },
          child: const Icon(Icons.add, size: 36),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
    Dio dio = Dio();
    var apiNotice = "http://127.0.0.1:8082/notice/latest";
    var res = await dio.get(apiNotice);

    NoticeResponse resp = NoticeResponse.fromJson(json.decode(res.toString()));

    var notice = resp.data.content;
    // print('最新通知====> ${notice}');
    setState(() {
      _notice = notice;
    });
  }

  @override
  void initState() {
    super.initState();
    // _getNotice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: Text(''),
      //   centerTitle: true,
      //   title: Text('Share'),
      // ),
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
              style: TextStyle(fontSize: 25, color: Colors.pinkAccent),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/allShares'),
              child: Text('AllShares'),
            ),
          ),
          Text("用户：${SpUtils.getString('nickname')}"),
          Text("mobile：${SpUtils.getString('mobile')}"),
          Text("avatar：${SpUtils.getString('avatar')}"),
          Text("id：${SpUtils.getInt('id')}"),
          // CircleAvatar(
          //   radius: 100,
          //   child: Image.network(''),
          // ),
        ],
      ),
    );
  }
}

final swiperList = [
  "http://img.w2gd.top/up/iTab-pkr6ve.png",
  "http://img.w2gd.top/up/20220921211845.png"
];
