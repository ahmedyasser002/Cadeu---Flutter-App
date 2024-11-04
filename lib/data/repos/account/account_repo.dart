import 'package:demo_project/constants/app_keys.dart';
import 'package:demo_project/constants/local_storage_helper.dart';
import 'package:demo_project/data/services/account/account_services.dart';

class AccountRepo {
  AccountServices _accountServices = AccountServices();
  Future logout() async {
    try {
      String token = LocalStorageHelper.getStrings(AppKeys.tokenKey);
      final response = await _accountServices.logout(token);
      return response;
    } catch (e) {
      return 'error';
    }
  }
}
