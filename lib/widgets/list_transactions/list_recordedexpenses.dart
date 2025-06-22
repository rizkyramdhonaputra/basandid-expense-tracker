import 'package:aplikasi_catatbiaya/models/expenses.dart';
import 'package:aplikasi_catatbiaya/widgets/list_transactions/card_recordedexpenses.dart';
import 'package:flutter/material.dart';

class ListRecordedExpenses extends StatelessWidget {
  const ListRecordedExpenses({
    super.key,
    required this.recordedExpenses,
    required this.onRemoveData,
  });
  final List<Expenses> recordedExpenses;
  final void Function(Expenses data) onRemoveData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: recordedExpenses.length,
      itemBuilder:
          (context, index) => Dismissible(
            key: ValueKey(recordedExpenses[index]),
            onDismissed: (direction) => onRemoveData(recordedExpenses[index]),
            child: CardRecordedExpenses(recordedExpenses[index]),
          ),
    );
  }
}
