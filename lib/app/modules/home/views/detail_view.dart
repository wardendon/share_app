// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_app/app/modules/personal/controllers/personal_controller.dart';
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
  var canShow = Get.parameters['can'];
  Share? share;
  String? nickname;
  String avatar = '';
  String downloadUrl = '';
  String uri = '';
  String password = '';
  String? token = SpUtils.getString('token') ?? '';
  // 是否兑换过（有查看资格）
  // final url = Get.parameters['url'];
  // bool exchanged = Get.parameters['url'] == '' ? false : true;

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

  /// 兑换
  Future exchange() async {
    await request
        .post('shares/exchange', params: {'shareId': id}, headers: {'X-Token': token})
        .then((value) => {
              showDialog(
                  context: context,
                  builder: (_) {
                    var c = Get.find<PersonalController>();
                    c.updateBonus();
                    return Dialog(
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(20),
                        height: 230.h,
                        width: 240.w,
                        child: GestureDetector(
                          onTap: () => _launchUrl(uri),
                          child: Text(
                            '$downloadUrl(点击跳转到网盘)',
                            style: linkText.copyWith(fontSize: 20.sp),
                          ),
                        ),
                      ),
                    );
                  })
            })
        .catchError((_) {
          Get.snackbar('获取失败', '积分不足，请充值');
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(child: Text('${share?.title}', style: TextStyle(fontSize: 30.sp))),
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
                    child: Material(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 8,
                        child: share?.cover != null
                            ? Center(child: Image.network('${share?.cover}', fit: BoxFit.fitWidth))
                            : const SizedBox()),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${share?.summary}', style: TextStyle(fontSize: 20.sp)),
                      Text(
                        '所需积分： ${share?.price}',
                        style: TextStyle(fontSize: 30.sp, color: Colors.green),
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () => exchange(),
                          style: TextButton.styleFrom(
                            backgroundColor: Config.primarySwatchColor,
                          ),
                          child: Text(
                            '获取链接',
                            style: TextStyle(color: Colors.white, fontSize: 20.sp),
                          ),
                        ),
                      )
                      // Text('${Get.parameters['url']}'),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Offstage(
                    offstage: SpUtils.getString('roles') != 'admin',
                    child: Column(
                      children: [
                        Text('状态：${share?.auditStatus}',
                            style: TextStyle(fontSize: 25.sp, color: Colors.red)),
                        GestureDetector(
                          onTap: () => _launchUrl(uri),
                          child: Text(
                            '$downloadUrl(点击跳转到网盘)',
                            style: linkText.copyWith(fontSize: 20.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              /// 管理员审核
              Positioned(
                bottom: 10.h,
                right: 10.h,
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
                        child: const Icon(Icons.done, color: Colors.white),
                      ),
                      SizedBox(height: 20.h),
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
                        child: const Icon(Icons.close, color: Colors.white),
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
