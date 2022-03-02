class PostDto {
  String? titulo;
  String? contenido;
  bool? public;

  PostDto({this.titulo, this.contenido, this.public});

  PostDto.fromJson(Map<String, dynamic> json) {
    titulo = json['titulo'];
    contenido = json['contenido'];
    public = json['public'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['titulo'] = titulo;
    data['contenido'] = contenido;
    data['public'] = public;
    return data;
  }
}
