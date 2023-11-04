
import 'package:flutter/material.dart';

import 'package:mynote/my_expen/widgets/new_trasaction.dart';
import 'package:mynote/my_expen/widgets/transection_list2.dart';
import 'package:mynote/note_app/add_note.dart';
import 'package:mynote/my_expen/login.dart';
import 'package:mynote/note_app/note.dart';
void main() {
  runApp(const MyApp());
}
ThemeData th=ThemeData.dark(
  useMaterial3: true,
);
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: th,
      // theme: ThemeData(
      //   useMaterial3: false,
    
      //   iconTheme: const IconThemeData(
      //     color: Colors.blue,
      //   ),
      //   primarySwatch: Colors.deepPurple,
      //   //secondary: Colors.orange,
      //   cardColor: Colors.orange,
      //   textTheme:  const TextTheme(
      //     displayMedium: TextStyle(
      //       fontFamily: 'OpenSans',
      //       fontSize: 45.0,
      //       color: Colors.orange,
      //     ),
      //     labelLarge: TextStyle(
      //       fontFamily: 'OpenSans',
      //     ),
      //     titleMedium: TextStyle(fontFamily: 'NotoSans'),
      //     bodyMedium: TextStyle(fontFamily: 'NotoSans'),
      //   ),
      // ),
      debugShowCheckedModeBanner: false,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
       home:   const LoginS(),
       routes: {
        "addnote":(context) => const AddNote(),
        "note":(context) => const Note(),
        "tran2":(context) => const Note2(),
        "new_tran":(context) => const NewTransaction(),
       },
    );
  }
}
