import 'package:equatable/equatable.dart';
import '../../domain/entities/currency_rates.dart';

abstract class CurrencyRatesState extends Equatable {
  const CurrencyRatesState();

  @override
  List<Object> get props => [];
}

class CurrencyRatesInitial extends CurrencyRatesState {}

class CurrencyRatesLoading extends CurrencyRatesState {}

class CurrencyRatesLoaded extends CurrencyRatesState {
  final CurrencyRates rates;
  const CurrencyRatesLoaded(this.rates);

  @override
  List<Object> get props => [rates];
}

class CurrencyRatesError extends CurrencyRatesState {
  final String message;
  const CurrencyRatesError(this.message);

  @override
  List<Object> get props => [message];
}
