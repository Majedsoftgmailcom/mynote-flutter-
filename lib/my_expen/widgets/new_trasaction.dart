import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mynote/data/sqldb.dart';

class NewTransaction extends StatefulWidget {
  // final Function addTx;

  //const NewTransaction(this.addTx, {super.key});
  const NewTransaction({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  Sqldb sqldb = Sqldb();
  var titleController = TextEditingController();
  late final _amountController = TextEditingController();
  late DateTime _selectedDate = DateTime.now();
  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Card(
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: const InputDecoration(labelText: 'العنوان'),
                    controller: titleController,

                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'المبلغ'),
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                   
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          // ignore: unnecessary_null_comparison
                          _selectedDate == null
                              ? 'No Date Chosen!'
                              : 'التاريخ: '
                                  '${DateFormat.yMd().format(_selectedDate)}',
                        ),
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.date_range_outlined),
                        onPressed: _presentDatePicker,
                        label: const Text(
                          'اختر تاريخ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      var sql =
                          "insert into tran(name,PRIC,dat) values('${titleController.text.toString()}','${_amountController.text.toString()}','${DateFormat.yMd().format(_selectedDate)}')";
                      sqldb.insertdata(sql);

                      _submitData();
                    },
                    child: const Text('حفظ'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
