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
    print("i am in isdoctor");
      final uid = user.uid;
      String badge ="";
      print (uid);
      CollectionReference ref = await FirebaseFirestore.instance.collection('users');
      await ref
          .where("user_ID", isEqualTo: uid)
          .get()
          .then((value) {
        value.docs.forEach((result) {
          badge = result["signup_code"];
          print(badge);
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


  Widget getHomePage(User? user, bool isDoctor) {
    print(user);
    if(user == null){
      print("i am not in");
      return WelcomeScreen();
    }else{
      if(isDoctor){
        print("i am doctor");
        return NavBarDoctor(whichPage:0, mini: 0);
      }else{
        print("i am not a doctor");
        return NavBar(whichPage:0, mini: 0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(this.widget.user);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Psoriasis Control',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      // initialRoute: this.widget.user == null ? 'Welcome' : 'Home',
      
      // ///key value pair
      // routes: {
      //   'Welcome': (context) => WelcomeScreen(),
      //   /////////////////////////////////////////
      //   // 'Welcome': (context) => NavBar(whichPage: 5, mini: 1),
      //   'Home': (context) => NavBar(whichPage:0, mini: 0)
      // },
      // home: this.widget.user == null ? WelcomeScreen() : NavBar(whichPage:0, mini: 0),
      home: getHomePage(widget.user, widget.isDoctor)
    );
  }

}



