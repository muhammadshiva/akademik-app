import 'dart:convert';
import 'dart:io';

import 'package:akademik_app/data/model/kelas/kelas_model.dart';
import 'package:akademik_app/data/shared/shared_values.dart';
import 'package:dio/dio.dart';

class KelasRepository {
  final Dio dio = Dio();

  // Fetch Kelas
  Future<List<KelasModel>> fetchKelas() async {
    try {
      final response = await dio.get(
        '$baseUrl/kelas',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        }),
      );

      if (response.statusCode == 200) {
        return List<KelasModel>.from(
          (response.data['data'] as List<dynamic>).map(
            (kelas) => KelasModel.fromJson(kelas),
          ),
        );
      }

      throw jsonDecode(response.data)['message'];
    } catch (e) {
      rethrow;
    }
  }
}
