import 'package:flutter_miarma_app/models/auth/login_dto.dart';
import 'package:flutter_miarma_app/models/auth/login_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginDto loginDto);
}
