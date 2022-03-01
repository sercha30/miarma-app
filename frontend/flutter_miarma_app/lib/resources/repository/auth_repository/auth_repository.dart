import 'package:flutter_miarma_app/models/auth/login/login_dto.dart';
import 'package:flutter_miarma_app/models/auth/login/login_response.dart';
import 'package:flutter_miarma_app/models/auth/register/register_dto.dart';
import 'package:flutter_miarma_app/models/auth/register/register_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginDto loginDto);
  Future<RegisterResponse> register(RegisterDto registerDto, String imagePath);
}
