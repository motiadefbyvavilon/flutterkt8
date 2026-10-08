import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_currency_rates.dart';
import 'currency_rates_event.dart';
import 'currency_rates_state.dart';

class CurrencyRatesBloc extends Bloc<CurrencyRatesEvent, CurrencyRatesState> {
  final GetCurrencyRates getCurrencyRates;

  CurrencyRatesBloc(this.getCurrencyRates) : super(CurrencyRatesInitial()) {
    on<LoadRates>(_onLoadRates);
  }

  Future<void> _onLoadRates(
    LoadRates event,
    Emitter<CurrencyRatesState> emit,
  ) async {
    emit(CurrencyRatesLoading());

    final result = await getCurrencyRates(event.baseCurrency);

    result.fold(
      (failure) => emit(CurrencyRatesError(failure.message)),
      (rates) => emit(CurrencyRatesLoaded(rates)),
    );
  }
}
