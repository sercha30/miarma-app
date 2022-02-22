class Post {
  String? id;
  String? titulo;
  String? contenido;
  String? media;
  String? nickUsuario;
  String? avatar;
  String? fechaPublicacion;
  bool? public;

  Post({
    this.id,
    this.titulo,
    this.contenido,
    this.media,
    this.nickUsuario,
    this.avatar,
    this.fechaPublicacion,
    this.public,
  });
  Post.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    titulo = json['titulo']?.toString();
    contenido = json['contenido']?.toString();
    media = json['media']?.toString();
    nickUsuario = json['nickUsuario']?.toString();
    avatar = json['avatar']?.toString();
    fechaPublicacion = json['fechaPublicacion']?.toString();
    public = json['public'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['titulo'] = titulo;
    data['contenido'] = contenido;
    data['media'] = media;
    data['nickUsuario'] = nickUsuario;
    data['avatar'] = avatar;
    data['fechaPublicacion'] = fechaPublicacion;
    data['public'] = public;
    return data;
  }
}
