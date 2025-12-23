import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kljcafe_staff_new/web/api_credentials.dart';

class LoginRepository {
  static String apiUrl = APICredentials.baseurl+APICredentials.login;

  static Future<Map<String, dynamic>> loginUser(String mobile, String password) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        "mobile": mobile,
        "password": password,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Login failed. Status: ${response.statusCode}");
    }
  }
}
