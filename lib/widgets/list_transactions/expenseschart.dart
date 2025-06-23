import 'package:aplikasi_catatbiaya/models/expenses.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Expenseschart extends StatelessWidget {
  const Expenseschart({super.key, required this.dataTransaksi});

  final List<Expenses> dataTransaksi;

  List<ExpensesPerCategory> get transaksiPerCategory {
    return [
      ExpensesPerCategory.forCategory(
        category: Category.food,
        allTransactions: dataTransaksi,
      ),
      ExpensesPerCategory.forCategory(
        category: Category.transport,
        allTransactions: dataTransaksi,
      ),
      ExpensesPerCategory.forCategory(
        category: Category.coffee,
        allTransactions: dataTransaksi,
      ),
      ExpensesPerCategory.forCategory(
        category: Category.family,
        allTransactions: dataTransaksi,
      ),
    ];
  }

  double get maxAmount {
    double maxAmount = 0;
    for (final trx in dataTransaksi) {
      if (trx.transactionAmount > maxAmount) {
        maxAmount = trx.transactionAmount;
      }
    }
    return maxAmount;
  }

  Widget getTitle(double value, TitleMeta meta) {
    value = transaksiPerCategory[value.toInt()].category.index.toDouble();
    String title = transaksiPerCategory[value.toInt()].category.name;
    return SideTitleWidget(
      meta: meta,
      space: 4,
      child: Text(title.toUpperCase()),
    );
  }

  FlTitlesData get _titlesData => FlTitlesData(
    show: true,
    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: true, getTitlesWidget: getTitle),
    ),
  );

  List<BarChartGroupData> get _barGroups =>
      transaksiPerCategory
          .map(
            (trx) => BarChartGroupData(
              x: trx.category.index,
              barRods: [
                BarChartRodData(
                  toY: trx.totalAmount,
                  width: 25,
                  color: Color(Colors.deepOrange.toARGB32()),
                ),
              ],
              showingTooltipIndicators: [],
            ),
          )
          .toList();

  BarTouchData get _barTouchData => BarTouchData(
    enabled: true,
    touchTooltipData: BarTouchTooltipData(
      getTooltipColor: (barGroups) => Colors.transparent,
      tooltipMargin: 1,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Pengeluaran Per Kategori',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 40),
        AspectRatio(
          aspectRatio: 1.5,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceEvenly,
              maxY: maxAmount,
              minY: 0,
              borderData: FlBorderData(show: false),
              gridData: FlGridData(show: false),
              titlesData: _titlesData,
              barGroups: _barGroups,
              barTouchData: _barTouchData,
            ),
          ),
        ),
      ],
    );
  }
}
