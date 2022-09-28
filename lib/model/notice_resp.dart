/// 创建时间：2022/9/23
/// 作者：w2gd
/// 描述：

class NoticeResponse {
  NoticeResponse({
    required this.code,
    required this.msg,
    required this.data,
  });
  late final int code;
  late final String msg;
  late final Data data;

  NoticeResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['msg'] = msg;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.content,
    required this.showFlag,
    required this.createTime,
  });
  late final int id;
  late final String content;
  late final bool showFlag;
  late final String createTime;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    showFlag = json['showFlag'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['content'] = content;
    _data['showFlag'] = showFlag;
    _data['createTime'] = createTime;
    return _data;
  }
}
