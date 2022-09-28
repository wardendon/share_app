import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:share_app/model/shares_list.dart';

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
  List _list = [];

  @override
  void initState() {
    super.initState();
    // _getData();
  }

  _getData() async {
    var apiUrl = "http://127.0.0.1:8082/shares/all";
    var res = await Dio().get(apiUrl);

    AllSharesResponse resp = AllSharesResponse.fromJson(json.decode(res.toString()));

    // print('aaa====> ${result.data["data"][0]["cover"]}');

    // print(json.decode(result.data)["result"]);

    setState(() {
      // _list = resp.data;
      _list = res.data["data"];
      // _list.add(Category(cover: result.data["data"][0].cover, title: '111'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Shares"),
      ),
      body: _list.isNotEmpty
          ? Center(
              child: ScaledList(
                itemCount: _list.length,
                itemColor: (index) {
                  return kMixedColors[index % kMixedColors.length];
                },
                itemBuilder: (index, selectedIndex) {
                  final category = _list[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: selectedIndex == index ? 100 : 80,
                        child: Image.network(_list[index]["cover"]),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        _list[index]["title"],
                        style: TextStyle(
                            color: Colors.white, fontSize: selectedIndex == index ? 25 : 20),
                      )
                    ],
                  );
                },
              ),
            )
          : const Text("加载中..."),
    );
  }
}

class Category {
  final String cover;
  final String title;

  Category({required this.cover, required this.title});
}
