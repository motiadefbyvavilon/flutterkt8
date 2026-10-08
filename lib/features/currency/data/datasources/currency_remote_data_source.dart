import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../models/currency_rates_model.dart';

/// Источник данных — работает с сетью через Dio.
class CurrencyRemoteDataSource {
  final Dio dio;

  CurrencyRemoteDataSource(this.dio);

  /// GET /gh/irfanokr/currency-api@main/v1/currencies/{base}.json
  Future<CurrencyRatesModel> getRates(String baseCurrency) async {
    final base = baseCurrency.toLowerCase();

    try {
      final response = await dio.get<Map<String, dynamic>>(
        '/gh/irfanokr/currency-api@main/v1/currencies/$base.json',
      );

      final data = response.data;
      if (data == null) {
        throw const ServerFailure('Сервер вернул пустой ответ');
      }

      return CurrencyRatesModel.fromJson(data, baseCurrency);
    } on DioException catch (e) {
      throw _mapDioError(e);
    }
  }

  /// Преобразует ошибку Dio в Failure доменного слоя.
  Failure _mapDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ConnectionFailure('Превышено время ожидания');
      case DioExceptionType.badResponse:
        return ServerFailure('Ошибка сервера: ${e.response?.statusCode}');
      case DioExceptionType.connectionError:
        return const ConnectionFailure('Нет соединения с интернетом');
      case DioExceptionType.cancel:
        return const UnknownFailure('Запрос отменён');
      case DioExceptionType.badCertificate:
        return const ServerFailure('Ошибка сертификата');
      case DioExceptionType.unknown:
        return UnknownFailure('Неизвестная ошибка: ${e.message}');
      default:
        return const UnknownFailure('Неизвестная ошибка');
    }
  }
}
