import 'package:flutter/material.dart';
import 'package:psoriasis_application/Screens/Home/components/body.dart';
import 'package:psoriasis_application/components/bottom_nav2.dart';
import 'package:psoriasis_application/components/rounded_button.dart';
import 'package:psoriasis_application/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';
import 'dart:math' as math;


class Graphs extends StatefulWidget {
  final List<String> dates;
  final List<double> part1;
  final List<double> part2;
  final List<double> part3;
  const Graphs({
    Key? key, 
    required this.dates, 
    required this.part1, 
    required this.part2, 
    required this.part3
    }) : super(key: key);

  @override
  _AppState createState() => _AppState();
}
int _selectedIndex = 2;
class _AppState extends State<Graphs> {
  late List<Score> chartData;
  late List<Score> chart2Data;
  late List<Score> chart3Data;
  late ChartSeriesController _chartSeriesController;
  late ChartSeriesController _chartSeriesController2;
  late ChartSeriesController _chartSeriesController3;

  @override
  void initState() {
    chartData = getChartData();
    chart2Data = getChart2Data();
    chart3Data = getChart3Data();
    // Timer.periodic(const Duration(seconds: 1), updateDataSource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Scaffold(
      appBar: AppBar(
        // actions: <Widget>[
        // ],
        title: Text('Graphs'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      // bottomNavigationBar: NavBar2(),
      bottomNavigationBar: _showBottomNav(),
      body:Container(
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
            ],
          ),
        ),
      ),
    );
  }

  List<Score> getChartData() {
    return <Score>[
      for(var i=0; i<widget.part1.length; i++)Score(widget.dates[i], widget.part1[i])
    ];
  }

  List<Score> getChart2Data() {
    return <Score>[
      for(var i=0; i<widget.part2.length; i++)Score(widget.dates[i], widget.part2[i])
    ];
  }

  List<Score> getChart3Data() {
    return <Score>[
      for(var i=0; i<widget.part3.length; i++)Score(widget.dates[i], widget.part3[i])
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
            icon: Icon(Icons.border_color),
            label: 'New Entry',
            backgroundColor: kPrimaryLightColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Past Entries',
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