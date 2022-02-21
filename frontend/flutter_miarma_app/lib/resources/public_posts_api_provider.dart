import 'dart:convert';

import 'package:flutter_miarma_app/models/post_model.dart';
import 'package:http/http.dart' show Client;

class PublicPostsApiProvider {
  Client client = Client();

  Future<Post> fetchPublicPostList() async {
    final response =
        await client.get(Uri.parse('http://localhost:8080/post/public'));
    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('No se pueden cargar las publicaciones');
    }
  }
}
