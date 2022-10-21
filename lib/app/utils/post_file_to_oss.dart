import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

import '../data/constant.dart';

/// 创建时间：2022/9/27
/// 作者：w2gd
/// 描述：上传图片到阿里云OSS

/// Policy为一段经过UTF-8和Base64编码的JSON文本，声明了Post请求必须满足的条件
const String policy = '''
{"expiration": "2120-01-01T12:00:00.000Z","conditions": [["content-length-range", 0, 104857600]]}
''';

///这里yourBucketName替换成你们的BucketName
///oss-cn-hangzhou： Endpoint以杭州为例，其它Region请按实际情况填写
const String url = 'https://w2gd.oss-cn-nanjing.aliyuncs.com';

/// 创建一个 Dio 实例
var dio = Dio();

///获取阿里云oss的加密参数Signature
String getSignature(String encodePolicy) {
  var key = utf8.encode(accessKeySecret);
  var bytes = utf8.encode(encodePolicy);

  var hmacSha1 = Hmac(sha1, key);
  Digest sha1Result = hmacSha1.convert(bytes);
  // print("sha1Result:$sha1Result");

  String signature = base64Encode(sha1Result.bytes);
  // print("signature:$signature");
  return signature;
}

///上传图片到阿里云OSS
Future uploadImage(File imgFile) async {
  ///将Policy进行Base64编码
  String encodePolicy = base64Encode(utf8.encode(policy));

  /// 生成签名
  String signature = getSignature(encodePolicy);

  /// 用 package:path/path.dart 库获取图片名称
  String fileName = basename(imgFile.path);

  /// 让阿里云创建一个flutter的文件夹
  fileName = 'flutter/$fileName';
  var formData = FormData.fromMap({
    'key': fileName,
    'success_action_status': 200,

    ///如果该域的值设置为200或者204，OSS返回一个空文档和相应的状态码。
    'OSSAccessKeyId': ossAccessKeyId,
    'policy': encodePolicy,
    'Signature': signature,
    'file': await MultipartFile.fromFile(imgFile.path),
    'x-oss-content-type': 'image/png',
  });

  ///通过FormData上传文件
  var response = await dio.post(url, data: formData, onSendProgress: (int sent, int total) {
    ///打印 上传数据的进度
    // print('$sent $total');
  });
  // print(response.headers);
  // print("${response.statusCode} ${response.statusMessage}");
  if (response.statusCode == 200) {
    ///图片上传成功
    ///上传图片成功后，该图片的url
    String imageServerPath = '$url/$fileName';
    // print('返回图片的URL:$imageServerPath');
    return imageServerPath;
  }
}
