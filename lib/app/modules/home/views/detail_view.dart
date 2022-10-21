// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../main.dart';
import '../../../common/config.dart';
import '../../../common/text_styles.dart';
import '../../../model/share_model.dart';
import '../../../utils/SpUtils.dart';
import '../../../widget/beautiful_alert_dialog.dart';

/// 创建时间：2022/10/2
/// 作者：w2gd
/// 描述：详情页
class DetailView extends StatefulWidget {
  @override
  State<DetailView> createState() => _ShareDetailState();
}

class _ShareDetailState extends State<DetailView> {
  var id = Get.arguments;
  Share? share;
  String? nickname;
  String avatar = '';
  String downloadUrl = '';
  String uri = '';
  String password = '';
  String? token = SpUtils.getString('token') ?? '';

  _launchUrl(u) async {
    if (!await launchUrl(Uri.parse(u))) {
      throw 'Could not launch $u';
    }
  }

  /// 根据id 获取分享
  getData() async {
    Map<String, dynamic> data = await request.get('shares/$id', headers: {'X-Token': token});
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

  /// 审核
  Future<void> _auditShare(String type, String reason, bool show) async {
    await request.post('admin/verify',
        headers: {'X-Token': token},
        data: {'id': share?.id, 'shareAuditEnums': type, 'reason': reason, 'showFlag': show});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.pop(context, false),
            child: const Icon(Icons.arrow_back_ios, color: Colors.white)),
        title: Text('Share ${share?.id}', style: whiteText),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              Column(
                children: [
                  Text('${share?.title}', style: const TextStyle(fontSize: 30)),
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
                        child: share?.cover != null
                            ? Center(child: Image.network('${share?.cover}', fit: BoxFit.fitWidth))
                            : const SizedBox()),
                  ),
                  Text('${share?.summary}'),
                  GestureDetector(
                    onTap: () => _launchUrl(uri),
                    child: Text(
                      '下载链接(点击获取)',
                      style: linkText.copyWith(fontSize: 23),
                    ),
                  ),
                  Text('密码： $password', style: linkText.copyWith(fontSize: 23)),
                  const SizedBox(height: 30),
                  Offstage(
                    offstage: SpUtils.getString('roles') != 'admin',
                    child: Text('状态：${share?.auditStatus}',
                        style: const TextStyle(fontSize: 25, color: Colors.red)),
                  ),
                ],
              ),

              /// 管理员审核
              Positioned(
                bottom: 40,
                right: 10,
                child: Offstage(
                  offstage: SpUtils.getString('roles') != 'admin',
                  child: Column(
                    children: [
                      FloatingActionButton(
                        heroTag: 'pass',
                        onPressed: () => showDialog(
                          context: context,
                          builder: (_) => BeautifulAlertDialog(
                            title: 'PASS',
                            tip: '点击 Ok 后将提交通过请求',
                            tapOk: () {
                              _auditShare('PASS', 'succeed', true)
                                  .then((_) => Navigator.pop(context, true));
                            },
                          ),
                        ),
                        backgroundColor: Config.primaryColor,
                        child: const Icon(Icons.done),
                      ),
                      const SizedBox(height: 20),
                      FloatingActionButton(
                        heroTag: 'reject',
                        onPressed: () => showDialog(
                          context: context,
                          builder: (_) => BeautifulAlertDialog(
                            title: 'REJECT',
                            tip: '该分享将不被通过',
                            tapOk: () {
                              _auditShare('REJECT', 'fail', false)
                                  .then((_) => Navigator.pop(context, true));
                            },
                          ),
                        ),
                        backgroundColor: Colors.red,
                        child: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
