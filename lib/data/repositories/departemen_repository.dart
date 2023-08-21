import 'dart:convert';
import 'dart:io';

import 'package:akademik_app/data/model/departemen/departemen_model.dart';
import 'package:akademik_app/data/shared/shared_values.dart';
import 'package:dio/dio.dart';

class DepartemenRepository {
  final Dio dio = Dio();

  Future<List<DepartemenModel>> fetchDepartemen() async {
    try {
      final response = await dio.get(
        '$baseUrl/departemen',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        }),
      );

      if (response.statusCode == 200) {
        return List<DepartemenModel>.from(
          (response.data['data'] as List<dynamic>).map(
            (departemen) => DepartemenModel.fromJson(departemen),
          ),
        );
      }

      throw jsonDecode(response.data)['message'];
    } catch (e) {
      rethrow;
    }
  }
}
