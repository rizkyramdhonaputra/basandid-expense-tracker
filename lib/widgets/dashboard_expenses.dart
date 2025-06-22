import 'package:aplikasi_catatbiaya/models/expenses.dart';
import 'package:aplikasi_catatbiaya/widgets/list_transactions/expenseschart.dart';
import 'package:aplikasi_catatbiaya/widgets/list_transactions/forminputexpenses.dart';
import 'package:aplikasi_catatbiaya/widgets/list_transactions/list_recordedexpenses.dart';
import 'package:flutter/material.dart';

class DashboardExpenses extends StatefulWidget {
  const DashboardExpenses({super.key});

  @override
  State<DashboardExpenses> createState() => _DashboardExpensesState();
}

class _DashboardExpensesState extends State<DashboardExpenses> {
  final List<Expenses> _recordedTransactions = [
    Expenses(
      transactionTitle: 'Test1',
      transactionDate: DateTime.now(),
      transactionAmount: 100000,
      transactionCategory: Category.coffee,
    ),
    Expenses(
      transactionTitle: 'Test2',
      transactionDate: DateTime.now(),
      transactionAmount: 200000,
      transactionCategory: Category.food,
    ),
  ];

  void _openFormInput() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => FormInputExpenses(onSubmitData: _addTransaction),
    );
  }

  void _addTransaction(Expenses transaction) {
    setState(() {
      _recordedTransactions.add(transaction);
    });
  }

  void _removeTransaction(Expenses transaction) {
    final indexDeletedTransaction = _recordedTransactions.indexOf(transaction);
    setState(() {
      _recordedTransactions.remove(transaction);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Transaksi dihapus!'),
        duration: Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Undo',
          onPressed:
              () => setState(() {
                _recordedTransactions.insert(
                  indexDeletedTransaction,
                  transaction,
                );
              }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Text(
        'Tidak terdapat data apapun, silahkan tambahkan data transaksi!',
        textAlign: TextAlign.center,
      ),
    );

    if (_recordedTransactions.isNotEmpty) {
      mainContent = ListRecordedExpenses(
        onRemoveData: (data) => _removeTransaction(data),
        recordedExpenses: _recordedTransactions,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses Tracker Apps'),
        actions: [IconButton(onPressed: _openFormInput, icon: Icon(Icons.add))],
      ),
      body: Column(children: [Expenseschart(dataTransaksi: _recordedTransactions), Expanded(child: mainContent)]),
    );
  }
}
