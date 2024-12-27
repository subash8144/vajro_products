import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:products/core/constants/app_constants.dart';

class ApiService {

  Future<Map<String, dynamic>> get({required String endpoint}) async {
    final response = await http.get(
      Uri.parse('${AppConstants.baseUrl}$endpoint'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to connect to the server.");
    }
  }
}