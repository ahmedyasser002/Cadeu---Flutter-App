import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:demo_project/constants/api_endpoints.dart';
import 'package:demo_project/constants/environment.dart';
import 'package:demo_project/data/models/occasions_model.dart';

class OccasionsService {
  static const occasionsEndpoint =
      '${Environment.baseUrl}${ApiEndpoints.occasionsEndPoint}';

  Future<List<OccasionsModel>> getOccasions(String token , String pageNo) async {
    final url = Uri.parse(occasionsEndpoint).replace(queryParameters: {
      'page_number': pageNo,
    });

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List<OccasionsModel> occasionsList = [];

        for (var occasion in data['data']['occasions']) {
          var occasionType = occasion['occasion_type'];
          log(occasionType.toString());
          occasionsList.add(OccasionsModel.fromJson(occasionType));
        }

        return occasionsList;
      } else {
        // Handle the error
        throw Exception('Failed to load occasions');
      }
    } catch (e) {
      // Handle the exception
      log(e.toString());
      throw Exception('Failed to load occasions');
    }
  }
}
