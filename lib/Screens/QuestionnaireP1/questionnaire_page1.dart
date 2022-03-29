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


class  QuestionnaireP1 extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State< QuestionnaireP1> {
  int? _counter = 10;
  Future<void> preference() async {
  final prefs = await SharedPreferences.getInstance();
  // ignore: await_only_futures
  final int? counter = await prefs.getInt('psoriasis_today');
  setState(() => _counter = counter);
  //  @override
  // State<QuestionnaireP1> createState() => _ImageClickState();
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
    // final Future<int?> counter = preference();
    // print('alsoooo');
    // print(_counter);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                // for (int i in [1,2,3,4,5])
                ButtonTitle(
                page: QuestionnaireP1(),
                text: 'Part 1A (front)',
                ),
                SizedBox(width: size.width * 0.015),
                ButtonTitle(
                  page: QuestionnaireP1(),
                  text: 'Part 1A (back)',
                  ),
                SizedBox(width: size.width * 0.015),
                ButtonTitle(
                  page: QuestionnaireP2(),
                  text: 'Part 1B',
                  ),
                SizedBox(width: size.width * 0.015),
                ButtonTitle(
                  page: QuestionnaireP3(),
                  text: 'Part 2',
                  ),
                SizedBox(width: size.width * 0.015),
                ButtonTitle(
                  page: QuestionnaireP4(),
                  text: 'Part 3',
                  ),
                SizedBox(width: size.width * 0.015),
              ],
            ),
          ),
        ),
        backgroundColor: kPrimaryColor,
      ),
      // bottomNavigationBar: NavBar(), ///////maybe copy paste bar
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text('HI'),
              // SvgPicture.asset('front_body.svg')
            ]
          ),
        ),
      ),
    );
  }

}

