import 'dart:convert';

import '../globals.dart' as globals;

import 'package:http/http.dart' as http;
class MovieService {
  static apiURL() {
    return globals.API_BACK;
  }
  Future movies() async {
    var url = apiURL() + 'movies';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return [];
    }
  }
  Future events() async {
    var url = apiURL() + 'eventos';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return [];
    }
  }
}