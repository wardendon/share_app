// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

/// 创建时间：2022/10/9
/// 作者：w2gd
/// 描述：弹窗

class BeautifulAlertDialog extends StatelessWidget {
  final VoidCallback? tapOk;
  final String title;
  final String tip;

  const BeautifulAlertDialog(
      {super.key, required this.tapOk, required this.title, required this.tip});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.only(right: 16.0),
          height: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(75),
              bottomLeft: Radius.circular(75),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Row(
            children: <Widget>[
              SizedBox(width: 20.0),
              CircleAvatar(
                radius: 55,
                backgroundColor: Colors.grey.shade200,
                child: Image.network(
                  'https://tva1.sinaimg.cn/large/e6c9d24egy1h62x8em5ztj207p07pjre.jpg',
                  width: 60,
                ),
              ),
              SizedBox(width: 20.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(height: 10.0),
                    Flexible(
                      child: Text(tip),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        // Expanded(
                        //   child: MaterialButton(
                        //     color: Colors.red,
                        //     colorBrightness: Brightness.dark,
                        //     onPressed: () {
                        //       Navigator.pop(context);
                        //     },
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(20.0),
                        //     ),
                        //     child: Text("No"),
                        //   ),
                        // ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: MaterialButton(
                            color: Colors.green,
                            colorBrightness: Brightness.dark,
                            onPressed: () {
                              tapOk!();
                              Navigator.pop(context);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text("OK"),
                          ),
                        ),
                      ],
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
