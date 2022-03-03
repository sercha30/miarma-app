part of 'create_post_bloc.dart';

abstract class CreatePostEvent extends Equatable {
  const CreatePostEvent();

  @override
  List<Object> get props => [];
}

class CreatePost extends CreatePostEvent {
  final PostDto postDto;
  final String imagePath;

  const CreatePost(this.postDto, this.imagePath);

  @override
  List<Object> get props => [];
}
