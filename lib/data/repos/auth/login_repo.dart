import 'package:demo_project/data/models/user_model.dart';
import 'package:demo_project/data/services/auth/login_service.dart';

class LoginRepository {
  LoginService _loginService = LoginService();
  Future<dynamic> loginUser(User user, String os) async {
    try {
      final response = await _loginService.login(user, os);

      return response;
    } catch (e) {
      // Handle errors appropriately
      return 'error';
    }
  }

  setToken(String value) {
    _loginService.setToken(value);
  }
}
