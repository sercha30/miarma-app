import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_miarma_app/models/post/post_dto.dart';
import 'package:flutter_miarma_app/models/post/post_model.dart';
import 'package:flutter_miarma_app/resources/repository/posts_repository.dart/post_repository.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  final PostRepository postRepository;

  CreatePostBloc(this.postRepository) : super(CreatePostInitial()) {
    on<CreatePost>(_createPostEvent);
  }

  void _createPostEvent(CreatePost event, Emitter<CreatePostState> emit) async {
    try {
      final postResponse =
          await postRepository.createPost(event.postDto, event.imagePath);
      emit(CreatePostSuccessState(postResponse));
      return;
    } on Exception catch (e) {
      emit(PostCreateError(e.toString()));
    }
  }
}
