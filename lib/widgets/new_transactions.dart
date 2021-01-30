import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final inputTitleController = TextEditingController();
  final inputAmountController = TextEditingController();
  DateTime selectedDate;

  void _submitted() {
    final title = inputTitleController.text;
    final amount = double.parse(inputAmountController.text);
    if (title.isEmpty || amount <= 0 || selectedDate == null) return;
    widget.addTransaction(
        inputTitleController.text, double.parse(inputAmountController.text), selectedDate);
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((value) {
          print(value);
      if (value == null) return;
      setState(() {
        selectedDate = value;
      });
    });
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
              onSubmitted: (_) => _submitted(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      selectedDate == null
                          ? "No date chosen!"
                          : DateFormat().add_yMMMMd().format(selectedDate),
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  FlatButton(
                      onPressed: _showDatePicker,
                      child: Text(
                        "Choose date...",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
            RaisedButton(
              onPressed: _submitted,
              child: Text("Add transaction".toUpperCase()),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
