import 'package:expense_planner/widgets/chart.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'widgets/new_transactions.dart';
import 'widgets/transactions_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Transaction> _transactions = [];

  List<Transaction> get _recentTransactions {
    return _transactions
        .where(
          (el) => el.date.isAfter(DateTime.now().subtract(
            Duration(days: 7),
          )),
        )
        .toList();
  }

  void _addTransaction(String title, double amount, DateTime date) {
    setState(() {
      _transactions.add(Transaction(
          id: DateTime.now().toString(),
          title: title,
          amount: amount,
          date: date));
    });
  }

  void _removeTransaction(int index) {
    setState(() {
      _transactions.removeAt(index);
    });
  }

  void _startAddingTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (ctx) {
          return NewTransaction(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.purpleAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(fontSize: 18, color: Colors.blueGrey[800]))),
      home: Scaffold(
        backgroundColor: Color.fromRGBO(247, 250, 252, 1),
        appBar: AppBar(
          title: Text("Expense Planner"),
          actions: [
            Builder(
              builder: (context) => IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _startAddingTransaction(context)),
            )
          ],
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: Chart(_recentTransactions),
                ),
                TransactionsList(
                  transactions: _transactions,
                  removeTransaction: _removeTransaction,
                )
              ],
            ),
          ),
        ),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => _startAddingTransaction(context),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      ),
    );
  }
}
