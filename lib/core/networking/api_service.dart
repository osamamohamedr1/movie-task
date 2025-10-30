import 'package:dio/dio.dart';
import 'package:movie_task/core/constants/api_constants.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio) {
    dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: {
        'Authorization': 'Bearer ${ApiConstants.accessToken}',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );
  }

  Future<dynamic> get({
    required String endPoints,
    Map<String, dynamic>? queryParams,
  }) async {
    final response = await dio.get(endPoints, queryParameters: queryParams);
    return response.data;
  }

  Future<dynamic> post({
    required String endPoints,
    required dynamic data,
    Options? options,
  }) async {
    final response = await dio.post(endPoints, data: data, options: options);
    return response.data;
  }

  Future<Map<String, dynamic>> put({
    required String endPoints,
    required Map data,
  }) async {
    final response = await dio.put(endPoints, data: data);
    return response.data;
  }
}
