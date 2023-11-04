import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mynote/data/sqldb.dart';

class Note extends StatefulWidget {
  const Note({super.key});
  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
   Sqldb sqldb = Sqldb();
  Future sele() async {
    List result = await sqldb.selectdata('select * from note');
    log(result.toString());
    return result;
  }
  @override
  void initState() {
    sele();
    super.initState();
  }
  void showbottom(){
    showModalBottomSheet(
      context:context , 
      builder: (context) {
        return Container(
          color: const Color.fromARGB(255, 240, 97, 87),
          height: 25,
          child:const Text( 
            'تم الحذف '
            ),
          );
      },
    );
  }
  // del(int i)async {
  //     await sqldb.deletedata('delete from note where id=$i');
  //     log('تم الحذف');
   
  // }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('جميع الملاحظات'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('addnote');
          },
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder(
          future: sele(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                itemCount: snapshot.data.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
                itemBuilder: (BuildContext context, int i) {
                  return Dismissible(
                    key: Key(snapshot.data[i].toString()),
                    onDismissed: (direction ) {
                     setState(() {
            sqldb.deletedata('delete from note where id=${snapshot.data[i]['id']}');
                  //  if (r>0) {
                  //    Navigator.of(context).pushNamed('name');
                  //  }
                     });
                    },
                    child: Card(
                      elevation: 3.0,
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: Colors.grey,
                      child: ListTile(
                        title: Text('$i  ${snapshot.data[i]['name']}'),
                        subtitle: Text('$i  ${snapshot.data[i]['dit']}'),
                        leading:Text('$i  ${snapshot.data[i]['dat']}'),
                        trailing:  Padding(
                          padding: const EdgeInsets.only(left: 0,bottom: 0,right: 0,top: 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: ()  {
                                  setState(() {
                                         sqldb.deletedata('update from note set where id=${snapshot.data[i]['id']}');
                                  });
                                },
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () async {
                                  setState(() {
                                         sqldb.deletedata('delete from note where id=${snapshot.data[i]['id']}');
                                         showbottom();
                                  });
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              // return const CircularProgressIndicator();
              return const Text('لاتوجد ملاحظات ');
            }
          },
        
        ),
      
      ),
    );
  }
}
