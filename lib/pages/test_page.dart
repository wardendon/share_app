// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../main.dart';
import '../model/shares_list_model.dart';

/// 创建时间：2022/10/2
/// 作者：w2gd
/// 描述：

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  /// 刷新控制器，初始化刷新为false，自定义初始化在 initState 中
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  /// 分页参数
  int pageNum = 0;
  int pageSize = 5;

  /// FutureBuilder 中的 future 数据
  Future<List<ShareListItem>>? _list;

  /// 请求shares列表
  Future<List<ShareListItem>> contentList() async {
    var data = await request
        .get('http://127.0.0.1:8082/shares/page-shares?pageNum=$pageNum&pageSize=$pageSize');

    ShareListModel shareList = ShareListModel.fromJson({'data': data['content']});

    /// 如果为空 则 标记没有更多
    if (shareList.data.isEmpty) {
      _refreshController.loadNoData();
      return Future(() => []);
    } else {
      return shareList.data;
    }
  }

  // 刷新 重新赋值
  void _onRefresh() async {
    print('刷新中～～～～～～～～·');

    /// 为了显示动画 延迟加载
    await Future.delayed(Duration(milliseconds: 1000));

    /// 还原请求参数
    setState(() {
      pageNum = 0;
      pageSize = 5;
      _list = contentList();
    });
    _refreshController.refreshCompleted();

    /// 为了重置 没有更多 的显示
    _refreshController.loadComplete();
  }

  /// 加载 addAll()
  void _onLoading() async {
    print('加载中～～～～～～～～·');

    /// 为了显示动画 延迟加载
    await Future.delayed(Duration(milliseconds: 1000));

    _list?.then((value) async {
      /// 页码 加一 size不变
      setState(() {
        pageNum++;
      });
      List<ShareListItem> moreData = await contentList();
      value.addAll(moreData);
    });
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    super.initState();
    _list = contentList();
  }

  /// 页面构建用法
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _list,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<ShareListItem> contents = snapshot.data;
            return SizedBox(
              height: snapshot.data.length * 211.toDouble(),
              child: SmartRefresher(
                controller: _refreshController,
                enablePullUp: true,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 16 / 7, crossAxisCount: 1, mainAxisSpacing: 20),
                  itemCount: contents.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/box${index % 4}.png'),
                            fit: BoxFit.fill),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    contents[index].title,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  Text(
                                    contents[index].summary,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    softWrap: true,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.6,
                              child: Stack(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        contents[index].cover,
                                        fit: BoxFit.fitWidth,
                                      )
                                    ],
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: ElevatedButton(
                                      style: TextButton.styleFrom(
                                          backgroundColor: contents[index].isOriginal == 1
                                              ? Colors.orangeAccent
                                              : Colors.green,
                                          elevation: 8),
                                      onPressed: () {},
                                      child: contents[index].isOriginal == 1
                                          ? Text('原创', style: TextStyle(color: Colors.white))
                                          : Text('转载', style: TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Text(
                                      '${contents[index].price}积分',
                                      style: TextStyle(color: Colors.pink, fontSize: 20),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return CupertinoActivityIndicator();
          }
        },
      ),
    );
  }
}
