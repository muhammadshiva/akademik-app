class DepartemenModel {
  int id;
  String kode;
  String nama;

  DepartemenModel({
    required this.id,
    required this.kode,
    required this.nama,
  });

  factory DepartemenModel.fromJson(Map<String, dynamic> json) => DepartemenModel(
        id: json["id"],
        kode: json["kode"],
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode": kode,
        "nama": nama,
      };
}
