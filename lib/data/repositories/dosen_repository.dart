import 'dart:convert';
import 'dart:io';

import 'package:akademik_app/data/model/dosen/dosen_model.dart';
import 'package:akademik_app/data/shared/shared_values.dart';
import 'package:dio/dio.dart';

class DosenRepository {
  final Dio dio = Dio();

  // FETCH DOSEN
  Future<List<DosenModel>> fetchDosen() async {
    try {
      final response = await dio.get(
        '$baseUrl/dosen',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return List<DosenModel>.from(
          (response.data['data'] as List<dynamic>).map(
            (dosen) => DosenModel.fromJson(dosen),
          ),
        );
      }

      print('Fetch dosen success : ${response.data}');

      throw jsonDecode(response.data)['message'];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createDosen(DosenModel data) async {
    try {
      var formData = FormData.fromMap({
        'nip': data.nip,
        'nama': data.nama,
      });

      var response = await dio.post(
        '$baseUrl/create-dosen',
        data: formData,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Success Create Dosen');
      } else {
        throw response.data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateDosen(DosenModel data, int id) async {
    try {
      var formData = FormData.fromMap({
        'nip': data.nip,
        'nama': data.nama,
      });

      var response = await dio.post(
        '$baseUrl/$id/update-dosen',
        data: formData,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Success Update Dosen');
      } else {
        throw response.data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteDosen(int id) async {
    try {
      var response = await dio.delete(
        '$baseUrl/$id/delete-dosen',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        }),
      );

      if (response.statusCode == 200) {
        print('Delete Data Success');
      } else {
        throw response.data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
