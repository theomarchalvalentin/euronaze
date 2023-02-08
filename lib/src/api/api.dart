import 'package:http/http.dart';
import 'package:projet_dac/src/api/user_model.dart';
import 'package:projet_dac/src/api/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';

import 'dart:io';
import 'dart:typed_data';

class NoTokenExeption implements Exception {}

class BadAuth implements Exception {}

class EmailExist implements Exception {}

class Api {
  static Future<String> login(String email, String password) async {
    final response = await post(
      Uri.parse('http://localhost:8080/api/auth/signin'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:
          jsonEncode(<String, String>{'username': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("token", jsonDecode(response.body)['token']);
      return jsonDecode(response.body)['roles'][0];
    } else if (response.statusCode == 403) {
      throw BadAuth();
    } else {
      throw Exception('fail');
    }
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
  }

  static Future<void> register(
      String firstName, String lastName, String email, String password) async {
    final response = await post(
      Uri.parse('http://localhost:8080/api/auth/signup'),
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
      return;
    } else if (response.statusCode == 400) {
      throw EmailExist();
    } else {
      throw Exception('fail');
    }
  }

  static Future<UserInfo> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");
    if (token != null) {
      final response = await get(
        Uri.parse('http://localhost:8080/api/userinfo'),
        headers: <String, String>{"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        return UserInfo.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('fail');
      }
    } else {
      throw NoTokenExeption();
    }
  }

  static Future<String> modifyUserInfo(
      String firstName, String lastName, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");

    if (token != null) {
      final response = await post(
        Uri.parse('http://localhost:8080/api/modifyuserinfo'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
          'firstName': firstName,
          'lastName': lastName
        }),
      );

      if (response.statusCode == 200) {
        return 'ok';
      } else {
        throw Exception('fail');
      }
    } else {
      throw NoTokenExeption();
    }
  }

  static Future<String?> selectFile() async {
    String? fileEncoded;
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowedExtensions: ["csv"]);

    if (result != null) {
      Uint8List file = File(result.files.single.path!).readAsBytesSync();
      fileEncoded = base64.encode(file);
      String fileName = result.files.first.name;
    }
    return fileEncoded;
  }

  static Future<String> addProduct(
      String firstName, String lastName, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");

    if (token != null) {
      final response = await post(
        Uri.parse('http://localhost:8080/api/modifyuserinfo'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
          'firstName': firstName,
          'lastName': lastName
        }),
      );

      if (response.statusCode == 200) {
        return 'ok';
      } else {
        throw Exception('fail');
      }
    } else {
      throw NoTokenExeption();
    }
  }

  static Future<List<Product>> getLibrary() async {
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");
    if (token != null) {
      final response = await get(
        Uri.parse('http://localhost:8080/api/library'),
        headers: <String, String>{"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        Iterable l = json.decode(response.body);

        List<Product> result =
            List<Product>.from(l.map((model) => Product.fromJson(model)));
        return result;
      } else {
        throw Exception('fail');
      }
    } else {
      throw NoTokenExeption();
    }
  }
}
