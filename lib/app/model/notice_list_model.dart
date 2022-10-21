/// 创建时间：2022/10/5
/// 作者：w2gd
/// 描述：公告列表

class NoticeListModel {
  NoticeListModel({
    required this.content,
  });
  late final List<Content> content;

  NoticeListModel.fromJson(Map<String, dynamic> json) {
    content = List.from(json['content']).map((e) => Content.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['content'] = content.map((e) => e.toJson()).toList();
    return data;
  }
}

class Content {
  Content({
    required this.id,
    required this.content,
    required this.showFlag,
    required this.createTime,
  });
  late final int id;
  late final String content;
  late final bool showFlag;
  late final String createTime;

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    showFlag = json['showFlag'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['showFlag'] = showFlag;
    data['createTime'] = createTime;
    return data;
  }
}
