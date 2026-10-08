import 'package:equatable/equatable.dart';

/// Чистая доменная сущность — курсы валют.
class CurrencyRates extends Equatable {
  final String baseCurrency;
  final String date;
  final Map<String, double> rates;

  const CurrencyRates({
    required this.baseCurrency,
    required this.date,
    required this.rates,
  });

  @override
  List<Object> get props => [baseCurrency, date, rates];
}
