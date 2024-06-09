import 'dart:convert';

class addNews {
  int id;
  String judul;
  String kategori;
  String deskripsi;
  String lokasi;
  String? imagePath;

  addNews({
    required this.id,
    required this.judul,
    required this.kategori,
    required this.deskripsi,
    required this.lokasi,
    this.imagePath,
  });

  factory addNews.fromRawJson(String str) => addNews.fromJson(json.decode(str));

  factory addNews.fromJson(Map<String, dynamic> json) => addNews(
        id: json["id"],
        judul: json["judul"],
        kategori: json["kategori"],
        deskripsi: json["deskripsi"],
        imagePath: json["imagePath"],
        lokasi: json["lokasi"],
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "judul": judul,
        "kategori": kategori,
        "deskripsi": deskripsi,
        "imagePath": imagePath,
        "lokasi": lokasi,
      };
}
