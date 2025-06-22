import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final dateFormatter = DateFormat.yMEd();
final amountFormatter = NumberFormat.currency(decimalDigits: 2, symbol: 'Rp');

const uuid = Uuid();

enum Category { food, transport, coffee, family }

const categoryIcons = {
  Category.food: Icons.lunch_dining_rounded,
  Category.transport: Icons.train_rounded,
  Category.coffee: Icons.coffee_rounded,
  Category.family: Icons.family_restroom_rounded,
};

class Expenses {
  Expenses({
    required this.transactionTitle,
    required this.transactionDate,
    required this.transactionAmount,
    required this.transactionCategory,
  }) : id = uuid.v4();

  final String id;
  final String transactionTitle;
  final DateTime transactionDate;
  final double transactionAmount;
  final Category transactionCategory;

  String get formattedDate {
    return dateFormatter.format(transactionDate);
  }

  String get formattedAmount {
    return amountFormatter.format(transactionAmount);
  }
}

class ExpensesPerCategory {
  ExpensesPerCategory({required this.category, required this.listTransaction});

  ExpensesPerCategory.forCategory({
    required this.category,
    required List<Expenses> allTransactions,
  }) : listTransaction =
           allTransactions
               .where((expense) => expense.transactionCategory == category)
               .toList();

  final Category category;
  final List<Expenses> listTransaction;


  double get totalAmount {
    double sum = 0;
    for (final transaksi in listTransaction) {
      sum += transaksi.transactionAmount;
    }
    return sum;
  }

  String get formattedTotalAmount {
    return amountFormatter.format(totalAmount);
  }
}
