import 'package:flutter_miarma_app/models/post/post_dto.dart';
import 'package:flutter_miarma_app/models/post/post_model.dart';

abstract class PostRepository {
  Future<List<Post>> fetchPosts(String type);
  Future<Post> createPost(PostDto postDto, String imagePath);
}
