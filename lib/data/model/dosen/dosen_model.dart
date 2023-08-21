import 'dart:convert';

class DosenModel {
  int? id;
  String nip;
  String nama;

  DosenModel({
    this.id,
    required this.nip,
    required this.nama,
  });

  factory DosenModel.fromJson(Map<String, dynamic> json) => DosenModel(
        id: json["id"],
        nip: json["nip"],
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nip": nip,
        "nama": nama,
      };
}
