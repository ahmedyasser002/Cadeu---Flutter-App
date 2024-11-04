import 'dart:convert';
import 'dart:developer';
import 'package:demo_project/constants/api_endpoints.dart';
import 'package:demo_project/constants/environment.dart';
import 'package:demo_project/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class ForgetPassService {
  static const resetPassEndpoint =
      '${Environment.baseUrl}${ApiEndpoints.resetPassEndpoint}';
  static const verifyOtpEndpoint =
      '${Environment.baseUrl}${ApiEndpoints.verifyOtpEndpoint}';
  static const setNewPassEndpoint =
      '${Environment.baseUrl}${ApiEndpoints.setNewPassEndpoint}';
  Future sendOtp(String code, String phoneNo) async {
    final url = Uri.parse(resetPassEndpoint);
    final response = await http.post(
      url,
      body: jsonEncode({
        "user": {"country_code": code, "phone_number": phoneNo}
      }),
      headers: {
        "Content-Type": "application/json",
      },
    );
    log(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data']['reset_password_token'];
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future checkOtp(
      {required String input,
      required String countryCode,
      required String phoneNo}) async {
    final url = Uri.parse(verifyOtpEndpoint);
    final body = jsonEncode({
      "verification_code": input,
      "user": {"country_code": countryCode, "phone_number": phoneNo}
    });
    final response = await http
        .post(url, body: body, headers: {"Content-Type": "application/json"});
    log(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data']['token'];
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future setNewPass(
      {required String countryCode,
      required String phoneNo,
      required String token,
      required String password,
      required String confirmPassword}) async {
    final url = Uri.parse(setNewPassEndpoint);
    User user = User(
        countryCode: countryCode,
        password: password,
        phoneNumber: phoneNo,
        confirmPass: confirmPassword);
    final body = jsonEncode({
      "user": user.toJson(),
      "device": {"device_type": "android", "fcm_token": "dummy"}
    });
    final response = await http.post(url, body: body, headers: {
      "Content-Type": "application/json",
      "verification-token": token
    });
    log(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load user');
    }
  }
}
