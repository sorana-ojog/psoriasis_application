import 'package:flutter/material.dart';
import 'package:psoriasis_application/Screens/CompletedForms/completed_forms.dart';
import 'package:psoriasis_application/Screens/Graphs/graphs.dart';
import 'package:psoriasis_application/Screens/Home/components/body.dart';
import 'package:psoriasis_application/components/bottom_nav2.dart';
import 'package:psoriasis_application/components/rounded_button.dart';
import 'package:psoriasis_application/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class  YourPatients extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<YourPatients> {

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
        title: Text('Your Patients'),
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
                'Your Patients',
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
                  'Search for a patient by name or see all of your patients.', 
                  style: TextStyle(
                  fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.2),
            //   RoundedButton(
            //   text: "Graphs", 
            //   press: () async{
            //     final User? user = await auth.currentUser;
            //   final uid = user!.uid;
            //   List<String> formDates = [];
            //   List<double> part1Results = [];
            //   List<double> part2Results = [];
            //   List<double> part3Results = [];
            //   print (uid);
            //   CollectionReference ref = await FirebaseFirestore.instance.collection('form');
            //   await ref
            //       .orderBy("date_time", descending: false)
            //       //limit
            //       .where("user_ID", isEqualTo: uid)
            //       .get()
            //       .then((value) {
            //     value.docs.forEach((result) {
            //       var date = result["date_time"];
            //       var array = date.split("/");
            //       var time = array[2].split(" ");
            //       date = array[0] + "/"+ array[1]+ " "+ time[1];
            //       var part1 = result["part1"];
            //       var part2 = result["part2"];
            //       var part3 = result["part3"];
            //       formDates.add(date);
            //       part1Results.add(part1);
            //       part2Results.add(part2+ 0.0);
            //       part3Results.add(part3 +0.0);
            //       print(date);
            //       print(formDates);
            //       print(part1Results);
            //       print(part2Results);
            //       print(part3Results);
            //     });
            //   });
            //     Navigator.push(
            //       context, 
            //       MaterialPageRoute(
            //         builder: (context){
            //           print("here");
            //           print(formDates);
            //           return Graphs(dates: formDates, part1: part1Results, part2: part2Results, part3: part3Results);
            //         },
            //       ),
            //     );
            //   },
            // ),
            RoundedButton(
              text: "See All Patients",
              color: kPrimaryLightColor, 
              press: () async{
              final User? user = await auth.currentUser;
              final uid = user!.uid;
              List<String> patientsID = [];
              print (uid);
              CollectionReference ref = await FirebaseFirestore.instance.collection('patients');
              await ref
                  .where("doctor", isEqualTo: "gvThnYwssh") //specific code random generated for specific doctor
                  .get()
                  .then((value) {
                value.docs.forEach((result) {
                  var rez = result["patient"];
                  patientsID.add(rez);
                  print(rez);
                });
              });
              CollectionReference col = await FirebaseFirestore.instance.collection('users');
              await col
                  .where("code", isEqualTo: "gvThnYwssh")
                  .get()
                  .then((value) {
                value.docs.forEach((result) {
                  var title = result["title"];
                  var first_name = result["first_name"];
                  var last_name = result["last_name"];
                  var date_of_birth = result["date_of_birth"];
                  String find = title + " "+ first_name + " "+ last_name+ " born on " +date_of_birth;
                  // formDates.add(rez);
                  // print(rez);
                  // print(formDates);
                });
              });
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context){
                      print("here");
                      print(patientsID);
                      return CompletedForms(formsDate: patientsID, uid: uid);
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
