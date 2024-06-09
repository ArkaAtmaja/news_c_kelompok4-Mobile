import 'package:news_c_kelompok4/model/pembayaran_model.dart';
import 'dart:convert';
import 'package:http/http.dart';

class PembayaranClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/pembayaran';

  static final String urlHP = '192.168.169.224';
  static final String endpointHP = 'API_NEWS_7/public/api/news';

  Client client;

  PembayaranClient(this.client);

  static Future<List<pembayaranModel>> fetchAllMock(Client client) async {
    try {
      var response = await client.get(
        Uri.http(url, endpoint),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => pembayaranModel.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<List<pembayaranModel>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, endpoint));
      print('ini adalah $get(Uri.http(url, endpoint)');
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => pembayaranModel.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // static Future<addNews> find(id) async {
  //   try {
  //     var response = await get(Uri.http(url, '$endpoint/$id'));

  //     if (response.statusCode != 200) throw Exception(response.reasonPhrase);

  //     return addNews.fromJson(json.decode(response.body)['data']);
  //   } catch (e) {
  //     return Future.error(e.toString());
  //   }
  // }

  // static Future<Response> create(addNews news) async {
  //   try {
  //     var response = await post(Uri.http(url, endpoint),
  //         headers: {"Content-Type": "application/json"},
  //         body: news.toRawJson());

  //     if(response.statusCode != 200) throw Exception(response.reasonPhrase);

  //     return response;
  //   } catch (e) {
  //     return Future.error(e.toString());
  //   }
  // }

  // static Future<Response> update(addNews news) async {
  //   try {
  //     var response = await put(Uri.http(url, '$endpoint/${news.id}'),
  //         headers: {"Content-Type": "application/json"},
  //         body: news.toRawJson());

  //     if (response.statusCode != 200) throw Exception(response.reasonPhrase);

  //     return response;
  //   } catch (e) {
  //     return Future.error(e.toString());
  //   }
  // }

  // static Future<Response> destroy(id) async {
  //   try {
  //     var response = await delete(Uri.http(url, '$endpoint/$id'));

  //     if (response.statusCode != 200) throw Exception(response.reasonPhrase);

  //     return response;
  //   } catch (e) {
  //     return Future.error(e.toString());
  //   }

  // }
}
