import 'package:aplikasi_catatbiaya/models/expenses.dart';
import 'package:flutter/material.dart';

class CardRecordedExpenses extends StatelessWidget {
  const CardRecordedExpenses(this.transaction, {super.key});

  final Expenses transaction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(transaction.transactionTitle),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(categoryIcons[transaction.transactionCategory]),
                Column(
                  children: [
                    Text(transaction.formattedDate),
                    Text(transaction.formattedAmount),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
