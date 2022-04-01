// import 'package:psoriasis_application/themes/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psoriasis_application/Screens/Profile/change_GP.dart';
import 'package:psoriasis_application/Screens/Profile/change_dialog.dart';
import 'package:psoriasis_application/Screens/ProfileGP/change_code.dart';
import 'package:psoriasis_application/Screens/Welcome/welcome_screen.dart';
import 'package:psoriasis_application/components/rounded_button.dart';
import 'package:psoriasis_application/constants.dart';

class ProfileGP extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<ProfileGP> {

  void logout() async {
    await FirebaseAuth.instance.signOut();
    // Navigator.pushNamed(context, Welcome);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.logout),
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
          title: Text('Profile'),
          centerTitle: true,
          backgroundColor: kPrimaryColor,
        ),
        body:
          Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: size.height * 0.05),
              RoundedButton(
              text: "Log Out", 
              press: () async{
                logout();
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                  return WelcomeScreen();
                  },
                ),
              );
              },
              ),
              RoundedButton(
                text: "Change Your Password",
                color: kPrimaryLightColor, 
                press: () async{
                  showDialog(
                  context: context,
                  builder: (context) {
                    return ChangeDialog();
                      }
                    );    
                },
              ),
              RoundedButton(
                text: "Change Your Code",
                color: kPrimaryLightColor, 
                press: () async{
                  showDialog(
                  context: context,
                  builder: (context) {
                    return ChangeCodeDialog();
                      }
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