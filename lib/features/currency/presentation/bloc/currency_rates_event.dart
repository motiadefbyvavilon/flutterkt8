import 'package:equatable/equatable.dart';

abstract class CurrencyRatesEvent extends Equatable {
  const CurrencyRatesEvent();

  @override
  List<Object> get props => [];
}

/// Загрузить курсы для указанной базовой валюты.
class LoadRates extends CurrencyRatesEvent {
  final String baseCurrency;

  const LoadRates(this.baseCurrency);

  @override
  List<Object> get props => [baseCurrency];
}
