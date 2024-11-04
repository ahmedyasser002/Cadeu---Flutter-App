import 'package:demo_project/constants/app_keys.dart';
import 'package:demo_project/constants/local_storage_helper.dart';
import 'package:demo_project/data/models/occasions_model.dart';
import 'package:demo_project/data/services/occasions/ocassions_service.dart';

class OccasionsRepository {
  final OccasionsService _occasionsService = OccasionsService();
  Future <List<OccasionsModel>?> getOcassions(String pageNo) async {
    try {
      String token = LocalStorageHelper.getStrings(AppKeys.tokenKey);
      final response = await _occasionsService.getOccasions(token, pageNo);
      return response;
    } catch (e) {
      return null;
    }
  }
}
