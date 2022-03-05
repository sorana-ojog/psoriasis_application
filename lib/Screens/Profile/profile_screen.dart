// import 'package:psoriasis_application/themes/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psoriasis_application/Screens/Welcome/welcome_screen.dart';
import 'package:psoriasis_application/constants.dart';

class Profile extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<Profile> {

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
                icon: Icon(Icons.close),
                onPressed: () {
                  // _auth.signOut();
                  // Navigator.pop(context);
                  logout();
                  //   getMessages();
                  //Implement logout functionality
                  Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                  return WelcomeScreen();
                  },
                ),
              );
                }),
          ],
          title: Text('Log Out'),
          backgroundColor: kPrimaryColor,
        ),
      );
    }
  
}