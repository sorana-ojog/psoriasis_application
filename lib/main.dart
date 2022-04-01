import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:psoriasis_application/Screens/Welcome/welcome_screen.dart';
import 'package:psoriasis_application/components/bottom_nav_doc.dart';
import 'package:psoriasis_application/constants.dart';
import 'package:psoriasis_application/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psoriasis_application/components/bottom_navigation_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Stream<User?> userStream = FirebaseAuth.instance.authStateChanges();
  User? user = await userStream.first;

  Future<bool> isDoctor(User? user) async{
    if (user == null){
      return false;
    }
      final uid = user.uid;
      String badge ="";
      CollectionReference ref = await FirebaseFirestore.instance.collection('users');
      await ref
          .where("user_ID", isEqualTo: uid)
          .get()
          .then((value) {
        value.docs.forEach((result) {
          badge = result["signup_code"];
        });
      });
      final regex = RegExp(r'[0-9]{9}');
      //checks if the code used in login is a 9 digits one
      return regex.hasMatch(badge);
    }

  bool isUserDoctor = await isDoctor(user);

  runApp(MyApp(user: user, isDoctor: isUserDoctor));
}

class MyApp extends StatefulWidget {
  
  User? user;
  bool isDoctor;
  MyApp({Key? key, required this.user, required this.isDoctor}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
  }
  // This widget is the root of your application.
  class _MyAppState extends State<MyApp> {
    void initState() {
      super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  void logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Widget getHomePage(User? user, bool isDoctor) {
    if(user == null){
      return WelcomeScreen();
    // }else if ( !user.emailVerified) {
    //   return Container(
    //     alignment: Alignment.center,
    //     padding: EdgeInsets.all(50),
    //     constraints: BoxConstraints(maxWidth: 800),
    //     child: Column(
    //       children: <Widget>[
    //         Text(
    //           'Welcome to Psoriasis Control!',
    //           style: TextStyle(
    //             fontSize: 20,
    //             color: kPrimaryColor
    //           ),
    //         ),
    //         SizedBox(height: 10),
    //         Text(
    //           'Before using this service, you must verify your email. Go to your inbox and click on the link there. Afterwards, come here again and refresh the page.', 
    //           style: TextStyle(
    //             fontSize: 16,
    //             color: kPrimaryColor
    //           ),
    //         ),
    //         SizedBox(height: 20),
    //         RoundedButton(
    //           text: "Log Out", 
    //           press: () async{
    //             logout();
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) {
    //                 return WelcomeScreen();
    //                 },
    //               ),
    //             );
    //           },
    //         ),
    //       ]
    //     ),
    //   );
    }else{
      if(isDoctor){
        return NavBarDoctor(whichPage:0, mini: 0);
      }else{
        return NavBar(whichPage:0, mini: 0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Psoriasis Control',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: getHomePage(widget.user, widget.isDoctor)
    );
  }

}



