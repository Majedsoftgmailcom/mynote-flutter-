import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mynote/data/sqldb.dart';
import 'package:mynote/my_expen/widgets/char_bar.dart';

class Chart extends StatefulWidget {
  //final List recentTransactions;

  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
    int i = 0;

  Sqldb sqldb = Sqldb();
  List r = [];
  Future sele() async {
    List result = await sqldb.selectdata('select * from tran');
    r.addAll(result);
    return result;
  }

  @override
  void initState() {
    sele();
    super.initState();
  }

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      // for (var i = 0; i < r.length; i++) {
      //   if (r[i]['dat'].day == weekDay.day &&
      //       r[i].date.month == weekDay.month &&
      //       r[i].date.year == weekDay.year) {
         // totalSum += r[i].amount;
       // }
      // }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      var s = double.parse(item['amount'].toString());
      return sum + s;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: FutureBuilder(
                future: sele(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ChartBar(
                      //snapshot.data[i++]['PRIC'].toString(),
                      data['day'].toString(),
                      double.parse(data['amount'].toString()),
                      totalSpending == 0.0
                          ? 0.0
                          : (data['amount'] as double) / totalSpending,
                    );
                  } else {
                    return const Text('data');
                  }
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
  //   return SizedBox(
  //     child: Card(
  //       elevation: 6,
  //       margin:  const EdgeInsets.all(20),
  //       child: Padding(
  //         padding:  const EdgeInsets.all(10),
  //         child: SizedBox(
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             children: [
  //               groupedTransactionValues().map(
  //                 (e) {
  //                   return FutureBuilder(
  //                     future: sele(),
  //                     builder: (
  //                       BuildContext context, AsyncSnapshot snapshot) {
  //                       return Flexible(
  //                         fit: FlexFit.tight,
  //                         child: ChartBar(
  //                           e['day'].toString(),
  //                          // snapshot.data[1]['id'].toString(),
  //                           double.parse(snapshot.data[1]['PRIC'].toString())
  //                               .toDouble(),
  //                           double.parse(snapshot.data[1]['PRIC'].toString())
  //                               .toDouble(),
  //                           //    double.parse(snapshot.data[1]['PRIC'])
  //                         ),
  //                       );
  //                     },
  //                   );
  //                 },
  //               ).toList()
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
