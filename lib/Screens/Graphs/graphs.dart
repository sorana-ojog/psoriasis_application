import 'package:flutter/material.dart';
import 'package:psoriasis_application/Screens/Home/components/body.dart';
import 'package:psoriasis_application/components/rounded_button.dart';
import 'package:psoriasis_application/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';

class  Graphs extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<Graphs> {
  final List<Feature> part1 = [
    Feature(
      title: "Part 1",
      color: Colors.blue,
      data: [0.5, 0.6, 1],
    )];
    final List<Feature> part2 = [
    Feature(
      title: "Part 2",
      color: Colors.red,
      data: [0.2, 0.6, 0.8],
    )];
    final List<Feature> part3 = [
    Feature(
      title: "Part 3",
      color: Colors.green,
      data: [0.3, 0.3, 0.5],
    )];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    // final Future<void> counter = preference();

    return Scaffold(
      appBar: AppBar(
        // actions: <Widget>[
        // ],
        title: Text('Graphs'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: size.height * 0.05),
              Text(
                'YOUR GRAPH OVERVIEW',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  ),
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.85,
                constraints: BoxConstraints(maxWidth: 1000),
                child: Text(
                  'Part 1', 
                  style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              LineGraph(
            features: part1,
            size: Size(420, 450),
            labelX: ['20/03/2022', '21/03/2022', '22/03/2022'],
            labelY: ['Score 5', 'Score 6', 'Score 10'],
            
            graphColor: Colors.black87,
          ),
          SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.85,
                constraints: BoxConstraints(maxWidth: 1000),
                child: Text(
                  'Part 2', 
                  style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          LineGraph(
            features: part2,
            size: Size(420, 450),
            labelX: ['20/03/2022', '21/03/2022', '22/03/2022'],
            labelY: ['Score 2', 'Score 6', 'Score 8'],
            // showDescription: true,
            graphColor: Colors.black87,
          ),
          SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.85,
                constraints: BoxConstraints(maxWidth: 1000),
                child: Text(
                  'Part 3', 
                  style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          LineGraph(
            features: part3,
            size: Size(420, 450),
            labelX: ['20/03/2022', '21/03/2022', '22/03/2022'],
            labelY: ['Score 3', 'Score 3', 'Score 5'],
            graphColor: Colors.black87,
          ),
          SizedBox(
            height: 50,
          )
            ]
          ),
        ),
      ),
    );
  }
}
