import 'package:flutter/material.dart';
import 'package:mynote/my_expen/widgets/new_trasaction.dart';


class Fun{ 
  void showbottom(con) {
    showModalBottomSheet(
      context: con,
      builder: (context) {
        return Container(
          color: const Color.fromARGB(255, 240, 97, 87),
          height: 25,
          width: MediaQuery.of(context).size.width,
          child: const Center(
            child: Text('تم الحذف '),
          ),
        );
      },
    );
  }

   void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return SizedBox(
          width: MediaQuery.of(ctx).size.width,
          height: MediaQuery.of(ctx).size.height * 0.8,
          child: const NewTransaction(),
        );
      },
    );
  }
  
  void showmesseg(BuildContext ctx) {
    showDialog(
      context: ctx ,
     builder: (context) {
       return const AlertDialog(
title: Text('تمت العملية بنجاح'),
       );
     },);
  }

}