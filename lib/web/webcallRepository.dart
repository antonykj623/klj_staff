import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kljcafe_staff_new/web/api_credentials.dart';

import '../prefdata/sharedpref.dart';

class WebCallRepository {
  static String apiUrl = APICredentials.baseurl;

  static Future<Map<String, dynamic>> post(var request,String method) async {

    apiUrl = APICredentials.baseurl+method;


    String? token=  await SharedPref.getString(APICredentials.apptoken);

    final response = await http.post(
      Uri.parse(apiUrl),
      body: request,
      headers: {
        "Authorization": token.toString(),
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(" failed. Status: ${response.statusCode}");
    }
  }

  static Future<Map<String, dynamic>> get(String method) async {

    apiUrl = APICredentials.baseurl+method;



    String? token=  await SharedPref.getString(APICredentials.apptoken);

    final response = await http.get(
        Uri.parse(apiUrl),
      headers: {
        "Authorization": token.toString(),


      },

    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(" failed. Status: ${response.statusCode}");
    }
  }
}
