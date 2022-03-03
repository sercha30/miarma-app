part of 'create_post_bloc.dart';

abstract class CreatePostState extends Equatable {
  const CreatePostState();

  @override
  List<Object> get props => [];
}

class CreatePostInitial extends CreatePostState {}

class CreatePostLoadingState extends CreatePostState {}

class CreatePostSuccessState extends CreatePostState {
  final Post post;

  const CreatePostSuccessState(this.post);

  @override
  List<Object> get props => [post];
}

class PostCreateError extends CreatePostState {
  final String message;

  const PostCreateError(this.message);

  @override
  List<Object> get props => [message];
}
