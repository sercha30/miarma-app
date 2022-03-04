class UserProfileResponse {
  UserProfileResponse({
    required this.id,
    required this.nick,
    required this.nombre,
    required this.apellidos,
    required this.email,
    required this.avatar,
    required this.rol,
    required this.publicaciones,
  });
  late final String id;
  late final String nick;
  late final String nombre;
  late final String apellidos;
  late final String email;
  late final String avatar;
  late final String rol;
  late final List<dynamic> publicaciones;

  UserProfileResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nick = json['nick'];
    nombre = json['nombre'];
    apellidos = json['apellidos'];
    email = json['email'];
    avatar = json['avatar'];
    rol = json['rol'];
    publicaciones = List.castFrom<dynamic, dynamic>(json['publicaciones']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nick'] = nick;
    _data['nombre'] = nombre;
    _data['apellidos'] = apellidos;
    _data['email'] = email;
    _data['avatar'] = avatar;
    _data['rol'] = rol;
    _data['publicaciones'] = publicaciones;
    return _data;
  }
}
