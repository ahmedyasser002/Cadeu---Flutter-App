import 'package:demo_project/constants/app_keys.dart';
import 'package:demo_project/constants/local_storage_helper.dart';
import 'package:demo_project/data/services/occasions/product_details_serivce.dart';

class ProductDetailsRepository {
  final ProductDetailsService _productDetailsService = ProductDetailsService();
  Future getProductDetails({required int productID}) async {
    try {
      String token = LocalStorageHelper.getStrings(AppKeys.tokenKey); 
      final response = await _productDetailsService.getProductDetails(
          token: token, productID: productID);
      return response;
    } catch (e) {
      return 'error';
    }
  }
}
