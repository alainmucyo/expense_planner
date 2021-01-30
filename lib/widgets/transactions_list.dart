import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionsList({this.transactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      child: transactions.isEmpty
          ? Column(
              children: [
                Center(
                  child: Text(
                    "No Transactions available",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    "assets/waiting.png",
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                  elevation: 6,
                  child: Padding(
                    padding: EdgeInsets.all(6.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: FittedBox(child: Text('\$${transactions[index].amount}')),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(DateFormat.yMMMd().format(transactions[index].date)),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
