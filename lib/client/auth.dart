import 'package:news_c_kelompok4/model/user_model.dart';

import 'dart:convert';
import 'package:http/http.dart';

class UserClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/user';
  static final String registerEndPoint = '/api/register';
  static final String loginEndPoint = '/api/login';
  static final String userEndPoint = '/api/users';
  static final String usernameEndPoint = '/api/username';

  static final String urlHP = '192.168.2.22';
  //static final String registerEndPointHP = 'API_NEWS/api/register';
  static final String loginEndPointHP = 'API_NEWS/api/login';
  static final String endpointHP = 'API_NEWS/api/user';
  static final String userendpointHP = 'API_NEWS/api/users';

  static Client? _httpClient;

  static Client get httpClient {
    if (_httpClient == null) {
      _httpClient = Client();
    }
    return _httpClient!;
  }

  static set httpClient(Client client) {
    _httpClient = client;
  }

  static Future<Map<String, dynamic>> getUserByUsername(String username) async {
    try {
      var response = await get(Uri.http(url, '$usernameEndPoint/$username'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Map<String, dynamic>> getUserById(int id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Map<String, dynamic>> getUserByEmail(String email) async {
    try {
      print("email");
      print(Uri.http(url, '$userEndPoint/$email'));
      var response = await get(Uri.http(url, '$userEndPoint/$email'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<User> login(String username, String password) async {
    try {
      var response = await post(Uri.http(url, loginEndPoint),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"username": username, "password": password}));
      print(response.body);
      if (response.statusCode != 200) {
        throw Exception(response.body);
      }

      return User.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> create(User user) async {
    try {
      print(Uri.http(url, registerEndPoint));
      var response = await post(Uri.http(url, registerEndPoint),
          headers: {"Content-Type": "application/json"},
          body: user.toRawJson());

      if (response.statusCode != 200) {
        throw Exception(response.body);
      }

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<User> register(
    String username,
    String email,
    String password,
    String tanggalLahir,
    String noTelp,
    String gender,
    String imgProfil,
    String imgSampul,
  ) async {
    try {
      var response = await post(Uri.http(url, loginEndPoint),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "username": username,
            "email": email,
            "password": password,
            "tanggalLahir": tanggalLahir,
            "noTelp": noTelp,
            "gender": gender,
            "imgProfile": imgProfil,
            "imgSampul": imgSampul,
          }));

      if (response.statusCode != 200) {
        throw Exception(response.reasonPhrase);
      }

      return User.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<bool> checkEmail(String email) async {
    try {
      var response = await get(Uri.http(url, '$userEndPoint/$email'));

      if (response.statusCode != 200) {
        throw Exception(response.reasonPhrase);
      }

      return json.decode(response.body)['unique'];
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(User user) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/${user.id}'),
          headers: {"Content-Type": "application/json"},
          body: user.toRawJson());

      if (response.statusCode != 200) throw Exception(response.body);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> destroy(id) async {
    try {
      var response = await delete(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
