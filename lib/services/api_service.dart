import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rijksmuseum_app/secrets.dart';

const baseUrl = 'https://www.rijksmuseum.nl/api/';

class ApiService {
  // Culture culture;
  // ApiService(this.culture);

  Future get() async {
    var response =
        await http.get(Uri.parse('$baseUrl/en/collection?key=$kApiKey&ps=10'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
  }
}

enum Culture { En, Nl }
