import 'dart:convert';

import 'package:flutter_miarma_app/models/post/post_dto.dart';
import 'package:flutter_miarma_app/models/post/post_model.dart';
import 'package:flutter_miarma_app/resources/repository/posts_repository.dart/post_repository.dart';
import 'package:flutter_miarma_app/utils/constants.dart';
import 'package:flutter_miarma_app/utils/preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class PostRepositoryImpl extends PostRepository {
  @override
  Future<List<Post>> fetchPosts(String type) async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8080/post/$type'), headers: {
      'Authorization':
          'Bearer ${PreferenceUtils.getString(Constants.SHARED_BEARER_TOKEN)}'
    });
    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => Post.fromJson(e))
          .toList();
    } else if (response.statusCode == 404) {
      return List.empty(growable: false);
    } else {
      print(response.statusCode);
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Post> createPost(PostDto postDto, String imagePath) async {
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization':
          'Bearer ${PreferenceUtils.getString(Constants.SHARED_BEARER_TOKEN)}'
    };

    var uri = Uri.parse('http://10.0.2.2:8080/post/');

    var body = jsonEncode({
      'titulo': postDto.titulo,
      'contenido': postDto.contenido,
      'public': postDto.public
    });

    var request = http.MultipartRequest('POST', uri)
      ..files.add(http.MultipartFile.fromString('post', body,
          contentType: MediaType('application', 'json')))
      ..files.add(await http.MultipartFile.fromPath('media', imagePath,
          contentType: MediaType('image', 'jpg')))
      ..headers.addAll(headers);

    final response = await request.send();
    print(response.statusCode);

    if (response.statusCode == 201) {
      return Post.fromJson(jsonDecode(await response.stream.bytesToString()));
    } else {
      throw Exception('Failed to create post');
    }
  }
}
