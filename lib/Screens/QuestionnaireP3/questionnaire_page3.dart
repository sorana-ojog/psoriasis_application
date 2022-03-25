// import 'package:psoriasis_application/themes/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:psoriasis_application/Screens/Blank/blank.dart';
import 'package:psoriasis_application/Screens/QuestionnaireP1/questionnaire_page1.dart';
import 'package:psoriasis_application/Screens/QuestionnaireP2/questionnaire_page2.dart';
import 'package:psoriasis_application/Screens/QuestionnaireP4/questionnaire_page4.dart';
import 'package:psoriasis_application/Screens/Welcome/welcome_screen.dart';
import 'package:psoriasis_application/components/button_title.dart';
import 'package:psoriasis_application/components/svg_data1.dart';
import 'package:psoriasis_application/constants.dart';
import 'package:psoriasis_application/components/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';


class  QuestionnaireP3 extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State< QuestionnaireP3> {
  double _currentSliderValue = 0;
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
                  page: NavBar(whichPage: 1, mini: 1),
                  text: 'Part 1A (front)',
                  ),
                  SizedBox(width: size.width * 0.015),
                  ButtonTitle(
                    page: NavBar(whichPage: 2, mini: 1),
                    text: 'Part 1A (back)',
                    ),
                  SizedBox(width: size.width * 0.015),
                  ButtonTitle(
                    page: NavBar(whichPage: 3, mini: 1),
                    text: 'Part 1B',
                    ),
                  SizedBox(width: size.width * 0.015),
                  ButtonTitle(
                    page: NavBar(whichPage: 4, mini: 1),
                    text: 'Part 2',
                    ),
                  SizedBox(width: size.width * 0.015),
                  ButtonTitle(
                    page: NavBar(whichPage: 5, mini: 1),
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
              Text(
                'PART 2',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  ),
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width * 0.85,
                constraints: BoxConstraints(maxWidth: 1000),
                child: Text(
                  'Please slide the dot below to a number that shows how much your psoriasis is affecting you in your day-to-day life today.', 
                  style: TextStyle(
                  fontSize: 17,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width * 0.85,
                constraints: BoxConstraints(maxWidth: 800),
                child: Slider(
                  value: _currentSliderValue,
                  max: 10,
                  divisions: 10,
                  label: _currentSliderValue.round().toString(),
                  activeColor: kPrimaryColor,
                  inactiveColor: kPrimaryLightColor,
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width * 0.85,
                constraints: BoxConstraints(maxWidth: 1000),
                child: Text(
                  'Guide:', 
                  style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width * 0.85,
                constraints: BoxConstraints(maxWidth: 1000),
                child: Text(
                  '0 = my psoriasis is not affecting me at all', 
                  style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width * 0.85,
                constraints: BoxConstraints(maxWidth: 1000),
                child: Text(
                  '5 = my psoriasis is affecting me quite a lot', 
                  style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width * 0.85,
                constraints: BoxConstraints(maxWidth: 1000),
                child: Text(
                  '10 = my psoriasis is affecting me very much (I could not imagine it affecting me more)', 
                  style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.10),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width * 0.90,
                constraints: BoxConstraints(maxWidth: 1000),
                child: 
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: size.width * 0.3,
                    height: size.height * 0.05,
                    constraints: BoxConstraints(maxWidth: 350),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor,
                        ),
                        onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                          return NavBar(whichPage: 3, mini: 1);
                          },
                        ),
                      );
                    },
                        child: Text('Previous'),
                      ),
                    ),
                  ),
                  // SizedBox(width: size.width * 0.3),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: size.width * 0.3,
                    height: size.height * 0.05,
                    constraints: BoxConstraints(maxWidth: 350),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor,
                        ),
                        onPressed: ()async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setDouble('affected_today', _currentSliderValue);
                        final double? counter = prefs.getDouble('affected_today');
                        print("this double");
                        print(counter);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                            return NavBar(whichPage: 5, mini: 1);
                            },
                          ),
                        );
                      },
                        child: Text('Next'),
                      ),
                    ),
                  )
                  ],
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }

}

