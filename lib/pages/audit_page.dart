// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_app/common/config.dart';
import 'package:share_app/common/text_styles.dart';
import 'package:share_app/pages/share_detail.dart';

import '../main.dart';
import '../model/shares_list_model.dart';

class AuditPage extends StatelessWidget {
  AuditPage({Key? key}) : super(key: key);

  final tabs = ['待审核', '已通过', '未通过'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.white),
          title: Text('审核', style: whiteText),
          bottom: _buildTabBar(),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: TabBarView(children: const <Widget>[
          AuditStatusList(status: 'NOT_YET'),
          AuditStatusList(status: 'PASS'),
          AuditStatusList(status: 'REJECT'),
        ]),
      ),
    );
  }

  _buildTabBar() => TabBar(
        labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontSize: 19),
        labelColor: Colors.white,
        indicatorWeight: 4,
        indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
        unselectedLabelColor: Config.primarySwatchColor.shade50,
        indicatorColor: Config.primarySwatchColor.shade50,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: tabs.map((e) => Tab(text: e)).toList(),
      );
}

/// 审核状态列表
class AuditStatusList extends StatefulWidget {
  final String status;
  const AuditStatusList({Key? key, required this.status}) : super(key: key);

  @override
  State<AuditStatusList> createState() => _AuditStatusListState();
}

class _AuditStatusListState extends State<AuditStatusList> {
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
        .get('shares/audit-status?pageNum=$pageNum&pageSize=$pageSize&status=${widget.status}');

    ShareListModel shareList = ShareListModel.fromJson({'data': data['content']});

    /// 如果为空 则 标记没有更多
    if (shareList.data.isEmpty) {
      _refreshController.loadNoData();
      return Future(() => []);
    } else {
      return shareList.data;
    }
  }

  /// 刷新 重新赋值
  void _onRefresh() async {
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

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _list,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<ShareListItem> contents = snapshot.data;
          return SizedBox(
            height: snapshot.data.length * 211.toDouble(),
            child: SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              enablePullUp: true,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView.builder(
                  itemCount: contents.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => ShareDetail(id: contents[index].id)))
                            .then((value) {
                          setState(() {
                            if (value) {
                              // print('页面刷新～～·');
                              _onRefresh();
                            }
                          });
                        });
                      },
                      child: Container(
                        height: 200.h,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30.r)),
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
                                width: MediaQuery.of(context).size.width / 2.3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      contents[index].title,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.white, fontSize: 23.sp),
                                    ),
                                    Text(
                                      contents[index].summary,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      softWrap: true,
                                      style: TextStyle(color: Colors.white, fontSize: 18.sp),
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
                                          width: 200.w,
                                          height: 150.h,
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
                                          elevation: 8,
                                        ),
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
                                        style: TextStyle(color: Colors.pink, fontSize: 25.sp),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          );
        } else {
          return CupertinoActivityIndicator();
        }
      },
    );
  }
}
