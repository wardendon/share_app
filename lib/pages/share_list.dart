import 'package:flutter/material.dart';
import 'package:share_app/common/text_styles.dart';
import 'package:share_app/main.dart';
import 'package:share_app/model/shares_list_model.dart';
import 'package:share_app/pages/share_detail.dart';

import '../widget/scaled_list.dart';

class ShareList extends StatefulWidget {
  const ShareList({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  State<ShareList> createState() => _HttpDemoState();
}

class _HttpDemoState extends State<ShareList> {
  final List<Color> kMixedColors = [
    const Color(0xff71A5D7),
    const Color(0xff72CCD4),
    const Color(0xffFBAB57),
    const Color(0xffF8B993),
    const Color(0xff962D17),
    const Color(0xffc657fb),
    const Color(0xfffb8457),
  ];
  List<ShareListItem> _list = [];

  @override
  void initState() {
    super.initState();
    _getList();
  }

  _getList() async {
    List<dynamic> data = await request.get('shares/all');
    ShareListModel shareList = ShareListModel.fromJson({'data': data});
    setState(() {
      _list = shareList.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _list.isNotEmpty
          ? Center(
              child: ScaledList(
                itemCount: _list.length,
                itemColor: (index) {
                  return kMixedColors[index % kMixedColors.length];
                },
                itemBuilder: (index, selectedIndex) {
                  final share = _list[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => ShareDetail(id: share.id)));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: selectedIndex == index ? 100 : 80,
                          child: Image.network(_list[index].cover),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _list[index].title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white, fontSize: selectedIndex == index ? 25 : 20),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          : Center(child: Text("加载中...", style: incorrectMessageStyle.copyWith(fontSize: 40))),
    );
  }
}

class Category {
  final String cover;
  final String title;

  Category({required this.cover, required this.title});
}
