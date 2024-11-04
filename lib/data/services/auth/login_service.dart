import 'dart:convert';
import 'dart:developer';

import 'package:demo_project/constants/api_endpoints.dart';
import 'package:demo_project/constants/app_keys.dart';
import 'package:demo_project/constants/environment.dart';
import 'package:demo_project/constants/local_storage_helper.dart';
import 'package:demo_project/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static const loginEndpoint =
      '${Environment.baseUrl}${ApiEndpoints.loginEndpoint}';
  Future<dynamic> login(User user, String os) async {
    final url = Uri.parse(loginEndpoint);
    final response = await http.post(
      url,
      body: jsonEncode({
        "user": user.toJson(),
        "device": {"device_type": "android", "fcm_token": "dummy"}
      }),
      headers: {
        "Content-Type": "application/json",
        "Accept-Language": "en-US",
        "Timezone": "GMT"
      },
    );
    log(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load user');
    }
  }

  setToken(String value)  {
     LocalStorageHelper.setStrings(AppKeys.tokenKey, value);
  }
}
