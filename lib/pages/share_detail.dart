// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:share_app/main.dart';
import 'package:share_app/model/share_model.dart';

/// 创建时间：2022/10/2
/// 作者：w2gd
/// 描述：详情页

class ShareDetail extends StatefulWidget {
  const ShareDetail({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<ShareDetail> createState() => _ShareDetailState();
}

class _ShareDetailState extends State<ShareDetail> {
  Share? share;

  String? nickname;

  String avatar = '';

  getData() async {
    Map<String, dynamic> data = await request.get('shares/${widget.id}');
    ShareModel shareData = ShareModel.fromJson(data);
    setState(() {
      share = shareData.share;
      nickname = shareData.nickName;
      avatar = shareData.avatar;
    });
  }

  @override
  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Share ${share?.id}'),
      ),
      body: Column(
        children: [
          Text('${share?.title}', style: TextStyle(fontSize: 30)),
          ListTile(
            title: Text('$nickname'),
            leading: avatar != ''
                ? Image.network(avatar)
                : Image.network('http://img.w2gd.top/up/user.png'),
            subtitle: Text('${share?.author}'),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text('${share?.summary}'),
          ),
        ],
      ),
    );
  }
}
