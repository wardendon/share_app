// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations
import 'package:flutter/material.dart';
import 'package:share_app/common/text_styles.dart';
import 'package:share_app/main.dart';
import 'package:share_app/model/share_model.dart';
import 'package:url_launcher/url_launcher.dart';

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
  String downloadUrl = '';
  String uri = '';
  String password = '';

  _launchUrl(u) async {
    if (!await launchUrl(Uri.parse(u))) {
      throw 'Could not launch $u';
    }
  }

  getData() async {
    Map<String, dynamic> data = await request.get('shares/${widget.id}');
    ShareModel shareData = ShareModel.fromJson(data);
    setState(() {
      share = shareData.share;
      nickname = shareData.nickName;
      avatar = shareData.avatar;
      downloadUrl = share?.downloadUrl ?? '';
      if (downloadUrl != '') {
        List<String> list = downloadUrl.split(' ');
        uri = list[1];
        password = list[4];
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Share ${share?.id}')),
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
          Container(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            width: MediaQuery.of(context).size.width,
            // color: Colors.cyan,
            child: Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 8,
                // color: Colors.pink,
                child: share?.cover != null
                    ? Center(child: Image.network('${share?.cover}', fit: BoxFit.fitWidth))
                    : SizedBox()),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text('${share?.summary}'),
          ),
          GestureDetector(
              onTap: () => _launchUrl(uri),
              child: Text('下载链接(点击获取)', style: linkText.copyWith(fontSize: 23))),
          Text('密码： $password', style: linkText.copyWith(fontSize: 23)),
        ],
      ),
    );
  }
}
