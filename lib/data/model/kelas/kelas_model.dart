import 'package:akademik_app/data/model/departemen/departemen_model.dart';
import 'package:flutter/material.dart';

class KelasModel {
  int id;
  int idDepartemen;
  String nama;
  DepartemenModel departemen;

  KelasModel({
    required this.id,
    required this.idDepartemen,
    required this.nama,
    required this.departemen,
  });

  factory KelasModel.fromJson(Map<String, dynamic> json) => KelasModel(
        id: json["id"],
        idDepartemen: json["id_departemen"],
        nama: json["nama"],
        departemen: DepartemenModel.fromJson(json["departemen"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_departemen": idDepartemen,
        "nama": nama,
        "departemen": departemen.toJson(),
      };
}
