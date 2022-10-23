import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_app/app/common/config.dart';

import '../../../common/text_styles.dart';
import '../../../widget/share_list.dart';
import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: _searchBar(context),
        centerTitle: true,
        elevation: 0,
      ),
      body: Obx(() {
        var list = controller.list;
        return Container(
          child: list.isNotEmpty
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return ShareList(list: list, index: index);
                      }),
                )
              : Center(
                  child: Text(
                    "哥们，搜点啥？...",
                    style: incorrectMessageStyle.copyWith(
                      fontSize: 40,
                      color: Config.primarySwatchColor,
                    ),
                  ),
                ),
        );
      }),
    );
  }

  /// 搜索框
  Widget _searchBar(BuildContext context) {
    return TextField(
      controller: controller.searchController,
      onChanged: (v) {
        controller.add();
      },
      // onSubmitted: (v) {
      //   controller.getList();
      // },
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
