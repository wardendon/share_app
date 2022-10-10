// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

/// 创建时间：2022/10/10
/// 作者：w2gd
/// 描述：

class CustomAlertDialog extends StatelessWidget {
  final AlertDialogType type;
  final String title;
  final String content;
  final Widget? icon;
  final String buttonLabel;
  final TextStyle titleStyle = TextStyle(
    fontSize: 20.0,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  final TextStyle labelStyle = TextStyle(
    fontSize: 16.0,
    color: Colors.white,
  );

  CustomAlertDialog(
      {Key? key,
      this.title = 'Beautiful title',
      this.content = 'Information to your user describing the situation.',
      this.icon,
      this.type = AlertDialogType.INFO,
      this.buttonLabel = 'Ok'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency, // 背景透明
      child: Container(
        alignment: Alignment.center,
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: icon ??
                    Icon(
                      _getIconForType(type),
                      color: _getColorForType(type),
                      size: 50,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: titleStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              // Divider(color: Colors.grey),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(
              //     content,
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                child: MaterialButton(
                  padding: const EdgeInsets.all(10.0),
                  color: _getColorForType(type),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    buttonLabel,
                    style: labelStyle,
                  ),
                  onPressed: () => Navigator.pop(context, true),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForType(AlertDialogType type) {
    switch (type) {
      case AlertDialogType.SUCCESS:
        return Icons.check_circle;
      case AlertDialogType.INFO:
        return Icons.info;
      case AlertDialogType.WARNING:
        return Icons.warning;
      case AlertDialogType.ERROR:
        return Icons.error;
      default:
        return Icons.android;
    }
  }

  Color _getColorForType(AlertDialogType type) {
    switch (type) {
      case AlertDialogType.WARNING:
        return Colors.orange;
      case AlertDialogType.SUCCESS:
        return Colors.green;
      case AlertDialogType.ERROR:
        return Colors.red;
      case AlertDialogType.INFO:
        return Colors.cyan;
      default:
        return Colors.blue;
    }
  }
}

enum AlertDialogType {
  SUCCESS,
  ERROR,
  WARNING,
  INFO,
}
