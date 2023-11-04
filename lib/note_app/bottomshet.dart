import 'package:flutter/material.dart';

class BottomShet extends StatefulWidget {
  const BottomShet({super.key});

  @override
  State<BottomShet> createState() => _BottomShetState();
}

class _BottomShetState extends State<BottomShet> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SnackBar(
        content:Container(
          color: Colors.amber,
          height: MediaQuery.of(context).size.height-0.7,
          child:Text( '${DateTime.now().day.toString()} '),
          ),

      ) ,
    );
  }
}