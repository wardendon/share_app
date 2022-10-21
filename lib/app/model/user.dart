class User {
  User({
    required this.id,
    required this.mobile,
    this.password,
    required this.nickname,
    required this.roles,
    required this.avatar,
    this.createTime,
    this.updateTime,
    required this.bonus,
  });
  late int id;
  late String mobile;
  late String? password;
  late String nickname;
  late String roles;
  late String avatar;
  late String? createTime;
  late String? updateTime;
  late int bonus;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mobile = json['mobile'];
    password = json['password'];
    nickname = json['nickname'];
    roles = json['roles'];
    avatar = json['avatar'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    bonus = json['bonus'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['mobile'] = mobile;
    _data['password'] = password;
    _data['nickname'] = nickname;
    _data['roles'] = roles;
    _data['avatar'] = avatar;
    _data['createTime'] = createTime;
    _data['updateTime'] = updateTime;
    _data['bonus'] = bonus;
    return _data;
  }
}
