import 'dart:convert';

import 'package:flutter_miarma_app/models/auth/login/login_response.dart';
import 'package:flutter_miarma_app/models/auth/login/login_dto.dart';
import 'package:flutter_miarma_app/models/auth/register/register_response.dart';
import 'package:flutter_miarma_app/models/auth/register/register_dto.dart';
import 'package:flutter_miarma_app/resources/repository/auth_repository/auth_repository.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<LoginResponse> login(LoginDto loginDto) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      /*'Authorization':
          'Bearer ${PreferenceUtils.getString(Constants.SHARED_BEARER_TOKEN)}'*/
    };

    final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/auth/login'),
        headers: headers,
        body: jsonEncode(loginDto.toJson()));

    if (response.statusCode == 201) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }

  @override
  Future<RegisterResponse> register(
      RegisterDto registerDto, String imagePath) async {
    /*final response = await _client.post(
        Uri.parse('http://10.0.2.2:8080/auth/register/user'),
        headers: headers,
        body: jsonEncode(registerDto.toJson()));*/

    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
    };

    var uri = Uri.parse('http://10.0.2.2:8080/auth/register/user');

    var body = jsonEncode({
      'nick': registerDto.nick,
      'email': registerDto.email,
      'nombre': registerDto.nombre,
      'apellidos': registerDto.apellidos,
      'fechaNacimiento': registerDto.fechaNacimiento,
      'public': registerDto.public,
      'password': registerDto.password,
      'password2': registerDto.password2
    });

    var request = http.MultipartRequest('POST', uri)
      ..files.add(http.MultipartFile.fromString('usuario', body,
          contentType: MediaType('application', 'json')))
      ..files.add(await http.MultipartFile.fromPath('avatar', imagePath,
          contentType: MediaType('image', 'jpg')))
      ..headers.addAll(headers);

    final response = await request.send();

    if (response.statusCode == 201) {
      return RegisterResponse.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    } else {
      throw Exception('Failed to register');
    }
  }
}
