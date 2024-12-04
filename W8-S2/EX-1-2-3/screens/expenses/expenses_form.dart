import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/expense.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key, required this.onCreated});

  final Function(Expense) onCreated;

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class CategoryDropdown extends StatefulWidget {
  final ValueChanged<Category?> onChanged;

  const CategoryDropdown({super.key, required this.onChanged});

  @override
  // ignore: library_private_types_in_public_api
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  Category? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150, 
      child: DropdownButton<Category>(
        hint: const Text('Select Category'),
        value: _selectedCategory,
        isExpanded: false,
        onChanged: (Category? newValue) {
          setState(() {
            _selectedCategory = newValue;
          });
          widget.onChanged(newValue); 
        },
        items: Category.values.map((Category category) {
          return DropdownMenuItem<Category>(
            value: category,
            child: Text(category.toString().split('.').last.toUpperCase()),
          );
        }).toList(),
      ),
    );
  }
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  Category? _selectedCategory;
  DateTime? _selectedDate;

  String get title => _titleController.text;

  void _showValidationDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Invalid Input'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked; 
      });
    }
  }

  void _submit() {
    String title = _titleController.text.trim();
    String amountStr = _valueController.text.trim();

    if (title.isEmpty) {
      _showValidationDialog('Please enter a title.');
      return;
    }

    if (amountStr.isEmpty) {
      _showValidationDialog('Please enter an amount.');
      return;
    }

    double? amount = double.tryParse(amountStr);
    if (amount == null || amount <= 0) {
      _showValidationDialog('Please enter a positive amount.');
      return;
    }

    if (_selectedCategory == null) {
      _showValidationDialog('Please select a category.');
      return;
    }

    if (_selectedDate == null) {
      _showValidationDialog('Please select a date.');
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              'Title: $title, Amount: $amount, Category: ${_selectedCategory.toString().split('.').last}')),
    );

    Expense expense = Expense(
        title: title,
        amount: double.parse(amountStr),
        date: _selectedDate!, 
        category: _selectedCategory!);

    widget.onCreated(expense);
    Navigator.pop(context);

    _titleController.clear();
    _valueController.clear();
    setState(() {
      _selectedCategory = null; 
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void onCancel() {
    // Close modal
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^-?\d*\.?\d{0,2}'),
              ),
            ],
            controller: _valueController,
            maxLength: 50,
            decoration: const InputDecoration(
              prefix: Text('\$ '),
              label: Text('Amount'),
            ),
          ),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
            children: [
              Expanded(
                child: CategoryDropdown(
                  onChanged: (Category? newValue) {
                    setState(() {
                      _selectedCategory =
                          newValue; // Update the selected category
                    });
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _selectDate(context), // Open the date picker
              ),
              const SizedBox(width: 10), // Spacing between icon and date text
              Text(
                _selectedDate != null
                    ? _selectedDate!
                        .toLocal()
                        .toString()
                        .split(' ')[0] // Show selected date
                    : 'No date selected',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: onCancel, child: const Text('Cancel')),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(onPressed: _submit, child: const Text('Create')),
            ],
          )
        ],
      ),
    );
  }
}
