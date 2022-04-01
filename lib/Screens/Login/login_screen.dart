import 'package:flutter/material.dart';
import 'package:psoriasis_application/Screens/Login/components/body.dart';

//used example from https://www.youtube.com/watch?v=ExKYjqgswJg
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Body(),
    );
  }
}
