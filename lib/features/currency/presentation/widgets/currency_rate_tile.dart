import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Карточка одной валюты с курсом.
class CurrencyRateTile extends StatelessWidget {
  final String code;
  final double rate;

  const CurrencyRateTile({
    super.key,
    required this.code,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    final format = NumberFormat('#,##0.0000', 'en_US');

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: Text(
          code.substring(0, 2),
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
      title: Text(code, style: const TextStyle(fontWeight: FontWeight.w600)),
      trailing: Text(
        format.format(rate),
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}
