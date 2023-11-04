import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mynote/data/sqldb.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});
  @override
  State<AddNote> createState() => _AddNoteState();
}
class _AddNoteState extends State<AddNote> {
  Sqldb sqldb = Sqldb();
//   Future setnote() async{
// var r=await sqldb.insertdata('insert into note(name) values($controlername)');
// return r;
//   }
  TextEditingController controlername = TextEditingController();
  TextEditingController controlerdit = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('اضافة ملاحظات'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: controlername,
                decoration: InputDecoration(
                  hintText: 'اسم الملاحظة',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: controlerdit,
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: 'تفاصيل الملاحظة',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () async {
                        var sql =
                            "insert into note(name,DIT,dat) values('${controlername.text.toString()}','${controlerdit.text.toString()}','${DateTime.now().day.toString()}'/'${DateTime.now().month.toString()}')";
                        var r = await sqldb.insertdata(sql);
                        log(r.toString());
                        controlername.clear();
                        controlerdit.clear();
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pushNamed('note');
                      },
                      color: Colors.blue,
                      child: const Text('حفظ'),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        Navigator.of(context).pushNamed('note');
                      },
                      color: Colors.blue,
                      child: const Text('الغاء الامر'),
                    ),
                  ],
                ),
              ),
              // Text(r.toString())
            ],
          ),
        ),
      ),
    );
  }
}
