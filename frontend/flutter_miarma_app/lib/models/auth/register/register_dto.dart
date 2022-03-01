class RegisterDto {
  String? nick;
  String? email;
  String? nombre;
  String? apellidos;
  String? fechaNacimiento;
  bool? public;
  String? password;
  String? password2;

  RegisterDto(
      {this.nick,
      this.email,
      this.nombre,
      this.apellidos,
      this.fechaNacimiento,
      this.public,
      this.password,
      this.password2});

  RegisterDto.fromJson(Map<String, dynamic> json) {
    nick = json['nick'];
    email = json['email'];
    nombre = json['nombre'];
    apellidos = json['apellidos'];
    fechaNacimiento = json['fechaNacimiento'];
    public = json['public'];
    password = json['password'];
    password2 = json['password2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nick'] = nick;
    data['email'] = email;
    data['nombre'] = nombre;
    data['apellidos'] = apellidos;
    data['fechaNacimiento'] = fechaNacimiento;
    data['public'] = public;
    data['password'] = password;
    data['password2'] = password2;
    return data;
  }
}
