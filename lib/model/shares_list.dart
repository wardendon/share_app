/// 创建时间：2022/9/23
/// 作者：w2gd
/// 描述：

class AllSharesResponse {
  AllSharesResponse({
    required this.code,
    required this.msg,
    required this.data,
  });
  late final int code;
  late final String msg;
  late final List<Data> data;

  AllSharesResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['msg'] = msg;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.userId,
    required this.title,
    required this.createTime,
    required this.updateTime,
    required this.isOriginal,
    required this.author,
    required this.cover,
    required this.summary,
    required this.price,
    required this.downloadUrl,
    required this.buyCount,
    required this.showFlag,
    required this.auditStatus,
    required this.reason,
  });
  late final int id;
  late final int userId;
  late final String title;
  late final String createTime;
  late final String updateTime;
  late final int isOriginal;
  late final String author;
  late final String cover;
  late final String summary;
  late final int price;
  late final String downloadUrl;
  late final int buyCount;
  late final int showFlag;
  late final String auditStatus;
  late final String reason;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    title = json['title'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    isOriginal = json['isOriginal'];
    author = json['author'];
    cover = json['cover'];
    summary = json['summary'];
    price = json['price'];
    downloadUrl = json['downloadUrl'];
    buyCount = json['buyCount'];
    showFlag = json['showFlag'];
    auditStatus = json['auditStatus'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['userId'] = userId;
    _data['title'] = title;
    _data['createTime'] = createTime;
    _data['updateTime'] = updateTime;
    _data['isOriginal'] = isOriginal;
    _data['author'] = author;
    _data['cover'] = cover;
    _data['summary'] = summary;
    _data['price'] = price;
    _data['downloadUrl'] = downloadUrl;
    _data['buyCount'] = buyCount;
    _data['showFlag'] = showFlag;
    _data['auditStatus'] = auditStatus;
    _data['reason'] = reason;
    return _data;
  }
}
