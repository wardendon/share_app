// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

import '../main.dart';
import '../model/notice_list_model.dart';
import 'marquee_widget.dart';

/// 创建时间：2022/10/5
/// 作者：w2gd
/// 描述：公告轮播

class NoticeRoll extends StatefulWidget {
  const NoticeRoll({Key? key}) : super(key: key);

  @override
  State<NoticeRoll> createState() => _NoticeRollState();
}

class _NoticeRollState extends State<NoticeRoll> {
  List<String> _loopList = ["测试公告"];

  /// 获取公告列表
  _getNoticeList() async {
    Map<String, dynamic> data = await request.get('notice/page-notices?pageNum=0&pageSize=2');

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
    return buildMarqueeWidget(_loopList);
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
