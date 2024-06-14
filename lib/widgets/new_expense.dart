import 'dart:io';

import 'package:expenses_app/Models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:intl/intl.dart';

var formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  // ignore: unused_element
  void _showDialog() {
    if(Platform.isIOS){
       showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text("Invalid Input"),
        content: const Text(
            "Please make sure valid title, amount, date and category was entered."),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("Okey"))
        ],
      ),
    );
    }
    else{
       showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text("Invalid Input"),
        content: const Text(
            "Please make sure valid title, amount, date and category was entered."),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("Okey"))
        ],
      ),
    );
    }
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text("Invalid Input"),
        content: const Text(
            "Please make sure valid title, amount, date and category was entered."),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("Okey"))
        ],
      ),
    );

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Invalid Input"),
        content: const Text(
            "Please make sure valid title, amount, date and category was entered."),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("Okey"))
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitedExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_amountController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      //  h...........................
      _showDialog();
      return;
    }
    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (context, Constraints) {
      // print(Constraints.maxWidth);
      // print(Constraints.maxWidth);
      // print(Constraints.maxHeight);
      // print(Constraints.minHeight);

      final width = Constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          maxLength: 50,
                          decoration: const InputDecoration(
                            label: Text('Title'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '\$ ',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _titleController,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text('Title'),
                    ),
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category.name.toUpperCase(),
                                ),
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
                      const SizedBox(width: 24),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No date selected'
                                  : formatter.format(_selectedDate!),
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(
                                Icons.calendar_month,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '\$ ',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No date selected'
                                  : formatter.format(_selectedDate!),
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(
                                Icons.calendar_month,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _submitedExpenseData,
                        child: const Text('Save Expense'),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category.name.toUpperCase(),
                                ),
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
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _submitedExpenseData,
                        child: const Text('Save Expense'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   throw UnimplementedError();
  // }



// import 'dart:ffi';






// import 'package:expenses_app/Models/expense.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:expenses_app/Models/expense.dart';

// var formatter = DateFormat.yMd();

// class NewExpense extends StatefulWidget {
//   const NewExpense({super.key});

//   @override
//   State<NewExpense> createState() => _NewExpenseState();
// }

// class _NewExpenseState extends State<NewExpense> {
//   // var _enteredTitle = "";

//   // void _saveTitleInput(String inputValue) {
//   //   _enteredTitle = inputValue;
//   // }

//   final _titleControllar = TextEditingController();
//   final _amountControllar = TextEditingController();

//   DateTime? _selectedDate;
// Category _selectedCategory = Category.leisure;

//   void _presetDatePicker() async {
//     final now = DateTime.now();
//     final firstDate = DateTime(now.year - 1, now.day, now.month);
//     final pickDate = await showDatePicker(
//       context: context,
//       firstDate: firstDate,
//       lastDate: now,
//     );
//     setState(() {
//       _selectedDate = pickDate;
//     });
//   }

//   @override
//   void dispose() {
//     _titleControllar.dispose();
//     _amountControllar.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         children: [
//           TextField(
//             // onChanged: _saveTitleInput,
//             controller: _titleControllar,
//             maxLength: 50,
//             decoration: const InputDecoration(
//               label: Text("Title"),
//             ),
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   // onChanged: _saveTitleInput,
//                   controller: _amountControllar,
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(
//                     label: Text("Amount"),
//                     prefixText: '\$ ',
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       _selectedDate == null
//                           ? "No Date selected"
//                           : formatter.format(_selectedDate!),
//                     ),
//                     IconButton(
//                       onPressed: _presetDatePicker,
//                       icon: const Icon(Icons.calendar_month),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//           Row(
//             children: [
//               DropdownButton(
//                 value: _selectedCategory,
//                 items: Category.values
//                     .map(
//                       (category) => DropdownMenuItem(
//                         value: category,
//                         child: Text(
//                           category.name.toUpperCase(),
//                         ),
//                       ),
//                     )
//                     .toList(),
//                 onChanged: (value) {
//                   if (value == null) {
//                     return;
//                   }
//                   setState(() {
//                     _selectedCategory = value;
//                   });
//                 },
//               ),
//               TextButton(
//                 onPressed: () {},
//                 child: const Text("cancel"),
//               ),
//               ElevatedButton(
//                 // ignore: avoid_print
//                 onPressed: () {
//                   print(_titleControllar);
//                   print(_amountControllar);
//                 },

//                 // onPressed: () => print(_titleControllar),
//                 // onPressed: () => print(_amountControllar),

//                 child: const Text("Save Expense"),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
