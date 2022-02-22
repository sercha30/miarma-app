import 'dart:convert';

import 'package:flutter_miarma_app/models/post_model.dart';
import 'package:flutter_miarma_app/resources/repository/posts_repository.dart/post_repository.dart';
import 'package:http/http.dart';

class PostRepositoryImpl extends PostRepository {
  final Client _client = Client();

  @override
  Future<List<Post>> fetchPosts(String type) async {
    final response = await _client
        .get(Uri.parse('http://10.0.2.2:8080/post/$type'), headers: {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJjMGE4MzgwMS03ZjIxLTEwZGEtODE3Zi0yMTgxMDE0MzAwMDAiLCJpYXQiOjE2NDU2MjA5ODMsIm5vbWJyZSI6IlNlcmdpbyIsImFwZWxsaWRvcyI6IkNoYW1vcnJvIEdhcmPDrWEiLCJyb2wiOiJVU1VBUklPIn0.JNrJcVNLGH76M__CHpNO_p4lu8JcI4ITm3vme9JaLvGELGD1nk1ta1CI4-znADNZ'
    });
    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => Post.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
