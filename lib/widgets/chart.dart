import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double weekAmount = 0.0;
      DateTime currentDate;
      for (var i = 0; i < recentTransactions.length; i++) {
        currentDate = recentTransactions[i].date;
        if (currentDate.day == weekDay.day &&
            currentDate.month == weekDay.month &&
            currentDate.year == weekDay.year) {
          weekAmount += recentTransactions[i].amount;
        }
      }
      return {"day": DateFormat.E().format(weekDay)[0], "amount": weekAmount};
    }).reversed.toList();
  }

  double get totalAmount {
    return groupedTransactions.fold(
        0.0, (previousValue, element) => previousValue + element["amount"]);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...groupedTransactions.map((t) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  amount: t['amount'],
                  label: t['day'],
                  amountPercent: totalAmount == 0.0
                      ? 0.0
                      : (t['amount'] as double) / totalAmount,
                ),
              );
            }).toSet(),
          ],
        ),
      ),
    );
  }
}
