import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psoriasis_application/Screens/Home/components/body.dart';
import 'package:psoriasis_application/components/rounded_button.dart';
import 'package:psoriasis_application/components/square_button.dart';
import 'package:psoriasis_application/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graphs extends StatefulWidget {
  const Graphs({Key? key}) : super(key: key);
  @override
  _AppState createState() => _AppState();
}
int _selectedIndex = 1;
String patient_name = "";
String title = "";
List<String> rformsDates = [];
List<double> rpart1Results = [];
List<double> rpart2Results = [];
List<double> rpart3Results = [];
List<String> formsDates = [];
List<double> part1Results = [];
List<double> part2Results = [];
List<double> part3Results = [];

class _AppState extends State<Graphs> {
  int finish = 0;
  late List<Score> chartData = [];
  late List<Score> chart2Data =[];
  late List<Score> chart3Data =[];
  late ChartSeriesController _chartSeriesController;
  late ChartSeriesController _chartSeriesController2;
  late ChartSeriesController _chartSeriesController3;
  var uid;
    // void initState() {
  //   chartData = getChartData();
  //   chart2Data = getChart2Data();
  //   chart3Data = getChart3Data();
  //   super.initState();
  // }
  Future<List<String>> data() async{
    final User? user = await auth.currentUser;
    uid = user!.uid;
    CollectionReference ref2 = await FirebaseFirestore.instance.collection('form');
    await ref2
        .orderBy("date_time", descending: true)
        .limit(8)
        .where("user_ID", isEqualTo: uid)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        var date1 = result["date_time"];
        var splitDate = date1.split(" ");
        var splitDate2 = splitDate[0].split("/");
        var date = splitDate2[2]+ "/" + splitDate2[1];
        // var date = result["date_time"];
        // var array = date.split("/");
        // var time = array[2].split(" ");
        // date = array[0] + "/"+ array[1];
        var part1 = result["part1"];
        var part2 = result["part2"];
        var part3 = result["part3"];
        rformsDates.add(date);
        rpart1Results.add(part1 + 0.0);
        rpart2Results.add(part2+ 0.0);
        rpart3Results.add(part3 +0.0);
        print(date);
        print(rformsDates);
        print(rpart1Results);
        print(rpart2Results);
        print(rpart3Results);
      });
    });
    formsDates = rformsDates.reversed.toList();
    part1Results = rpart1Results.reversed.toList();
    part2Results = rpart2Results.reversed.toList();
    part3Results = rpart3Results.reversed.toList();
    chartData = getChartData();
    chart2Data = getChart2Data();
    chart3Data = getChart3Data();
    finish = 1;
    return formsDates;
  }
  // @override
  // void initState() {
  //   chartData = getChartData();
  //   chart2Data = getChart2Data();
  //   chart3Data = getChart3Data();
  //   // Timer.periodic(const Duration(seconds: 1), updateDataSource);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final Future<List<String>> patient_data = data();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Pacient Forms'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: FutureBuilder<List<String>>(
        future: patient_data, // a previously-obtained Future<List<String>> or null
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
      List<Widget> children;
          if (snapshot.hasData && snapshot.data != [] && finish != 0) {
            children = <Widget>[
              SizedBox(height: size.height * 0.04),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.85,
                constraints: BoxConstraints(maxWidth: 800),
                child: Text(
                  'Below, you can see the progress and changes from your completed questionnaires in 3 different graphs, each representing one of the parts that are scored individually. The X axis shows the date of completion, while the Y axis shows the results you received for that specific part.', 
                  style: TextStyle(
                  fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Text(
                'PART 1 RESULTS',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  ),
              ),
              SizedBox(height: size.height * 0.01),
              Container(
                alignment: Alignment.center,
                constraints: BoxConstraints(maxWidth: 800, maxHeight: 400),
                child:
                SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  series: <LineSeries<Score, String>>[
                  LineSeries<Score, String>(
                    onRendererCreated: (ChartSeriesController controller) {
                      _chartSeriesController = controller;
                    },
                    dataSource: chartData,
                    color: Color.fromARGB(255, 142, 162, 255), 
                    xValueMapper: (Score result, _) => result.time,
                    yValueMapper: (Score result, _) => result.value,
                    )
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Text(
                'PART 2 RESULTS',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  ),
              ),
              SizedBox(height: size.height * 0.01),
              Container(
                alignment: Alignment.center,
                constraints: BoxConstraints(maxWidth: 800, maxHeight: 400),
                child:
                SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  series: <LineSeries<Score, String>>[
                  LineSeries<Score, String>(
                    onRendererCreated: (ChartSeriesController controller) {
                      _chartSeriesController2 = controller;
                    },
                    dataSource: chart2Data,
                    color: Color.fromARGB(255, 56, 153, 97),
                    xValueMapper: (Score result, _) => result.time,
                    yValueMapper: (Score result, _) => result.value,
                    )
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Text(
                'PART 3 RESULTS',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  ),
              ),
              SizedBox(height: size.height * 0.01),
              Container(
                alignment: Alignment.center,
                constraints: BoxConstraints(maxWidth: 800, maxHeight: 400),
                child:
                SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  series: <LineSeries<Score, String>>[
                  LineSeries<Score, String>(
                    onRendererCreated: (ChartSeriesController controller) {
                      _chartSeriesController3 = controller;
                    },
                    dataSource: chart3Data,
                    color: Color.fromARGB(255, 236, 65, 93),
                    xValueMapper: (Score result, _) => result.time,
                    yValueMapper: (Score result, _) => result.value,
                    )
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.03),
            ];
          }else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Loading Data...'),
              )
            ];
          }
       return Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: children
          ),
        ),
      );}),
    );
  }



  List<Score> getChartData() {
    return <Score>[
      for(var i=0; i<part1Results.length; i++)Score(formsDates[i], part1Results[i])
    ];
  }

  List<Score> getChart2Data() {
    return <Score>[
      for(var i=0; i<part2Results.length; i++)Score(formsDates[i], part2Results[i])
    ];
  }

  List<Score> getChart3Data() {
    return <Score>[
      for(var i=0; i<part3Results.length; i++)Score(formsDates[i], part3Results[i])
    ];
  }
}
class Score {
  Score(this.time, this.value);
  final String time;
  final double value;
}