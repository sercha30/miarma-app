import 'package:flutter_miarma_app/models/post_model.dart';
import 'package:flutter_miarma_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class PostsBloc {
  final _repository = Repository();
  final _publicPostsFetcher = PublishSubject<Post>();

  /*Observable<Post> get allPublicPosts => _publicPostsFetcher.stream;*/
}
