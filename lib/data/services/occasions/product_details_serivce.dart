import 'dart:convert';
import 'dart:developer';

import 'package:demo_project/constants/api_endpoints.dart';
import 'package:demo_project/constants/environment.dart';
import 'package:demo_project/data/models/product_details_model.dart';
import 'package:http/http.dart' as http;

class ProductDetailsService {
  Future<ProductDetailsModel> getProductDetails(
      {required String token, required int productID}) async {
    final String productDetailsEndpoint =
        '${Environment.baseUrl}${ApiEndpoints.productsEndpoint}/$productID';
    final url = Uri.parse(productDetailsEndpoint);
    try {
      final response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        log(data.toString());
        return ProductDetailsModel.fromJson(data['data']['product']);
      } else {
        throw Exception('Failed to load product');
      }
    } catch (e) {
      throw Exception('Failed to load product');
    }
  }
}
