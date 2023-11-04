import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        color: Colors.amber,
        child: ListTile(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('new_tran');
          },
          title: const Text('عملية جديده'),
          leading: const Icon(Icons.newspaper_sharp),
        ),
      ),
    );
  }
}
