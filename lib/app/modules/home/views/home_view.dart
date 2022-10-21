import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_app/app/modules/home/controllers/home_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../widget/notice_roll.dart';
import '../../../widget/share_list.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyBuild(context),
    );
  }

  Widget _bodyBuild(context) {
    // 跳转到对应地址
    toLaunchUrl(u) async {
      if (!await launchUrl(Uri.parse(u))) {
        throw 'Could not launch $u';
      }
    }

    return Obx(
      () {
        var list = controller.itemList;
        return SizedBox(
          height: list.length * 211.toDouble(),
          child: SmartRefresher(
            controller: controller.refreshController,
            enablePullDown: true,
            enablePullUp: true,
            onRefresh: controller.onRefresh,
            onLoading: controller.onLoading,
            child: ListView.builder(
              itemCount: list.length + 1,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                if (index == 0) {
                  /// 轮播与公告
                  return Column(
                    children: [
                      SizedBox(
                        height: 250,
                        child: Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () => toLaunchUrl(swiperList[index].adUrl),
                              child: Image.network(
                                swiperList[index].imgUrl,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                          itemCount: swiperList.length,
                          pagination: const SwiperPagination(),
                          control: const SwiperControl(),
                          autoplay: true,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                        child: NoticeRoll(),
                      ),
                    ],
                  );
                } else {
                  return ShareList(list: list, index: index - 1);
                }
              },
            ),
          ),
        );
      },
    );
  }
}

List swiperList = <Advertising>[
  Advertising(
      adUrl: 'https://pub.dev/packages/card_swiper',
      imgUrl: 'http://img.w2gd.top/up/iTab-pkr6ve.png'),
  Advertising(
      adUrl: 'https://pub.dev/packages/card_swiper',
      imgUrl: 'http://img.w2gd.top/up/20220921211845.png'),
  Advertising(
      adUrl: 'https://pub.dev/packages/card_swiper',
      imgUrl: 'http://img.w2gd.top/up/iTab-pkr6ve.png'),
];

class Advertising {
  String imgUrl;
  String adUrl;

  Advertising({required this.imgUrl, required this.adUrl});
}
