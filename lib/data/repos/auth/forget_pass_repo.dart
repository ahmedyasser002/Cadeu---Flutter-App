import 'dart:developer';
import 'package:demo_project/data/services/auth/forget_pass_service.dart';

class ForgetPassRepository {
  ForgetPassService _forgetPassService = ForgetPassService();
  Future<dynamic> getOtp(String code, String phoneNo) async {
    try {
      final response = await _forgetPassService.sendOtp(code, phoneNo);
      return response;
    } catch (e) {
      return 'error';
    }
  }

  Future checkOtp(
      {required String input,
      required String countryCode,
      required String phoneNo}) async {
    try {
      final response = await _forgetPassService.checkOtp(
          input: input, countryCode: countryCode, phoneNo: phoneNo);

      return response;
    } catch (e) {
      log(e.toString());
      return 'error';
    }
  }

  Future setNewPass(
      {required String countryCode,
      required String phoneNo,
      required String password,
      required String token,
      required String confirmPassword}) async {
    try {
      final response = await _forgetPassService.setNewPass(
          countryCode: countryCode,
          phoneNo: phoneNo,
          token: token,
          password: password,
          confirmPassword: confirmPassword);
      return response;
    } catch (e) {
      return 'error';
    }
  }
}
