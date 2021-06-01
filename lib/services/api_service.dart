import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rijksmuseum_app/secrets.dart';

const baseUrl = 'https://www.rijksmuseum.nl/api/';

class ApiService {
  Future fetchCollection({int page = 0}) async {
    var response = await http
        .get(Uri.parse('$baseUrl/en/collection?key=$kApiKey&ps=20&p=$page'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      // candidate for future improvements, like handling different status codes
      // and throwing specific types of exceptions, e.g. BadRequestException etc.
      throw FetchException();
    }
  }
}

class FetchException implements Exception {}
