/// 创建时间：2022/10/22
/// 作者：w2gd
/// 描述：

class ExchangeModel {
  ExchangeModel({
    required this.content,
  });
  late final List<ExchangeItem> content;

  ExchangeModel.fromJson(Map<String, dynamic> json) {
    content = List.from(json['content']).map((e) => ExchangeItem.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['content'] = content.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ExchangeItem {
  ExchangeItem({
    required this.title,
    required this.cover,
    required this.createTime,
  });
  late final String title;
  late final String cover;
  late final String createTime;

  ExchangeItem.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    cover = json['cover'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['cover'] = cover;
    _data['createTime'] = createTime;
    return _data;
  }
}
