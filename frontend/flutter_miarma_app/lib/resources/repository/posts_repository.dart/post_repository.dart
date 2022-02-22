import 'package:flutter_miarma_app/models/post_model.dart';

abstract class PostRepository {
  Future<List<Post>> fetchPosts(String type);
}
