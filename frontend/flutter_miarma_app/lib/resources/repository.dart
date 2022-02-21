import 'package:flutter_miarma_app/models/post_model.dart';
import 'package:flutter_miarma_app/resources/public_posts_api_provider.dart';

class Repository {
  final publicPostsApiProvider = PublicPostsApiProvider();

  Future<Post> fetchAllPublicPosts() =>
      publicPostsApiProvider.fetchPublicPostList();
}
