import 'dart:convert';

import 'package:flutter_miarma_app/models/auth/login_response.dart';
import 'package:flutter_miarma_app/models/auth/login_dto.dart';
import 'package:flutter_miarma_app/resources/repository/auth_repository/auth_repository.dart';
import 'package:flutter_miarma_app/utils/constants.dart';
import 'package:flutter_miarma_app/utils/preferences.dart';
import 'package:http/http.dart';

class AuthRepositoryImpl extends AuthRepository {
  final Client _client = Client();

  @override
  Future<LoginResponse> login(LoginDto loginDto) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${PreferenceUtils.getString(Constants.SHARED_BEARER_TOKEN)}'
    };

    final response = await _client.post(
        Uri.parse('http://10.0.2.2:8080/auth/login'),
        headers: headers,
        body: jsonEncode(loginDto.toJson()));

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Fail to login');
    }
  }
}
