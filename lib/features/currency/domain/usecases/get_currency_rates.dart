import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/currency_rates.dart';
import '../repositories/currency_repository.dart';

/// UseCase: получить курсы валют.
class GetCurrencyRates implements UseCase<CurrencyRates, String> {
  final CurrencyRepository repository;

  GetCurrencyRates(this.repository);

  @override
  Future<Either<Failure, CurrencyRates>> call(String baseCurrency) {
    return repository.getRates(baseCurrency);
  }
}
