import '../../domain/entities/currency_rates.dart';

/// DTO — модель данных с API.
/// Структура ответа: { "date": "...", "usd": { "eur": 0.85, ... } }
class CurrencyRatesModel extends CurrencyRates {
  const CurrencyRatesModel({
    required super.baseCurrency,
    required super.date,
    required super.rates,
  });

  /// Парсинг JSON. API возвращает:
  /// {
  ///   "date": "2026-04-29",
  ///   "usd": { "eur": 0.85, "gbp": 0.73, ... }
  /// }
  factory CurrencyRatesModel.fromJson(
    Map<String, dynamic> json,
    String baseCurrency,
  ) {
    final base = baseCurrency.toLowerCase();
    final rawRates = json[base] as Map<String, dynamic>? ?? {};

    // Преобразуем все значения в double, отбрасывая невалидные.
    final rates = <String, double>{};
    rawRates.forEach((key, value) {
      if (value is num) {
        rates[key.toUpperCase()] = value.toDouble();
      }
    });

    return CurrencyRatesModel(
      baseCurrency: baseCurrency.toUpperCase(),
      date: json['date'] as String? ?? '',
      rates: rates,
    );
  }
}
