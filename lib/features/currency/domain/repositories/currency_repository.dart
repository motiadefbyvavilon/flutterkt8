import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/currency_rates.dart';

/// Абстракция репозитория — домен не знает, откуда берутся данные.
abstract class CurrencyRepository {
  /// Получить курсы валют относительно базовой валюты.
  Future<Either<Failure, CurrencyRates>> getRates(String baseCurrency);
}
