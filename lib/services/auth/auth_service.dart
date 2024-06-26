import 'package:consulta_produto/model/user_model.dart';
import 'package:consulta_produto/services/auth/auth_sankhya_service.dart';

abstract class AuthService {
  static AuthService? _auth;

  UserModel? get currentUser;

  Future<void> login(
    String username,
    String password,
  );

  Future<void> logout();

  factory AuthService() {
    _auth ??= AuthSankhyaService();
    return _auth!;
  }
}
