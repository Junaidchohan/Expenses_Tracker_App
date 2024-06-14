import 'package:expenses_app/Models/expense.dart';
import 'package:expenses_app/widgets/chart/chart.dart';
import 'package:expenses_app/widgets/expenses_list/expenses_list.dart';
import 'package:expenses_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
// final List <Expenses> regestredExpense =[
//   Expenses()
//  ];

  final List<Expense> _regestredExpense = [
    Expense(
      title: 'Flutter developer',
      amount: 99.0,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Dinner',
      amount: 999.0,
      date: DateTime.now(),
      category: Category.food,
    )
  ];

  void _openAddExpenseOverly() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _regestredExpense.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    final expenseIndex = _regestredExpense.indexOf(expense);
    setState(
      () {
        _regestredExpense.remove(expense);
      },
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text("Expense deleted."),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          setState(
            () {
              _regestredExpense.insert(expenseIndex, expense);
            },
          );
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.of(context).size.width);

    // print(MediaQuery.of(context).size.width);
    // print(MediaQuery.of(context).size.height);
    
    Widget mainContant =
        const Center(child: Text("No expense found. Start adding some!"));

    if (_regestredExpense.isNotEmpty) {
      mainContant = ExpensesList(
        expenses: _regestredExpense,
        onRemoveExpense: removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: (const Text('Flutter ExpenseTracker')),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverly,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _regestredExpense),
                Expanded(child: mainContant),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _regestredExpense),),
                Expanded(child: mainContant),
              ],
            ),
    );
  }
}
