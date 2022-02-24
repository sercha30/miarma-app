class Post {
  String? id;
  String? titulo;
  String? contenido;
  String? originalMedia;
  String? transformedMedia;
  String? nickUsuario;
  String? avatar;
  String? fechaPublicacion;
  bool? public;

  Post({
    this.id,
    this.titulo,
    this.contenido,
    this.originalMedia,
    this.transformedMedia,
    this.nickUsuario,
    this.avatar,
    this.fechaPublicacion,
    this.public,
  });
  Post.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    titulo = json['titulo']?.toString();
    contenido = json['contenido']?.toString();
    originalMedia = json['originalMedia']?.toString();
    transformedMedia = json['transformedMedia']?.toString();
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
    data['originalMedia'] = originalMedia;
    data['transformedMedia'] = transformedMedia;
    data['nickUsuario'] = nickUsuario;
    data['avatar'] = avatar;
    data['fechaPublicacion'] = fechaPublicacion;
    data['public'] = public;
    return data;
  }
}
