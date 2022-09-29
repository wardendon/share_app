import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_app/common/config.dart';

import '../utils/SpUtils.dart';

class PersonalCenter extends StatefulWidget {
  const PersonalCenter({Key? key}) : super(key: key);

  @override
  State<PersonalCenter> createState() => _PersonalCenterState();
}

class _PersonalCenterState extends State<PersonalCenter> {
  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark, statusBarIconBrightness: Brightness.dark);
    return Scaffold(
      backgroundColor: Colors.indigo.shade100,
      body: Stack(
        children: <Widget>[
          Container(
            // 背景底图，用媒体查询来自适应高度
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            foregroundDecoration: BoxDecoration(
              color: Config.primarySwatchColor.withOpacity(.45),
            ),
            child: Image.network(
              'http://img.w2gd.top/up/20220926211720.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 120, 16, 16),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(top: 32), //这个很重要，让头像上浮
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(180), // 玻璃拟态色
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(left: 100), //名片上半部分留出左边距
                              child: _buildColumn(context), //构建名片上半部分
                            ),
                            const SizedBox(height: 5),
                            _buildRow(), //构建名片下半部分
                          ],
                        ),
                      ),
                      // 头像
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(SpUtils.getString('avatar') != ''
                                ? '${SpUtils.getString('avatar')}'
                                : 'http://img.w2gd.top/up/user.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        margin: const EdgeInsets.only(left: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Card(
                    color: Colors.white.withAlpha(160),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            "User Information",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          leading: const Icon(Icons.person),
                          trailing: GestureDetector(
                              onTap: () {
                                SpUtils.clear();
                                setState(() {});
                              },
                              child: const Icon(Icons.exit_to_app, size: 40)),
                        ),
                        Container(
                          child: SpUtils.getString('nickname') != ''
                              ? ListView(
                                  shrinkWrap: true,
                                  children: infoList
                                      .map((info) => SizedBox(
                                          height: 80,
                                          child: ListTile(
                                            title: Text(info.title),
                                            subtitle: Text(info.subTitle),
                                            leading: Icon(info.icon),
                                          )))
                                      .toList())
                              : Container(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建名片上方区域
  Column _buildColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          SpUtils.getString('nickname') != '' ? "${SpUtils.getString('nickname')}" : '点我登录 >',
          style: Theme.of(context).textTheme.headline4,
        ),
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          title: const Text("Flutter Developer"),
          subtitle: Text("${SpUtils.getString('nickname')}"),
        ),
      ],
    );
  }

  /// 构建名片下方一行三列区域
  Row _buildRow() {
    return Row(
      children: [
        Expanded(
            child: Column(
          children: const [Text('14451'), Text('Likes')],
        )),
        Expanded(
            child: Column(
          children: const [Text('4312'), Text('Comments')],
        )),
        Expanded(
            child: Column(
          children: const [Text('14514'), Text('Favourites')],
        ))
      ],
    );
  }
}

//封装下方列表数据
class Info {
  IconData icon;
  String title;
  String subTitle;
  Info(this.icon, this.title, this.subTitle);
}

List<Info> infoList = [
  Info(Icons.email, 'Email', 'w2gdong@gmail.com'),
  Info(Icons.phone, 'Phone', '+86-${SpUtils.getString('mobile')}'),
  Info(Icons.web, 'Website', 'https://www.w2gd.top'),
  Info(Icons.code, 'Github', 'https://www.wradendon.com'),
  Info(Icons.calendar_view_day, 'Join Date', '12 September 2022'),
];
