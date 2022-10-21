class ShareModel {
  ShareModel({
    required this.share,
    required this.nickName,
    required this.avatar,
  });
  late final Share share;
  late final String nickName;
  late final String avatar;

  ShareModel.fromJson(Map<String, dynamic> json) {
    share = Share.fromJson(json['share']);
    nickName = json['nickName'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['share'] = share.toJson();
    data['nickName'] = nickName;
    data['avatar'] = avatar;
    return data;
  }
}

class Share {
  Share({
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

  Share.fromJson(Map<String, dynamic> json) {
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
    final data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['title'] = title;
    data['createTime'] = createTime;
    data['updateTime'] = updateTime;
    data['isOriginal'] = isOriginal;
    data['author'] = author;
    data['cover'] = cover;
    data['summary'] = summary;
    data['price'] = price;
    data['downloadUrl'] = downloadUrl;
    data['buyCount'] = buyCount;
    data['showFlag'] = showFlag;
    data['auditStatus'] = auditStatus;
    data['reason'] = reason;
    return data;
  }
}
