import 'package:flutter_miarma_app/models/user/user_profile_response.dart';

abstract class UserRepository {
  Future<UserProfileResponse> fetchUserProfile();
}
