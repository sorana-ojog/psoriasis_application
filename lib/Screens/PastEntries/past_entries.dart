import 'package:flutter/material.dart';
import 'package:psoriasis_application/Screens/CompletedForms/completed_forms.dart';
import 'package:psoriasis_application/Screens/Graphs/graphs.dart';
import 'package:psoriasis_application/Screens/Home/components/body.dart';
import 'package:psoriasis_application/components/bottom_nav2.dart';
import 'package:psoriasis_application/components/bottom_navigation_bar.dart';
import 'package:psoriasis_application/components/rounded_button.dart';
import 'package:psoriasis_application/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class  PastEntries extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<PastEntries> {

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
        title: Text('Past Entries'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      // bottomNavigationBar: NavBar2(),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: size.height * 0.05),
              Text(
                'PAST ENTRIES',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  ),
              ),
              SizedBox(height: size.height * 0.1),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.85,
                constraints: BoxConstraints(maxWidth: 1000),
                child: Text(
                  'Here, you can check your progress by looking at your GRAPHS that show an overview of your past forms or you can see your COMPLETED FORMS.', 
                  style: TextStyle(
                  fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.1),
              RoundedButton(
              text: "Graphs", 
              press: () async{
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context){
                      return NavBar(whichPage: 0, mini: 2, whichPage2: 2,);
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "See Completed Forms",
              color: kPrimaryLightColor, 
              press: () async{
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context){
                      return NavBar(whichPage: 0, mini: 2, whichPage2: 1,);
                    },
                  ),
                );
              },
            ),
            ]
          ),
        ),
      ),
    );
  }
}
