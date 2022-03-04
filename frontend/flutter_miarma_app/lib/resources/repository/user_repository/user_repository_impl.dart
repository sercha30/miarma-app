import 'dart:convert';

import 'package:flutter_miarma_app/models/user/user_profile_response.dart';
import 'package:flutter_miarma_app/resources/repository/user_repository/user_repository.dart';
import 'package:flutter_miarma_app/utils/constants.dart';
import 'package:flutter_miarma_app/utils/preferences.dart';
import 'package:http/http.dart' as http;

class UserRepositoryImpl extends UserRepository {
  @override
  Future<UserProfileResponse> fetchUserProfile() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8080/auth/me'), headers: {
      'Authorization':
          'Bearer ${PreferenceUtils.getString(Constants.SHARED_BEARER_TOKEN)}'
    });
    if (response.statusCode == 200) {
      return UserProfileResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user profile');
    }
  }
}
