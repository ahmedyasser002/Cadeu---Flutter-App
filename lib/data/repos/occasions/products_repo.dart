import 'package:demo_project/constants/app_keys.dart';
import 'package:demo_project/constants/local_storage_helper.dart';
import 'package:demo_project/data/services/occasions/products_services.dart';

class ProductsRepository {
  final ProductServices _productServices = ProductServices();
  Future getProducts({required List occasionId, required String pageNo}) async {
    try {
      String token = LocalStorageHelper.getStrings(AppKeys.tokenKey);
      final response = await _productServices.getProducts(
          token: token, occasionId: occasionId, pageNo: pageNo);
      return response;
    } catch (e) {
      return 'error';
    }
  }
}
