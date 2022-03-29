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
              SizedBox(height: size.height * 0.2),
              RoundedButton(
              text: "Graphs", 
              press: () async{
                final User? user = await auth.currentUser;
              final uid = user!.uid;
              List<String> formDates = [];
              List<double> part1Results = [];
              List<double> part2Results = [];
              List<double> part3Results = [];
              print (uid);
              CollectionReference ref = await FirebaseFirestore.instance.collection('form');
              await ref
                  .orderBy("date_time", descending: false)
                  // .limit(7)
                  .where("user_ID", isEqualTo: uid)
                  .get()
                  .then((value) {
                value.docs.forEach((result) {
                  var date = result["date_time"];
                  var array = date.split("/");
                  var time = array[2].split(" ");
                  date = array[0] + "/"+ array[1]+ " "+ time[1];
                  var part1 = result["part1"];
                  var part2 = result["part2"];
                  var part3 = result["part3"];
                  formDates.add(date);
                  double part1s= part1+ 0.0;
                  part1Results.add(part1s);
                  part2Results.add(part2+ 0.0);
                  part3Results.add(part3 +0.0);
                  print(date);
                  print(formDates);
                  print(part1Results);
                  print(part2Results);
                  print(part3Results);
                });
              });
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context){
                      print("here");
                      print(formDates);
                      return Graphs(dates: formDates, part1: part1Results, part2: part2Results, part3: part3Results);
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "See Completed Forms",
              color: kPrimaryLightColor, 
              press: () async{
              final User? user = await auth.currentUser;
              final uid = user!.uid;
              List<String> formDates = [];
              print (uid);
              CollectionReference ref = await FirebaseFirestore.instance.collection('form');
              await ref
                  .orderBy("date_time", descending: true)
                  .where("user_ID", isEqualTo: uid)
                  .get()
                  .then((value) {
                value.docs.forEach((result) {
                  var rez = result["date_time"];
                  formDates.add(rez);
                  print(rez);
                  print(formDates);
                });
              });
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context){
                      print("here");
                      print(formDates);
                      return CompletedForms(formsDate: formDates, uid: uid);
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
