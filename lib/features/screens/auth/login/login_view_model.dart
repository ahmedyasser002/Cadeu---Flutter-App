import 'dart:developer';

import 'package:demo_project/data/models/user_model.dart';
import 'package:demo_project/data/repos/auth/login_repo.dart';
import 'package:demo_project/features/screens/bottom_bar/bottom_bar.dart';
import 'package:demo_project/constants/local_storage_helper.dart';
import 'package:demo_project/constants/app_keys.dart';
import 'package:demo_project/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginViewModel {
  static final  loginNotifier = ChangeNotifierProvider((ref) => LoginNotifier());
  static final LoginRepository _loginRepository = LoginRepository();
  static Future<void> loginUser(
      User user, String os, BuildContext context, WidgetRef ref) async {
    ref.read(loginNotifier).toggleLoading(true);
    final response = await _loginRepository.loginUser(user, os);
    ref.read(loginNotifier).toggleLoading(false);
    if (response != 'error') {
      final token = response['data']['extra']['access_token'];
      log('in view-model token is $token');
      LocalStorageHelper.setStrings(AppKeys.tokenKey, token);
      navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const BottomBar()),
        (Route<dynamic> route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response), backgroundColor: Colors.red),
      );
    }
  }
}

class LoginNotifier extends ChangeNotifier {
  List<bool> areFilledFields = [false, false];
  bool isActive = false;
  bool isObsecure = true;
  bool isLoading = false;

  void checkFilledField(int phoneLength, int passLength) {
    if (phoneLength >= 3 && passLength >= 3) {
      isActive = true;
    } else {
      isActive = false;
    }
    notifyListeners();
  }

  void toggleObsecure() {
    isObsecure = !isObsecure;
    notifyListeners();
  }

  void toggleLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }

}
  