import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_app/common/config.dart';
import 'package:share_app/main.dart';

import '../utils/SpUtils.dart';

class PersonalCenter extends StatefulWidget {
  const PersonalCenter({Key? key}) : super(key: key);

  @override
  State<PersonalCenter> createState() => _PersonalCenterState();
}

class _PersonalCenterState extends State<PersonalCenter> {
  Future _getBonus() async {
    var data = await request.get('users/bonus', params: {"id": SpUtils.getInt('id')});
    return data['bonus'];
  }

  int bonus = 0;

  @override
  void initState() {
    super.initState();
    _getBonus().then((value) {
      setState(() {
        bonus = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark, statusBarIconBrightness: Brightness.dark);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const Text(''),
        actions: [
          const Icon(Icons.dark_mode_outlined),
          // Icon(Icons.dark_mode),
          const SizedBox(width: 10),
          InkWell(
              onTap: () => Navigator.pushNamed(context, 'setting').then((_) {
                    setState(() {});
                  }),
              child: const Icon(Icons.settings_outlined)),
          const SizedBox(width: 20)
        ],
        actionsIconTheme: IconThemeData(color: Config.primarySwatchColor.shade400, size: 30),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
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
              margin: const EdgeInsets.fromLTRB(16, 90, 16, 16),
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
                      Hero(
                        tag: 'avatar',
                        child: Container(
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
                                Navigator.pushNamed(context, 'edit').then((_) {
                                  setState(() {});
                                });
                              },
                              child: const Icon(Icons.exit_to_app, size: 40)),
                        ),
                        const Divider(color: Colors.grey),
                        // 去除ListView在没有AppBar一起使用时的留白区域
                        MediaQuery.removePadding(
                          removeBottom: true,
                          context: context,
                          child: Container(
                            child: SpUtils.getString('token') != ''
                                ? ListView.separated(
                                    separatorBuilder: (context, index) => const Divider(
                                        height: 1, color: Colors.grey, indent: 16, endIndent: 16),
                                    itemCount: infoList.length,
                                    itemBuilder: (context, index) => SizedBox(
                                      height: 63,
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.pushNamed(context, infoList[index].subTitle);
                                        },
                                        leading: Icon(infoList[index].icon, size: 30),
                                        title: Text(infoList[index].title),
                                        trailing: const Icon(Icons.keyboard_arrow_right, size: 30),
                                      ),
                                    ),
                                    shrinkWrap: true,
                                  )
                                : Container(),
                          ),
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
        Container(
            child: SpUtils.getString('nickname') != ''
                ? Text("${SpUtils.getString('nickname')}",
                    style: Theme.of(context).textTheme.headline4)
                : GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'login');
                    },
                    child: Text('点我登录 >', style: Theme.of(context).textTheme.headline4),
                  )),
        Text(SpUtils.getString('roles') == 'admin' ? '管理员' : '用户'),
        const SizedBox(height: 10),
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
          children: [Text('$bonus'), const Text('Bonus')],
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
  Info(Icons.star_half, '我的兑换', 'exchange'),
  Info(Icons.support, '积分明细', 'bonus'),
  Info(Icons.person, '我的投稿', 'my_contribute'),
];
