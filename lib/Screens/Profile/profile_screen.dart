import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psoriasis_application/Screens/Profile/change_GP.dart';
import 'package:psoriasis_application/Screens/Profile/change_dialog.dart';
import 'package:psoriasis_application/Screens/Welcome/welcome_screen.dart';
import 'package:psoriasis_application/components/rounded_button.dart';
import 'package:psoriasis_application/constants.dart';

class Profile extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<Profile> {

  void logout() async {
    await FirebaseAuth.instance.signOut();
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
                  logout();
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
                text: "Change Your GP",
                color: kPrimaryLightColor, 
                press: () async{
                  showDialog(
                  context: context,
                  builder: (context) {
                    return ChangeGPDialog();
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