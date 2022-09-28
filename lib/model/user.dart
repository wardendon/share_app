class User {
  User({
    required this.id,
    required this.mobile,
    required this.password,
    required this.nickname,
    required this.roles,
    required this.avatar,
    required this.createTime,
    required this.updateTime,
    required this.bonus,
  });
  late final int id;
  late final String mobile;
  late final String password;
  late final String nickname;
  late final String roles;
  late final String avatar;
  late final String createTime;
  late final String updateTime;
  late final int bonus;

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
