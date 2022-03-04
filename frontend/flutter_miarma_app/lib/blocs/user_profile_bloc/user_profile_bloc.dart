import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_miarma_app/models/user/user_profile_response.dart';
import 'package:flutter_miarma_app/resources/repository/user_repository/user_repository.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserRepository userRepository;

  UserProfileBloc(this.userRepository) : super(UserProfileInitial()) {
    on<GetUserProfile>(_userProfileFetched);
  }

  void _userProfileFetched(
      GetUserProfile event, Emitter<UserProfileState> emit) async {
    try {
      final userProfile = await userRepository.fetchUserProfile();
      emit(UserProfileFetched(userProfile));
    } on Exception catch (e) {
      emit(UserProfileFetchError(e.toString()));
    }
  }
}
