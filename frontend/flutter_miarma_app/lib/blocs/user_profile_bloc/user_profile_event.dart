part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class GetUserProfile extends UserProfileEvent {
  const GetUserProfile();

  @override
  List<Object> get props => [];
}
