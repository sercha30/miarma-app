class RegisterResponse {
  RegisterResponse({
    required this.id,
    required this.nick,
    required this.avatar,
    required this.email,
    required this.rol,
    required this.public,
  });
  late final String id;
  late final String nick;
  late final String avatar;
  late final String email;
  late final String rol;
  late final bool public;

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nick = json['nick'];
    avatar = json['avatar'];
    email = json['email'];
    rol = json['rol'];
    public = json['public'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nick'] = nick;
    _data['avatar'] = avatar;
    _data['email'] = email;
    _data['rol'] = rol;
    _data['public'] = public;
    return _data;
  }
}
