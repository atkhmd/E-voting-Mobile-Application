import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math' as math;

class FpaPage extends StatefulWidget {
  const FpaPage({Key? key}) : super(key: key);

  @override
  _FpaPageState createState() => _FpaPageState();
}

class _FpaPageState extends State<FpaPage> {
  bool loading = true;
  List<String> candidateList = [];
  @override
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: FirebaseFirestore.instance
          .runTransaction((Transaction transaction) async {
        CollectionReference reference =
            FirebaseFirestore.instance.collection('voteFpa');
        // Get docs from collection reference
        QuerySnapshot querySnapshot = await reference.get();
        // Get data from docs and convert map to List
        await FirebaseFirestore.instance
            .collection('voteFpa')
            .get()
            .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            print(doc["candidate"]);
            candidateList.add(doc['candidateName']);
          });
        });
        return candidateList;
      }), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text('Please wait its loading...'));
        } else {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Scaffold(
                body: Center(
                    child: SfCircularChart(
                        series: <CircularSeries>[
                  // Renders doughnut chart
                  DoughnutSeries<ChartData, String>(
                    dataSource: getDataSource(),
                    //chartData,
                    pointColorMapper: (ChartData data, _) => data.color,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => int.parse(data.y),
                    //dataLabelMapper: (ChartData data, _) => data.text,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    explode: true,
                    explodeGesture: ActivationMode.singleTap,
                    innerRadius: '70%',
                  ),
                ],
                        legend: Legend(
                            isVisible: true,
                            overflowMode: LegendItemOverflowMode.wrap,
                            title: LegendTitle(
                              text: 'FPA Results',
                              textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500),
                            )))));
          }
          // snapshot.data  :- get your object which is pass from your downloadData() function
        }
      },
    );
  }

  getDataSource() {
    List<ChartData> dataSource = [];
    var map = Map();

    for (var element in candidateList) {
      if (!map.containsKey(element)) {
        map[element] = 1;
      } else {
        map[element] += 1;
      }
    }
    print(candidateList.length);
    print(map);
    map.forEach((k, v) => dataSource.add(ChartData(
        k,
        v.toString(),
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(1.0))));
    return dataSource;
  }
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//             child: Container(
//                 child: SfCircularChart(
//                     series: <CircularSeries>[
//           // Renders doughnut chart
//           DoughnutSeries<ChartData, String>(
//             dataSource: [
//               ChartData(' Aqil', '4', Colors.pink.shade400),
//               ChartData('Dawson ', '3', Colors.purple.shade300),
//               ChartData(' Idris', '2', Colors.blue.shade900),
//               //             QuerySnapshot querySnapshot = await reference.get();
//               //             var users = [];
//               //             int count = 0;
//               //             // Get data from docs and convert map to List
//               //             await FirebaseFirestore.instance
//               //             .collection('voteFPA')
//               //             .get()
//               //             .then((QuerySnapshot querySnapshot) {
//               //              querySnapshot.docs.forEach((doc) {
//               //             users.add(doc[]);
//               //             print(doc["candidate"]);
//               //     });
//               //   });
//               //   print(count);
//             ],
//             // chartData,
//             pointColorMapper: (ChartData data, _) => data.color,
//             xValueMapper: (ChartData data, _) => data.x,
//             yValueMapper: (ChartData data, _) => 1,
//             //dataLabelMapper: (ChartData data, _) => data.text,
//             dataLabelSettings: DataLabelSettings(isVisible: true),
//             explode: true,
//             explodeGesture: ActivationMode.singleTap,
//             innerRadius: '70%',
//           ),
//         ],
//                     legend: Legend(
//                         isVisible: true,
//                         overflowMode: LegendItemOverflowMode.wrap,
//                         title: LegendTitle(
//                           text: 'FPA Results',
//                           textStyle: TextStyle(
//                               color: Colors.black,
//                               fontSize: 25,
//                               fontStyle: FontStyle.italic,
//                               fontWeight: FontWeight.w500),
//                         ))))));
//   }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final String y;
  final Color color;
}
