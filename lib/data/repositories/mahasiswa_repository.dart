import 'dart:convert';
import 'dart:io';

import 'package:akademik_app/data/model/mahasiswa/mahasiswa_model.dart';
import 'package:akademik_app/data/shared/shared_values.dart';
import 'package:dio/dio.dart';

class MahasiswaRepository {
  final Dio dio = Dio();

  // FETCH MAHASISWA
  Future<List<MahasiswaModel>> fetchMahasiswa() async {
    try {
      final response = await dio.get(
        '$baseUrl/mahasiswa',
        options: Options(headers: {HttpHeaders.contentTypeHeader: 'application/json'}),
      );

      if (response.statusCode == 200) {
        return List<MahasiswaModel>.from(
          (response.data['data'] as List<dynamic>).map(
            (mahasiswa) => MahasiswaModel.fromJson(mahasiswa),
          ),
        );
      }

      throw jsonDecode(response.data)['message'];
    } catch (e) {
      rethrow;
    }
  }

  // CREATE MAHASISWA
  Future<void> createMahasiswa(MahasiswaModel data) async {
    try {
      var formData = FormData.fromMap({
        'nim': data.nim,
        'nama': data.nama,
        'tgl_lahir': data.tglLahir,
        'alamat': data.alamat,
        'gender': data.gender,
      });

      var response = await dio.post(
        '$baseUrl/create-mahasiswa',
        data: formData,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Success Create Mahasiswa');
      } else {
        throw response.data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  // UPDATE MAHASISWA
  Future<void> updateMahasiswa(MahasiswaModel data, int id) async {
    try {
      var formData = FormData.fromMap({
        'nim': data.nim,
        'nama': data.nama,
        'tgl_lahir': data.tglLahir,
        'alamat': data.alamat,
        'gender': data.gender,
      });

      var response = await dio.post(
        '$baseUrl/$id/update-mahasiswa',
        data: formData,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'appplication/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Success Update Mahasiswa');
      } else {
        throw response.data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  // DELETE MAHASISWA
  Future<void> deleteMahasiswa(int id) async {
    var response = await dio.delete(
      '$baseUrl/$id/delete-mahasiswa',
      options: Options(
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      ),
    );

    if (response.statusCode == 200) {
      print('Success Delete Mahasiswa');
    } else {
      throw response.data['message'];
    }
  }
}
