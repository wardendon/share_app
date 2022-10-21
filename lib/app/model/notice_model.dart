class NoticeModel {
  NoticeModel({
    required this.id,
    required this.content,
    required this.showFlag,
    required this.createTime,
  });
  late final int id;
  late final String content;
  late final bool showFlag;
  late final String createTime;

  NoticeModel.fromJson(Map<String, dynamic> json) {
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
