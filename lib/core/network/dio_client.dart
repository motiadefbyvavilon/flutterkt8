import 'package:dio/dio.dart';

/// Фабрика Dio с базовыми настройками.
class DioClient {
  static Dio create() {
    return Dio(
      BaseOptions(
        baseUrl: 'https://cdn.jsdelivr.net',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        responseType: ResponseType.json,
      ),
    );
  }
}
