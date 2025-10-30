import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService({required this.dio}) {
    dio.options.baseUrl = 'https://www.googleapis.com/books/v1/';
  }

  Future<Map<String, dynamic>> get({required String endPoint}) async {
    Response response = await dio.get(endPoint);
    return response.data;
  }
}
