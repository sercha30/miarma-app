import 'dart:convert';

import 'package:flutter_miarma_app/models/post_model.dart';
import 'package:flutter_miarma_app/resources/repository/posts_repository.dart/post_repository.dart';
import 'package:flutter_miarma_app/utils/constants.dart';
import 'package:http/http.dart';

class PostRepositoryImpl extends PostRepository {
  final Client _client = Client();

  @override
  Future<List<Post>> fetchPosts(String type) async {
    final response = await _client.get(
        Uri.parse('http://10.0.2.2:8080/post/$type'),
        headers: {'Authorization': 'Bearer ${Constants.token}'});
    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => Post.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
