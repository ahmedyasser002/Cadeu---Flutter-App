import 'package:demo_project/constants/app_keys.dart';
import 'package:demo_project/constants/local_storage_helper.dart';
import 'package:demo_project/data/repos/account/account_repo.dart';
import 'package:demo_project/features/screens/auth/login/login_screen.dart';
import 'package:demo_project/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountViewModel {
  static final AccountRepo _accountRepo = AccountRepo();
  static final accountNotifier =
      ChangeNotifierProvider((ref) => AccountNotifier());
  static Future logout(BuildContext context, WidgetRef ref) async {
    // String token = LocalStorageHelper.getStrings(AppKeys.tokenKey);
    ref.read(accountNotifier).toggleLogoutLoading(true);
    final response = await _accountRepo.logout();
    ref.read(accountNotifier).toggleLogoutLoading(false);
    if (response != 'error') {
      LocalStorageHelper.setStrings(AppKeys.tokenKey, '');
      navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }
}

class AccountNotifier extends ChangeNotifier {
  bool logOutLoading = false;
  void toggleLogoutLoading(bool val) {
    logOutLoading = val;
    notifyListeners();
  }

  // Future logout(BuildContext context) async {
  // String token = LocalStorageHelper.getStrings(AppKeys.tokenKey);
  //   final response = await AccountRepo.logout(token);
  //   if (response != 'error') {
  //     LocalStorageHelper.setStrings(AppKeys.tokenKey, '');
  //     navigatorKey.currentState?.pushAndRemoveUntil(
  //       MaterialPageRoute(builder: (context) => LoginScreen()),
  //       (Route<dynamic> route) => false,
  //     );
  //   }
  // }
}

//  Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (context) => LoginScreen()),
//         (Route<dynamic> route) => false,
//       );