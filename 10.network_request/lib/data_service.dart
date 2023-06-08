import 'dart:convert';

import 'package:http/http.dart' as http;

class DataService {
  Uri baseUrl = Uri.parse('https://reqres.in/api/users');

  Future<String> getUserData() async {
    var response = await http.get(baseUrl);

    var responseBody = jsonEncode(json.decode(response.body)['data']);

    return responseBody;
  }
}
