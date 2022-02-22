import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_miarma_app/models/post_model.dart';
import 'package:flutter_miarma_app/resources/repository/posts_repository.dart/post_repository.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostRepository postRepository;

  PostsBloc(this.postRepository) : super(PostsInitial()) {
    on<FetchPostWithType>(_postsFetched);
  }

  void _postsFetched(FetchPostWithType event, Emitter<PostsState> emit) async {
    try {
      final posts = await postRepository.fetchPosts(event.type);
      emit(PostsFetched(posts, event.type));
    } on Exception catch (e) {
      emit(PostFetchError(e.toString()));
    }
  }
}
