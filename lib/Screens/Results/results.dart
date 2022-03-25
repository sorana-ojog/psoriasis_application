// import 'package:psoriasis_application/themes/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:psoriasis_application/Screens/Blank/blank.dart';
import 'package:psoriasis_application/Screens/QuestionnaireP2/questionnaire_page2.dart';
import 'package:psoriasis_application/Screens/QuestionnaireP3/questionnaire_page3.dart';
import 'package:psoriasis_application/Screens/QuestionnaireP4/questionnaire_page4.dart';
import 'package:psoriasis_application/Screens/Welcome/welcome_screen.dart';
import 'package:psoriasis_application/components/button_title.dart';
import 'package:psoriasis_application/components/svg_data1.dart';
import 'package:psoriasis_application/constants.dart';
import 'package:psoriasis_application/components/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';


class  Results extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<Results> {
  int? _part1 = 10;
  double? _part2 = 10;
  int? _part3 = 10;
  Future<void> preference() async {
  final prefs = await SharedPreferences.getInstance();
  // ignore: await_only_futures
  final int? part1 = await prefs.getInt('part1Score');
  final double? part2 = await prefs.getDouble('affected_today');
  final int? part3 = await prefs.getInt('history');
  setState(() => _part1 = part1);
  setState(() => _part2 = part2);
  setState(() => _part3 = part3);
  }

  

  @override
  void initState(){
    super.initState();
    preference();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    final Future<void> counter = preference();

    return Scaffold(
      backgroundColor: kPrimaryColor,
      // bottomNavigationBar: NavBar(), ///////maybe copy paste bar
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: size.width * 0.85,
                constraints: BoxConstraints(maxWidth: 1000),
                child: Text(
                  'Congratulations on completing the form!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 30,
                  color: kPrimaryLightColor,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.65,
                constraints: BoxConstraints(maxWidth: 1000),
                child: Text(
                  'These are your results: ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 22,
                  color: Color.fromARGB(255, 255, 137, 58),
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.65,
                constraints: BoxConstraints(maxWidth: 1000),
                child: Text(
                  'Part 1:  '+ _part1.toString() + ' points',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 22,
                  color: Color.fromARGB(255, 255, 163, 58),
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.65,
                constraints: BoxConstraints(maxWidth: 1000),
                child: Text(
                  'Part 2:  '+ _part2.toString() + ' points',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 22,
                  color: Color.fromARGB(255, 255, 209, 58),
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.65,
                constraints: BoxConstraints(maxWidth: 1000),
                child: Text(
                  'Part 3:  '+ _part3.toString() + ' points',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 22,
                  color: Color.fromARGB(255, 255, 225, 58),
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.18),
              Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: size.width * 0.3,
                    height: size.height * 0.05,
                    constraints: BoxConstraints(maxWidth: 350),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: kPrimaryLightColor,
                          onPrimary: kPrimaryColor,
                        ),
                        onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                          return NavBar(whichPage: 0, mini: 0);
                          },
                        ),
                      );
                    },
                        child: Text('Finish'),
                      ),
                    ),
                  ),
            ]
          ),
        ),
      ),
    );
  }
}

