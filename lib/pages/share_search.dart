import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_app/common/text_styles.dart';
import 'package:share_app/main.dart';
import 'package:share_app/model/shares_list_model.dart';
import 'package:share_app/pages/share_detail.dart';
import 'package:share_app/utils/SpUtils.dart';

import '../widget/scaled_list.dart';

/// 搜索页
class ShareSearch extends StatefulWidget {
  const ShareSearch({Key? key}) : super(key: key);
  @override
  State<ShareSearch> createState() => _ShareSearchState();
}

class _ShareSearchState extends State<ShareSearch> {
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
  }

  final searchController = TextEditingController();
  var token = SpUtils.getString('token') != "" ? SpUtils.getString('token') : null;
  _getList() async {
    Map<String, dynamic> formData = {
      'summary': searchController.text,
    };
    var data = await request.post('shares/all', data: formData, headers: {'X-ToKen': token});

    ShareListModel shareList = ShareListModel.fromJson({'data': data['content']});
    setState(() {
      _list = shareList.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: _searchBar(context),
        centerTitle: true,
        elevation: 0,
      ),
      body: _list.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 200.h),
                  ScaledList(
                    itemCount: _list.length,
                    itemColor: (index) {
                      return kMixedColors[index % kMixedColors.length];
                    },
                    itemBuilder: (index, selectedIndex) {
                      final share = _list[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => ShareDetail(id: share.id)));
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
                                    color: Colors.white,
                                    fontSize: selectedIndex == index ? 25 : 20),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          : Center(child: Text("哥们，搜点啥？...", style: incorrectMessageStyle.copyWith(fontSize: 40))),
    );
  }

  /// 搜索框
  Widget _searchBar(BuildContext context) {
    return TextField(
      controller: searchController,
      onSubmitted: (v) {
        _getList();
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        suffixIcon: const Icon(
          Icons.search,
          color: Colors.grey,
        ),
        filled: true,
        fillColor: Colors.grey[100],
        hintText: '请输入搜索内容',
        hintStyle: const TextStyle(color: Colors.grey),
      ),
    );
  }
}

class Category {
  final String cover;
  final String title;

  Category({required this.cover, required this.title});
}
