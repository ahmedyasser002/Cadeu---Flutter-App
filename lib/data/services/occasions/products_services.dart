import 'dart:convert';
import 'dart:developer';

import 'package:demo_project/constants/api_endpoints.dart';
import 'package:demo_project/constants/environment.dart';
import 'package:demo_project/data/models/products_model.dart';
import 'package:http/http.dart' as http;

class ProductServices {
  static const productsEndpoint =
      '${Environment.baseUrl}${ApiEndpoints.productsEndpoint}';
  Future<List<ProductsModel>> getProducts(
      {required String token, required List occasionId , required String pageNo}) async {
    final url = Uri.parse(productsEndpoint)
        .replace(queryParameters: {'occasion_type_id': occasionId ,
        'page_number' : pageNo
        });
    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        log(data['data']['products'].toString());
        List<ProductsModel> productsList = [];
        for (var product in data['data']['products']) {
          productsList.add(ProductsModel.fromJson(product));
          // log(product['currency']['name'].toString());
        }
        return productsList;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to load products');
    }
  }
}
