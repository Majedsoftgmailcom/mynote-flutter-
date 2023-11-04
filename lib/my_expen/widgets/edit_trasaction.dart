// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mynote/data/fun.dart';
import 'package:mynote/data/sqldb.dart';

class Edite_page extends StatefulWidget {
  final String name;
  final String pric;
  final String date;
  final int id;
  const Edite_page(
      {super.key,
      required this.name,
      required this.pric,
      required this.date,
      required this.id});

  @override
  // ignore: library_private_types_in_public_api
  Edite_pageState createState() => Edite_pageState();
}

class Edite_pageState extends State<Edite_page> {
  Sqldb sqldb = Sqldb();
  Fun fun=Fun();
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
  void initState() {
    titleController.text = widget.name;
    _amountController.text = widget.pric;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 5,
          shape:
              BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            : '${DateFormat.MEd().format(_selectedDate)}'
                                '  / التاريخ ',
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
                    setState(() {
                      var sql = """
UPDATE tran SET name='${titleController.text.toString()}',
                PRIC= '${_amountController.text.toString()}',
                dat='${DateFormat.yMd().format(_selectedDate)}'
                WHERE id= ${widget.id}
""";
                      sqldb.updatedata(sql);
                       _submitData();
fun.showmesseg(context);
                     
                      
                    });
                  },
                  child: const Text(
                    'تعديل',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
