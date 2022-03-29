import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psoriasis_application/Screens/Home/components/body.dart';
import 'package:psoriasis_application/components/rounded_button.dart';
import 'package:psoriasis_application/components/square_button.dart';
import 'package:psoriasis_application/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PacientGraph extends StatefulWidget {
  final uid;
  const PacientGraph({Key? key, required this.uid}) : super(key: key);
  @override
  _AppState createState() => _AppState();
}
int _selectedIndex = 1;
String patient_name = "";
String title = "";
List<String> formsDates = [];
List<double> part1Results = [];
List<double> part2Results = [];
List<double> part3Results = [];

class _AppState extends State<PacientGraph> {
  int count = 0;
  late List<Score> chartData;
  late List<Score> chart2Data;
  late List<Score> chart3Data;
  late ChartSeriesController _chartSeriesController;
  late ChartSeriesController _chartSeriesController2;
  late ChartSeriesController _chartSeriesController3;
   @override
  // void initState() {
  //   chartData = getChartData();
  //   chart2Data = getChart2Data();
  //   chart3Data = getChart3Data();
  //   super.initState();
  // }
  Future<List<String>> data() async{
    print(widget.uid);
    String date = "";
    CollectionReference ref1 = await FirebaseFirestore.instance.collection('users');
    await ref1
        .where("user_ID", isEqualTo: widget.uid)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        title = result["title"];
        patient_name = result["first_name"];
        patient_name = patient_name + " " + result["last_name"];
      });
    });
    CollectionReference ref2 = await FirebaseFirestore.instance.collection('form');
    await ref2
        .orderBy("date_time", descending: false)
        // .limit(7)
        .where("user_ID", isEqualTo: widget.uid)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        var date = result["date_time"];
        var array = date.split("/");
        var time = array[2].split(" ");
        date = array[0] + "/"+ array[1]+ " "+ time[1];
        var part1 = result["part1"];
        var part2 = result["part2"];
        var part3 = result["part3"];
        formsDates.add(date);
        part1Results.add(part1);
        part2Results.add(part2+ 0.0);
        part3Results.add(part3 +0.0);
        print(date);
        print(formsDates);
        print(part1Results);
        print(part2Results);
        print(part3Results);
      });
    });
    chartData = getChartData();
    chart2Data = getChart2Data();
    chart3Data = getChart3Data();
    return formsDates;
  }
 
  @override
  Widget build(BuildContext context) {
    final Future<List<String>> patient_data = data();
    // final String mine = patient_data as String;
    print("yes here");
    print (patient_data);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // actions: <Widget>[
        // ],
        title: Text('Pacient Forms'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      bottomNavigationBar: _showBottomNav(),
      body: FutureBuilder<List<String>>(
        future: patient_data, // a previously-obtained Future<List<String>> or null
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
      
       return Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: size.height * 0.04),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.85,
                constraints: BoxConstraints(maxWidth: 800),
                child: Text(
                  'Below, you can see the progress and changes from $title $patient_name\'s completed questionnaires in 3 different graphs, each representing one of the parts that are scored individually. The X axis shows the date of completion, while the Y axis shows the results that they received for that specific part.', 
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
            ],
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
 Widget _showBottomNav()
  {
    return BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: kPrimaryLightColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Your Patients',
            backgroundColor: kPrimaryLightColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
            backgroundColor: kPrimaryLightColor,
          ),
        ],
      backgroundColor: kPrimaryLightColor,
      currentIndex: _selectedIndex,
      selectedItemColor: kPrimaryColor,
      unselectedItemColor: Colors.white,
      onTap: _onTap,
    );
  }

  void _onTap(int index)
  {
    _selectedIndex = index;
    setState(() {

    });
  }
}
class Score {
  Score(this.time, this.value);
  final String time;
  final double value;
}