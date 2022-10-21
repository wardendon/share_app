// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../main.dart';
import '../../../common/config.dart';
import '../../../utils/SpUtils.dart';
import '../../../utils/post_file_to_oss.dart';
import '../../../widget/beautiful_alert_dialog.dart';
import '../../../widget/custom_alert_dialog.dart';

/// 创建时间：2022/10/13
/// 作者：w2gd
/// 描述：投稿
class ContributorsView extends StatelessWidget {
  const ContributorsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        title: Text('投稿'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.tips_and_updates),
                subtitle: Text(
                  '说明:投稿审核通过后会有积分奖励；资源被下载会有积分奖励，提交的资源不得包含广告，侵权信息，百度盘地址建议有密码。',
                  style: TextStyle(fontSize: 18.sp),
                ),
              ),
              SizedBox(height: 20),
              ShareForm(),
            ],
          ),
        ),
      ),
    );
  }
}

/// 分享表单
class ShareForm extends StatefulWidget {
  const ShareForm({Key? key}) : super(key: key);

  @override
  State<ShareForm> createState() => _ShareFormState();
}

class _ShareFormState extends State<ShareForm> {
  final titleCont = TextEditingController();
  final authorCont = TextEditingController();
  final priceCont = TextEditingController();
  final summaryCont = TextEditingController();
  final downloadCont = TextEditingController();
  final passwordCont = TextEditingController();

  bool _isOriginal = true;
  String imgUrl = '';
  final ImagePicker _picker = ImagePicker();

  /// 上传表单
  Future<void> submitShare() async {
    Map dataForm = {
      'userId': SpUtils.getInt('id'),
      'title': titleCont.text,
      'isOriginal': _isOriginal ? 1 : 0,
      'author': authorCont.text,
      'cover': imgUrl != '' ? imgUrl : null,
      'summary': summaryCont.text,
      'price': priceCont.text.isEmpty ? 0 : int.parse(priceCont.text),
      'downloadUrl': '链接: ${downloadCont.text}  密码: ${passwordCont.text}',
    };
    await request
        .post('shares/add', data: dataForm, headers: {'X-Token': SpUtils.getString('token')});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    titleCont.dispose();
    authorCont.dispose();
    priceCont.dispose();
    summaryCont.dispose();
    downloadCont.dispose();
    passwordCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Table(
          columnWidths: const <int, TableColumnWidth>{
            0: FixedColumnWidth(80),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          border: TableBorder(
              horizontalInside: BorderSide(
            width: 1,
            color: Config.primarySwatchColor,
          )),
          children: [
            _tableItem(
              '原创',
              SizedBox(
                height: 100,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Switch(
                    value: _isOriginal,
                    activeColor: Config.primarySwatchColor.shade300,
                    inactiveThumbColor: Colors.grey,
                    onChanged: (v) {
                      setState(() => _isOriginal = v);
                    },
                  ),
                ),
              ),
            ),
            _tableItem('标题', TextField(controller: titleCont)),
            _tableItem(
                '作者',
                TextField(
                  controller: authorCont,
                )),
            _tableItem(
                '价格',
                TextField(
                  controller: priceCont,
                  keyboardType: TextInputType.number, // 数字键盘
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                )),
            _tableItem(
              '简介',
              TextField(
                controller: summaryCont,
                minLines: 1,
                maxLines: 10,
                decoration: InputDecoration(hintText: '介绍一下技术干货吧～'),
              ),
            ),
            _tableItem(
                '封面图',
                Column(
                  children: [
                    imgUrl != ''
                        ? Container(
                            height: 150,
                            color: Colors.pink,
                            child: Image.network(imgUrl, fit: BoxFit.cover),
                          )
                        : Container(),
                    IconButton(
                      onPressed: () async {
                        final XFile? pickedFile =
                            await _picker.pickImage(source: ImageSource.gallery);
                        if (pickedFile == null) return;
                        File? img = File(pickedFile.path);
                        setState(() {
                          uploadImage(img).then((value) {
                            setState(() {
                              imgUrl = value;
                            });
                          }).catchError((_) {
                            showDialog(
                              context: context,
                              builder: (_) => BeautifulAlertDialog(
                                title: '上传失败！',
                                tip: '请重新上传图片',
                                tapOk: () {},
                              ),
                            );
                          });
                        });
                      },
                      icon: Icon(Icons.upload, color: Colors.green, size: 40),
                      highlightColor: Config.primarySwatchColor.shade100,
                    ),
                  ],
                )),
            _tableItem('链接', TextField(controller: downloadCont)),
            _tableItem('密码', TextField(controller: passwordCont)),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                submitShare().then((value) {
                  showDialog(
                    context: context,
                    builder: (_) => CustomAlertDialog(
                      type: AlertDialogType.SUCCESS,
                      title: "发布成功",
                      tapOk: () {
                        Navigator.of(context)
                          ..pop()
                          ..pop();
                      },
                    ),
                  );
                }).catchError((_) {
                  showDialog(
                    context: context,
                    builder: (_) => CustomAlertDialog(
                      type: AlertDialogType.ERROR,
                      title: "发布失败，请重试",
                    ),
                  );
                });
              },
              style: TextButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Config.primarySwatchColor,
              ),
              child: Text('发布', style: TextStyle(fontSize: 26, color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }

  TableRow _tableItem(String title, child) => TableRow(children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        child
      ]);
}
