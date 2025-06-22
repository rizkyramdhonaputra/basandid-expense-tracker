import 'package:aplikasi_catatbiaya/widgets/dashboard_expenses.dart';
import 'package:flutter/material.dart';

var kColorSCheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 248, 127, 66),
);

void main() {
  runApp(const ExpenseTracker());
}

class ExpenseTracker extends StatelessWidget {
  const ExpenseTracker({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashboardExpenses(),
      theme: ThemeData().copyWith(
        colorScheme: kColorSCheme,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kColorSCheme.onPrimaryContainer,
          foregroundColor: kColorSCheme.primaryContainer,
        ),
      ),
    );
  }
}
