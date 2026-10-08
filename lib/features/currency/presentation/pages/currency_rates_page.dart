import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../bloc/currency_rates_bloc.dart';
import '../bloc/currency_rates_event.dart';
import '../bloc/currency_rates_state.dart';
import '../widgets/currency_rate_tile.dart';

/// Главный экран — показывает курсы валют.
class CurrencyRatesPage extends StatelessWidget {
  const CurrencyRatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CurrencyRatesBloc>()..add(const LoadRates('USD')),
      child: const _CurrencyRatesView(),
    );
  }
}

class _CurrencyRatesView extends StatelessWidget {
  const _CurrencyRatesView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Курсы валют'),
        actions: [
          // Кнопки переключения базовой валюты.
          BlocBuilder<CurrencyRatesBloc, CurrencyRatesState>(
            builder: (context, state) {
              return Row(
                children: ['USD', 'EUR', 'GBP'].map((base) {
                  return TextButton(
                    onPressed: () {
                      context.read<CurrencyRatesBloc>().add(LoadRates(base));
                    },
                    child: Text(
                      base,
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<CurrencyRatesBloc, CurrencyRatesState>(
        builder: (context, state) {
          if (state is CurrencyRatesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CurrencyRatesError) {
            return _ErrorView(
              message: state.message,
              onRetry: () {
                context.read<CurrencyRatesBloc>().add(const LoadRates('USD'));
              },
            );
          }

          if (state is CurrencyRatesLoaded) {
            final rates = state.rates;
            final sorted = rates.rates.entries.toList()
              ..sort((a, b) => a.key.compareTo(b.key));

            return RefreshIndicator(
              onRefresh: () async {
                context
                    .read<CurrencyRatesBloc>()
                    .add(LoadRates(rates.baseCurrency));
              },
              child: ListView(
                children: [
                  // Заголовок с базовой валютой и датой
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'База: ${rates.baseCurrency}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Дата обновления: ${rates.date}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  // Список курсов
                  ...sorted.map(
                    (e) => CurrencyRateTile(code: e.key, rate: e.value),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

/// Виджет ошибки с кнопкой "Повторить".
class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off, size: 64, color: Colors.grey),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Повторить'),
            ),
          ],
        ),
      ),
    );
  }
}
