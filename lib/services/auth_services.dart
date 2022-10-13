import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/apiConfig.dart';

class AuthServices {
  static Future<void> logIn(String email, password) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    var jsonResponse;
    Map data = {'email': email, 'password': password};
    print(data);

    String body = json.encode(data);
    Uri url = Uri.parse("${ApiConfig.BASE_URL}/api/login");
    var response = await http.post(
      url,
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
    ).timeout(Duration(seconds: 10));

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 201) {
      await preferences.setString('token', json.decode(response.body)['token']);
      jsonResponse = json.decode(response.body.toString());
      print(preferences.getString('token'));
      print('success');
    } else {
      print('error');
    }
  }

  static Future<void> Register(
      String name, email, password, passwordConfirmation) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var jsonResponse;
    Map data = {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation
    };
    print(data);

    String body = json.encode(data);
    Uri url = Uri.parse("${ApiConfig.BASE_URL}/api/register");
    var response = await http.post(
      url,
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
    ).timeout(Duration(seconds: 10));

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 201) {
      jsonResponse = json.decode(response.body.toString());
      preferences.setString("token", json.decode(response.body)['token']);
      print('success');
    } else {
      print('error');
    }
  }

  static Future<bool> LogOut() async {
    var jsonResponse;

    String? token;
    final preferences = await SharedPreferences.getInstance();
    token = preferences.getString('token');
    await preferences.remove('token');

    Uri url = Uri.parse("${ApiConfig.BASE_URL}/api/logout");
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token'
      },
    ).timeout(Duration(seconds: 10));

    if (token != null) {
      print(preferences.getString('token'));
      return true;
    } else {
      return false;
    }
  }
}
