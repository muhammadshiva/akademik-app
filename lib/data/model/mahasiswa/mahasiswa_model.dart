import 'dart:convert';

class MahasiswaModel {
  int? id;
  String nim;
  String nama;
  String tglLahir;
  String alamat;
  String gender;

  MahasiswaModel({
    this.id,
    required this.nim,
    required this.nama,
    required this.tglLahir,
    required this.alamat,
    required this.gender,
  });

  factory MahasiswaModel.fromJson(Map<String, dynamic> json) => MahasiswaModel(
        id: json["id"],
        nim: json["nim"],
        nama: json["nama"],
        tglLahir: json["tgl_lahir"],
        alamat: json["alamat"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nim": nim,
        "nama": nama,
        "tgl_lahir": tglLahir,
        "alamat": alamat,
        "gender": gender,
      };
}
