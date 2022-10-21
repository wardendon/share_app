// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../model/shares_list_model.dart';

/// 创建时间：2022/10/21
/// 作者：w2gd
/// 描述：分享列表

class ShareList extends StatelessWidget {
  List<ShareListItem> list;
  int index;
  ShareList({Key? key, required this.list, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed('/detail', arguments: list[index].id),
      child: Container(
        height: 200.h,
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30.r)),
          image: DecorationImage(
            image: AssetImage('assets/images/box${index % 4}.png'),
            fit: BoxFit.fill,
          ),
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
                      list[index].title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white, fontSize: 23.sp),
                    ),
                    Text(
                      list[index].summary,
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
                          list[index].cover,
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
                          backgroundColor:
                              list[index].isOriginal == 1 ? Colors.orangeAccent : Colors.green,
                          elevation: 8,
                        ),
                        onPressed: () {},
                        child: list[index].isOriginal == 1
                            ? const Text('原创', style: TextStyle(color: Colors.white))
                            : const Text('转载', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Text(
                        '${list[index].price}积分',
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
  }
}
