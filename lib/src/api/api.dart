import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart';
import 'package:projet_dac/src/models/user_model.dart';
import 'package:projet_dac/src/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'dart:typed_data';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

class NoTokenExeption implements Exception {}

class BadAuth implements Exception {}

class EmailExist implements Exception {}

class AlreadyInCart implements Exception {}

class AlreadyInLib implements Exception {
  String cause;
  AlreadyInLib(this.cause);
}

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
    String? token = prefs.getString("token");
    final response = await post(
        Uri.parse('http://localhost:8080/api/auth/signout'),
        headers: <String, String>{"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove("token");
    } else {
      throw Exception('fail');
    }
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
        Uri.parse('http://localhost:8080/api/user/InfoUser'),
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

  static Future<void> modifyUserInfo(
      String firstName, String lastName, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");

    if (token != null) {
      final response = await put(
        Uri.parse('http://localhost:8080/api/user/ModifyInfoUser'),
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
        return;
      } else {
        throw Exception('fail');
      }
    } else {
      throw NoTokenExeption();
    }
  }

  static Future<void> deleteUserInfo() async {
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");
    if (token != null) {
      final response = await delete(
        Uri.parse('http://localhost:8080/api/user/DeleteUser'),
        headers: <String, String>{"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        return;
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
        Uri.parse('http://localhost:8080/api/service/library'), //change
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

  static Future<List<Product>> getTrending() async {
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");
    if (token != null) {
      final response = await get(
        Uri.parse('http://localhost:8080/api/service/trending'),
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

  static Future<List<Product>> getBasket() async {
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");
    if (token != null) {
      final response = await get(
        Uri.parse('http://localhost:8080/api/user/cart'),
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

  static Future<Product> getProduct(int id) async {
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");
    if (token != null) {
      final response = await get(
        Uri.parse('http://localhost:8080/api/service/produits/$id'),
        headers: <String, String>{"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        return Product.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('fail');
      }
    } else {
      throw NoTokenExeption();
    }
  }

  static Future<void> addCart(int productId) async {
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");
    if (token != null) {
      final response = await put(
        Uri.parse('http://localhost:8080/api/user/cart/add/$productId'),
        headers: <String, String>{"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        return;
      } else if (response.statusCode == 400) {
        throw AlreadyInCart;
      } else if (response.statusCode == 405) {
        throw AlreadyInLib('lib');
      } else {
        throw Exception('fail');
      }
    } else {
      throw NoTokenExeption();
    }
  }

  static Future<void> checkCart() async {
    final prefs = await SharedPreferences.getInstance(); //change

    String? token = prefs.getString("token");
    if (token != null) {
      final response = await post(
        Uri.parse('http://localhost:8080/api/user/cart/check'),
        headers: <String, String>{"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('fail');
      }
    } else {
      throw NoTokenExeption();
    }
  }

  static Future<void> deleteCart(int productId) async {
    final prefs = await SharedPreferences.getInstance(); //change

    String? token = prefs.getString("token");
    if (token != null) {
      final response = await put(
        Uri.parse('http://localhost:8080/api/user/cart/Delete/$productId'),
        headers: <String, String>{"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('fail');
      }
    } else {
      throw NoTokenExeption();
    }
  }

  static Future<void> deleteAllCart() async {
    final prefs = await SharedPreferences.getInstance(); //change

    String? token = prefs.getString("token");
    if (token != null) {
      final response = await put(
        Uri.parse('http://localhost:8080/api/user/cart/DeleteAll'),
        headers: <String, String>{"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('fail');
      }
    } else {
      throw NoTokenExeption();
    }
  }

  static Future<void> putProduct(
      //gestion du nul
      int productId,
      String productName,
      String productDescription,
      int categoryId,
      String productImg,
      double price,
      {Uint8List? file}) async {
    String fileUpload;
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    if (token != null) {
      if (file != null) {
        fileUpload = base64.encode(file);
      } else {
        fileUpload = '';
      }
      final response = await put(
          Uri.parse('http://localhost:8080/api/service/produits/$productId'),
          headers: <String, String>{"Authorization": "Bearer $token"},
          body: jsonEncode(<String, dynamic>{
            'id': productId,
            'nom': productName,
            'description': productDescription,
            'category': categoryId,
            'image': productImg,
            'prix': price,
            'data': fileUpload
          }));

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('fail');
      }
    } else {
      throw NoTokenExeption();
    }
  }

  static Future<void> postProduct(String productName, String productDescription,
      int categoryId, String productImg, double price, Uint8List file) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    if (token != null) {
      String fileUpload = base64.encode(file);
      final response = await post(
          Uri.parse('http://localhost:8080/api/service/produits/upload'),
          headers: <String, String>{"Authorization": "Bearer $token"},
          body: jsonEncode(<String, dynamic>{
            'nom': productName,
            'description': productDescription,
            'category': categoryId,
            'image': productImg,
            'prix': price,
            'data': fileUpload
          }));

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('fail');
      }
    } else {
      throw NoTokenExeption();
    }
  }

  static Future<void> deleteProduct(int productId) async {
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");
    if (token != null) {
      final response = await delete(
        Uri.parse('http://localhost:8080/api/service/produits/$productId'),
        headers: <String, String>{"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('fail');
      }
    } else {
      throw NoTokenExeption();
    }
  }

  static Future<List<Product>> searchProduct(
      int categoryId, String lookingWord) async {
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");
    if (token != null) {
      final response = await post(
          Uri.parse('http://localhost:8080/api/service/produits/filtred'),
          headers: <String, String>{
            "Authorization": "Bearer $token",
            "Content-Type": "application/json"
          },
          body: jsonEncode(<String, dynamic>{
            'id': categoryId,
            'stri': lookingWord,
          }));

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

  static void downloadFile(int id) async {
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");
    var url =
        Uri.parse("http://localhost:8080/api/service/produits/download/$id");

    Response res = await get(url,
        headers: <String, String>{"Authorization": "Bearer $token"});

    if (res.statusCode == 200) {
      final blob = Blob([res.bodyBytes]);
      final url = Url.createObjectUrlFromBlob(blob);
      final anchor = document.createElement('a') as AnchorElement
        ..href = url
        ..style.display = 'none'
        ..download = "Data_$id.csv";
      document.body!.children.add(anchor);

      anchor.click();

      document.body!.children.remove(anchor);
      Url.revokeObjectUrl(url);
    }
  }

  static Future<List<double>> getData(int id) async {
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");
    if (token != null) {
      final response = await get(
        Uri.parse('http://localhost:8080/api/service/produits/data/$id'),
        headers: <String, String>{"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        Iterable l = json.decode(response.body);

        return List<double>.from(l.map((model) => model["prix"]));
      } else {
        throw Exception('fail');
      }
    } else {
      throw NoTokenExeption();
    }
  }

  static Future<void> postProductMultipart(
      String productName,
      String productDescription,
      int categoryId,
      String productImg,
      double price,
      PlatformFile file) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    if (token != null) {
      var request = MultipartRequest('POST',
          Uri.parse('http://localhost:8080/api/service/produits/upload'));
      request.headers.addAll({'Authorization': 'Bearer $token'});

      request.fields['nom'] = productName;
      request.fields['description'] = productDescription;
      request.fields['category'] = categoryId.toString();
      request.fields['image'] = productImg;
      request.fields['prix'] = price.toStringAsFixed(2);

      final multipartFile =
          MultipartFile.fromBytes('data', file.bytes!, filename: file.name);
      request.files.add(multipartFile);

      final httpClient = Client();
      final response = await httpClient.send(request);

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('fail');
      }
    } else {
      throw NoTokenExeption();
    }
  }

  static Future<void> putProductMultimap(
      //gestion du nul
      int productId,
      String productName,
      String productDescription,
      int categoryId,
      String productImg,
      double price,
      {PlatformFile? file}) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    if (token != null) {
      var request = MultipartRequest('PUT',
          Uri.parse('http://localhost:8080/api/service/produits/$productId'));
      request.headers.addAll({'Authorization': 'Bearer $token'});
      request.fields['nom'] = productName;
      request.fields['description'] = productDescription;
      request.fields['category'] = categoryId.toString();
      request.fields['image'] = productImg;
      request.fields['prix'] = price.toStringAsFixed(2);
      if (file != null) {
        final multipartFile =
            MultipartFile.fromBytes('data', file.bytes!, filename: file.name);
        request.files.add(multipartFile);
      }
      final httpClient = Client();
      final response = await httpClient.send(request);

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('fail');
      }
    } else {
      throw NoTokenExeption();
    }
  }
}
