class BonusRecordModel {
  BonusRecordModel({
    required this.content,
  });
  late final List<BonusRecord> content;

  BonusRecordModel.fromJson(Map<String, dynamic> json) {
    content = List.from(json['content']).map((e) => BonusRecord.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['content'] = content.map((e) => e.toJson()).toList();
    return _data;
  }
}

class BonusRecord {
  BonusRecord({
    required this.id,
    required this.userId,
    this.value,
    required this.event,
    required this.createTime,
    required this.description,
  });
  late final int id;
  late final int userId;
  late final String? value;
  late final String event;
  late final String createTime;
  late final String description;

  BonusRecord.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    value = json['value'];
    event = json['event'];
    createTime = json['createTime'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['userId'] = userId;
    _data['value'] = value;
    _data['event'] = event;
    _data['createTime'] = createTime;
    _data['description'] = description;
    return _data;
  }
}
