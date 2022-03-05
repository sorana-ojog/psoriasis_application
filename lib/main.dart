import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:psoriasis_application/Screens/Home/home_screen.dart';
import 'package:psoriasis_application/Screens/Login/login_screen.dart';
import 'package:psoriasis_application/Screens/Welcome/welcome_screen.dart';
import 'package:psoriasis_application/constants.dart';
import 'package:psoriasis_application/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psoriasis_application/components/bottom_navigation_bar.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
  }
  // This widget is the root of your application.
  class _MyAppState extends State<MyApp> {
    late StreamSubscription<User?> user;
    void initState() {
      super.initState();
      user = FirebaseAuth.instance.authStateChanges().listen((user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in!');
        }
      });
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Psoriasis Questionnaire',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? 'Welcome' : 'Home',
      
      ///key value pair
      routes: {
        // 'Welcome': (context) => WelcomeScreen(),
        /////////////////////////////////////////
        'Welcome': (context) => NavBar(),
        'Home': (context) => NavBar(),
      },
      home: WelcomeScreen(),
    );
  }

}



