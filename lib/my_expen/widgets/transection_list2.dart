import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mynote/data/fun.dart';
import 'package:mynote/data/sqldb.dart';
import 'package:mynote/my_expen/widgets/chart.dart';
import 'package:mynote/my_expen/widgets/drawer.dart';
import 'package:mynote/my_expen/widgets/edit_trasaction.dart';

class Note2 extends StatefulWidget {
  const Note2({super.key});
  @override
  State<Note2> createState() => _Note2State();
}

class _Note2State extends State<Note2> {
  Sqldb sqldb = Sqldb();
  Fun fun = Fun();

  var r = [];
  Future sele() async {
    List result = await sqldb.selectdata('select * from tran');
    r.addAll(result);
    log(result.toString());
    return result;
  }

  @override
  void initState() {
    sele();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('  مصروفاتي اليومية'),
        ),
        drawer: const MyDrawer(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => fun.startAddNewTransaction(context),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Chart(),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: FutureBuilder(
                  future: sele(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int i) {
                            return Dismissible(
                              direction: DismissDirection.startToEnd,
                              key: Key(snapshot.data[i]['id'].toString()),
                              onDismissed: (direction) {
                                setState(() {
                                  sqldb.deletedata(
                                      'delete from tran where id=${snapshot.data[i]['id']}');
                                });
                              },
                              child: Card(
                                elevation: 5,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 5,
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 30,
                                    child: Padding(
                                      padding: const EdgeInsets.all(6),
                                      child: Center(
                                        child:
                                            Text('${snapshot.data[i]['PRIC']}'),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    '${snapshot.data[i]['name']}',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  subtitle: Text(
                                    '${snapshot.data[i]['dat']}',
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Stack(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .center,
                                                  children: [
                                                    Positioned(
                                                      child: SizedBox(
                                                        height: 400,
                                                        child: Edite_page(
                                                            name:
                                                                snapshot.data[i]
                                                                    ['name'],
                                                            pric:
                                                                snapshot.data[i]
                                                                    ['PRIC'],
                                                            date: snapshot
                                                                .data[i]['dat'],
                                                            id: snapshot.data[i]
                                                                ['id']),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                            // Navigator.of(context)
                                            //     .pushNamed('edit');
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            sqldb.deletedata(
                                                'delete from tran where id=${snapshot.data[i]['id']}');
                                            fun.showmesseg(context);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    } else {
                      // return const CircularProgressIndicator();
                      return const Text('لاتوجد بيانات ');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
