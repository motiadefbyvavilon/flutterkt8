import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/currency_rates.dart';
import '../../domain/repositories/currency_repository.dart';
import '../datasources/currency_remote_data_source.dart';

/// Реализация репозитория — домен зависит от абстракции, а не от этого класса.
class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyRemoteDataSource remoteDataSource;

  CurrencyRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, CurrencyRates>> getRates(String baseCurrency) async {
    try {
      final model = await remoteDataSource.getRates(baseCurrency);
      return Right(model); // модель наследует CurrencyRates
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      return Left(UnknownFailure('Не удалось обработать данные: $e'));
    }
  }
}
