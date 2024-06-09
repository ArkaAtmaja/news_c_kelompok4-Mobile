import 'dart:convert';

class pembayaranModel {
  int id;
  String jumlah;
  String metode;
  double harga;

  pembayaranModel({
    required this.id,
    required this.jumlah,
    required this.metode,
    required this.harga,
  });

  factory pembayaranModel.fromRawJson(String str) =>
      pembayaranModel.fromJson(json.decode(str));

  factory pembayaranModel.fromJson(Map<String, dynamic> json) =>
      pembayaranModel(
        id: json["id"],
        jumlah: json["jumlah"],
        metode: json["metode"],
        harga: json["harga"],
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "jumlah": jumlah,
        "metode": metode,
        "harga": harga,
      };
}
