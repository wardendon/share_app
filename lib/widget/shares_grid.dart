// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../main.dart';
import '../model/shares_list_model.dart';
import '../pages/share_detail.dart';

class SharesGrid extends StatefulWidget {
  const SharesGrid({Key? key}) : super(key: key);

  @override
  State<SharesGrid> createState() => _SharesGridState();
}

class _SharesGridState extends State<SharesGrid> {
  List<ShareListItem> _list = [];

  _getList() async {
    List<dynamic> data = await request.get('shares/all');
    ShareListModel shareList = ShareListModel.fromJson({'data': data});
    setState(() {
      _list = shareList.data;
    });
  }

  @override
  void initState() {
    super.initState();
    _getList();
  }

  @override
  Widget build(BuildContext context) {
    return _list.isEmpty
        ? const Center(
            child: Text('Loading~~'),
          )
        : GridView.builder(
            padding: EdgeInsets.zero,
            itemCount: _list.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 16 / 7, crossAxisCount: 1, mainAxisSpacing: 20),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ShareDetail(id: _list[index].id)));
                },
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/box${index % 4}.png'), fit: BoxFit.fill),
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
                                _list[index].title,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              Text(
                                _list[index].summary,
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
                                    _list[index].cover,
                                    fit: BoxFit.fitWidth,
                                  )
                                ],
                              ),
                              Positioned(
                                right: 0,
                                child: ElevatedButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: _list[index].isOriginal == 1
                                          ? Colors.orangeAccent
                                          : Colors.green,
                                      elevation: 8),
                                  onPressed: () {},
                                  child: _list[index].isOriginal == 1
                                      ? Text('原创', style: TextStyle(color: Colors.white))
                                      : Text('转载', style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Text(
                                  '${_list[index].price}积分',
                                  style: TextStyle(color: Colors.pink, fontSize: 20),
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
            },
          );
  }
}
