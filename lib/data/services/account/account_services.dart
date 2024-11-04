import 'dart:developer';
import 'package:demo_project/constants/api_endpoints.dart';
import 'package:demo_project/constants/environment.dart';
import 'package:http/http.dart' as http;

class AccountServices {
  static const logoutEndpoint =
      '${Environment.baseUrl}${ApiEndpoints.logoutEndpoint}';

  Future<http.Response> logout(String token) async {
    final url = Uri.parse(logoutEndpoint);
    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    log(response.body);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load user');
    }
  }
}
