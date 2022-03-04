part of 'user_profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

class UserProfileInitial extends UserProfileState {}

class UserProfileFetched extends UserProfileState {
  final UserProfileResponse userProfileResponse;

  const UserProfileFetched(this.userProfileResponse);

  @override
  List<Object> get props => [userProfileResponse];
}

class UserProfileFetchError extends UserProfileState {
  final String message;
  const UserProfileFetchError(this.message);

  @override
  List<Object> get props => [message];
}
