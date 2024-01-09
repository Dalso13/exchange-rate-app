import 'dart:convert';

import 'package:http/http.dart' as http;
class RateApi {
  Future<Map<String,dynamic>> getRateApi(String baseCode) async {
    final response = await http.get(Uri.parse('https://open.er-api.com/v6/latest/$baseCode'));


    return jsonDecode(response.body);
   }
  }
