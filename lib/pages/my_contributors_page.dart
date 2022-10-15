// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_app/common/config.dart';
import 'package:share_app/main.dart';
import 'package:share_app/pages/share_detail.dart';

import '../model/shares_list_model.dart';
import '../utils/SpUtils.dart';

/// 创建时间：2022/10/13
/// 作者：w2gd
/// 描述：我的投稿

class MyContributorsPage extends StatelessWidget {
  const MyContributorsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, 'contribute'),
        child: Icon(Icons.add, color: Colors.white, size: 40),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: CustomScrollView(
        anchor: 0,
        scrollDirection: Axis.vertical,
        slivers: <Widget>[_buildSliverAppBar(), _MySharesList()],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 190.h,
      leading: BackButton(color: Colors.white),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        title: Text('我的投稿', style: TextStyle(color: Colors.white)),
        background: Container(
          foregroundDecoration: BoxDecoration(color: Config.primarySwatchColor.withOpacity(.55)),
          child: Image.network('${SpUtils.getString('avatar')}', fit: BoxFit.cover),
        ),
      ),
    );
  }
}

/// 我的投稿数据
class _MySharesList extends StatefulWidget {
  const _MySharesList({Key? key}) : super(key: key);

  @override
  State<_MySharesList> createState() => _MySharesListState();
}

class _MySharesListState extends State<_MySharesList> {
  List<ShareListItem> list = [];

  getMyShares() async {
    List<dynamic> data = await request.get('shares/my-shares?userId=${SpUtils.getInt('id')}');
    ShareListModel shareList = ShareListModel.fromJson({'data': data});
    setState(() {
      list = shareList.data;
    });
  }

  String shareStatus(String status) {
    switch (status) {
      case 'PASS':
        return '审核通过';
      case 'NOT_YET':
        return '尚未审核';
      case 'REJECT':
        return '审核被拒';
      default:
        return '尚未审核';
    }
  }

  @override
  void initState() {
    super.initState();
    getMyShares();
  }

  @override
  Widget build(BuildContext context) {
    return list.isEmpty
        ? SliverToBoxAdapter(
            child: Center(child: Text('你还没有投稿涅')),
          )
        : SliverFixedExtentList(
            itemExtent: 100.h,
            delegate: SliverChildBuilderDelegate(
              childCount: list.length,
              (_, int index) {
                final share = list[index];
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: Config.primarySwatchColor.shade100,
                        ),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ShareDetail(id: share.id)));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            share.cover,
                            width: 100.w,
                            height: 80.h,
                            fit: BoxFit.fitWidth,
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Text(
                              share.title,
                              style: Theme.of(_).textTheme.headline6,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            width: 100.w,
                            child: Text(
                              shareStatus(share.auditStatus),
                              style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
