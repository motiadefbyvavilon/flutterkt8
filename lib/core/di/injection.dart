import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/currency/data/datasources/currency_remote_data_source.dart';
import '../../features/currency/data/repositories/currency_repository_impl.dart';
import '../../features/currency/domain/repositories/currency_repository.dart';
import '../../features/currency/domain/usecases/get_currency_rates.dart';
import '../../features/currency/presentation/bloc/currency_rates_bloc.dart';
import '../network/dio_client.dart';

final sl = GetIt.instance; // service locator

/// Регистрация зависимостей.
Future<void> initDependencies() async {
  // Core
  sl.registerLazySingleton<Dio>(() => DioClient.create());

  // Data
  sl.registerLazySingleton<CurrencyRemoteDataSource>(
    () => CurrencyRemoteDataSource(sl()),
  );

  // Domain
  sl.registerLazySingleton<CurrencyRepository>(
    () => CurrencyRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<GetCurrencyRates>(
    () => GetCurrencyRates(sl()),
  );

  // Presentation
  sl.registerFactory<CurrencyRatesBloc>(
    () => CurrencyRatesBloc(sl()),
  );
}
