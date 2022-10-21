// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_app/app/modules/personal/controllers/contribute_controller.dart';

import '../../../common/config.dart';
import '../../../utils/SpUtils.dart';

class MyContributorsView extends GetView<ContributeController> {
  const MyContributorsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/personal/contribute')?.then((_) => controller.getMyShares()),
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
class _MySharesList extends GetView<ContributeController> {
  const _MySharesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        child: controller.list.isEmpty
            ? SliverToBoxAdapter(
                child: Center(child: Text('你还没有投稿涅')),
              )
            : SliverFixedExtentList(
                itemExtent: 100.h,
                delegate: SliverChildBuilderDelegate(
                  childCount: controller.list.length,
                  (_, int index) {
                    final share = controller.list[index];
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
                          onTap: () => Get.toNamed('/detail', arguments: share.id),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(share.cover,
                                  width: 100.w, height: 80.h, fit: BoxFit.fitWidth),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Text(share.title, style: Theme.of(_).textTheme.headline6),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 100.w,
                                child: Text(
                                  controller.shareStatus(share.auditStatus),
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
              ),
      );
    });
  }
}
