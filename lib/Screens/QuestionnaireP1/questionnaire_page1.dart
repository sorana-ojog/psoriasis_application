// import 'package:psoriasis_application/themes/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psoriasis_application/Screens/Welcome/welcome_screen.dart';
import 'package:psoriasis_application/constants.dart';
import 'package:psoriasis_application/components/bottom_navigation_bar.dart';


class  QuestionnaireP1 extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State< QuestionnaireP1> {

  void logout() async {
    await FirebaseAuth.instance.signOut();
    // Navigator.pushNamed(context, Welcome);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.deblur_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                    return WelcomeScreen();
                    },
                  ),
                );
              }
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                    return WelcomeScreen();
                    },
                  ),
                );
              }
            ),
          ],
          // title: Text('Log Out'),
          backgroundColor: kPrimaryColor,
        ),
        // bottomNavigationBar: NavBar(), ///////maybe copy paste bar
      );
      } 
  
}