import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rijksmuseum_app/secrets.dart';

const baseUrl = 'https://www.rijksmuseum.nl/api/';

class ApiService {
  Future fetchCollection({int page = 0}) async {
    var url = '$baseUrl/en/collection?key=$kApiKey&ps=20&p=$page';
    return sendRequest(url);
  }

  Future fetchDetails({String objectNumber}) async {
    var url = '$baseUrl/en/collection/$objectNumber?key=$kApiKey';
    return sendRequest(url);
  }

  Future sendRequest(String url) async {
    var response = await http.get(Uri.parse(url));

    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 400:
        throw BadRequestException();
      case 500:
        throw InternalServerException();
      default:
        throw FetchException();
    }
  }
}

class FetchException implements Exception {}

class BadRequestException implements Exception {}

class InternalServerException implements Exception {}
