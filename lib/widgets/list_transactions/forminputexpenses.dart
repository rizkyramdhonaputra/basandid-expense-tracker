import 'package:aplikasi_catatbiaya/models/expenses.dart';
import 'package:flutter/material.dart';

class FormInputExpenses extends StatefulWidget {
  const FormInputExpenses({super.key, required this.onSubmitData});

  final void Function(Expenses data) onSubmitData;

  @override
  State<FormInputExpenses> createState() => _FormInputExpensesState();
}

class _FormInputExpensesState extends State<FormInputExpenses> {
  final _summaryInputController = TextEditingController();
  final _ammountInputController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  void _openDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1);
    final lastDate = DateTime.now().add(Duration(days: 7));

    final inputDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDate: now,
    );
    setState(() {
      _selectedDate = inputDate;
    });
  }

  void _submitTransaction() {
    final enteredAmount = double.tryParse(_ammountInputController.text);

    if (_summaryInputController.text.isEmpty ||
        enteredAmount == null && enteredAmount! < 0 ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: Text('Invalid Data!'),
              content: Text('Tolong Pastikan sudah input data dengan benar!'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text('Okay'),
                ),
              ],
            ),
      );
    }
    widget.onSubmitData(
      Expenses(
        transactionTitle: _summaryInputController.text,
        transactionDate: _selectedDate!,
        transactionAmount: enteredAmount!,
        transactionCategory: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _summaryInputController.dispose();
    _ammountInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
      child: Column(
        children: [
          TextField(
            maxLength: 50,
            controller: _summaryInputController,
            decoration: InputDecoration(label: Text('Summary Transaction')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  maxLength: 50,
                  controller: _ammountInputController,
                  decoration: InputDecoration(
                    label: Text('Amount'),
                    prefixText: 'Rp ',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'Pilih Tanggal'
                          : dateFormatter.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: _openDatePicker,
                      icon: Icon(Icons.calendar_month_outlined),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items:
                    Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase()),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel', style: TextStyle(color: Colors.red)),
              ),
              ElevatedButton(
                onPressed: _submitTransaction,
                child: Text('Submit'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
