import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final inputTitleController = TextEditingController();

  final inputAmountController = TextEditingController();

  void submitted() {
    final title = inputTitleController.text;
    final amount = double.parse(inputAmountController.text);
    if (title.isEmpty || amount <= 0) return;
    widget.addTransaction(
        inputTitleController.text, double.parse(inputAmountController.text));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: inputTitleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: inputAmountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitted(),
            ),
            FlatButton(
              onPressed: submitted,
              child: Text("Add transaction".toUpperCase()),
              textColor: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
