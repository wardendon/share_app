import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_app/app/modules/personal/controllers/bonus_controller.dart';

import '../../../common/config.dart';
import '../../../utils/SpUtils.dart';

class BonusView extends StatelessWidget {
  const BonusView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        anchor: 0,
        scrollDirection: Axis.vertical,
        slivers: <Widget>[_buildSliverAppBar(), BonusList()],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 190.h,
      leading: const BackButton(color: Colors.white),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        title: const Text('积分明细', style: TextStyle(color: Colors.white)),
        background: Container(
          foregroundDecoration: BoxDecoration(color: Config.primarySwatchColor.withOpacity(.55)),
          child: Image.network('${SpUtils.getString('avatar')}', fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class BonusList extends GetView<BonusController> {
  const BonusList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var list = controller.list;
      return list.isEmpty
          ? SliverToBoxAdapter(child: Center(child: Text('aa')))
          : SliverFixedExtentList(
              itemExtent: 60.h,
              delegate: SliverChildBuilderDelegate(childCount: list.length, (_, int index) {
                final record = list[index];
                return Padding(
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
                    child: ListTile(
                      leading: Text(record.description, style: const TextStyle(fontSize: 20)),
                      subtitle: Text(
                        '${record.value}',
                        style: const TextStyle(fontSize: 30),
                      ),
                      trailing: Text(record.createTime),
                    ),
                  ),
                );
              }),
            );
    });
  }
}
