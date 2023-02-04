import 'package:http/http.dart';
import 'package:projet_dac/src/api/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Api {
  static Future<String> login(String email, String password) async {
    final response = await post(
      Uri.parse('http://localhost:3000/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:
          jsonEncode(<String, String>{'username': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("token", jsonDecode(response.body)['token']);
      return jsonDecode(response.body)['type'];
    } else {
      throw Exception('fail');
    }
  }

  static Future<String> register(
      String firstName, String lastName, String email, String password) async {
    final response = await post(
      Uri.parse('http://localhost:3000/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName
      }),
    );

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("token", jsonDecode(response.body)['token']);
      return "ok";
    } else {
      throw Exception('fail');
    }
  }

  Future<UserInfo> getUserInfo() async {
    final response = await get(Uri.parse('http://localhost:3000/userinfo'));

    if (response.statusCode == 200) {
      return UserInfo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('fail');
    }
  }
}
