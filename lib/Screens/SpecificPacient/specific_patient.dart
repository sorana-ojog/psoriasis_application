import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psoriasis_application/Screens/Home/components/body.dart';
import 'package:psoriasis_application/Screens/PacientGraph/patient_graph.dart';
import 'package:psoriasis_application/Screens/PatientForm/patient_form.dart';
import 'package:psoriasis_application/components/bottom_nav_doc.dart';
import 'package:psoriasis_application/components/rounded_button.dart';
import 'package:psoriasis_application/components/square_button.dart';
import 'package:psoriasis_application/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpecificPacient extends StatefulWidget {
  final uid;
  const SpecificPacient({Key? key, required this.uid}) : super(key: key);
  @override
  _AppState createState() => _AppState();
}
int _selectedIndex = 1;
String patient_name = "";
String title = "";
class _AppState extends State<SpecificPacient> {
  int finish = 0;

  Future<List<String>> data() async{
    print(widget.uid);
    List<String> formsDates = [];
    String date = "";
    CollectionReference ref1 = await FirebaseFirestore.instance.collection('users');
    await ref1
        .where("user_ID", isEqualTo: widget.uid)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        title = result["title"];
        patient_name = result["first_name"];
        patient_name = patient_name + " " + result["last_name"];
      });
    });
    CollectionReference ref2 = await FirebaseFirestore.instance.collection('form');
    await ref2
        .orderBy("date_time", descending: true)
        .where("user_ID", isEqualTo: widget.uid)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        date = result["date_time"];
        // var splitDate = date.split(" ");
        // date = splitDate[0];
        formsDates.add(date);
        print(date);
      });
    });
    finish = 1;
    return formsDates;
  }
  @override
  Widget build(BuildContext context) {
    final Future<List<String>> patient_data = data();
    // final String mine = patient_data as String;
    print("yes here");
    print (patient_data);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // actions: <Widget>[
        // ],
        title: Text('Pacient Forms'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: FutureBuilder<List<String>>(
        future: patient_data, // a previously-obtained Future<List<String>> or null
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
       List<Widget> children;
          if (snapshot.hasData && snapshot.data != [] && finish != 0) {
            children = <Widget>[
              SizedBox(height: size.height * 0.05),
              Container(
              alignment: Alignment.center,
              width: size.width * 0.85,
              constraints: BoxConstraints(maxWidth: 1000),
              child: RichText(
                text:TextSpan(
                  text: "",
                  style: TextStyle( fontSize: 23, fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(text: "Data from ", style: TextStyle( color: Colors.black)),
                    TextSpan(text: "$title $patient_name", style: TextStyle( color: kPrimaryColor))
                  ],
                )
              ),
            ),
              SizedBox(height: size.height * 0.05),
              Container(
              alignment: Alignment.center,
              width: size.width * 0.85,
              constraints: BoxConstraints(maxWidth: 1000),
              child: RichText(
                text:TextSpan(
                  text: "",
                  style: TextStyle( fontSize: 17),
                  children: <TextSpan>[
                    TextSpan(text: "If you go to CHARTS you will see 3 line graphs showing the results for the past forms completed by ", style: TextStyle( color: Colors.black)),
                    TextSpan(text: "$title $patient_name", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                    TextSpan(text: '.',style: TextStyle( color: Colors.black))
                  ],
                )
              ),
            ),
              SizedBox(height: size.height * 0.03),
            RoundedButton(
              text: "Charts", 
              press: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context){
                      return NavBarDoctor(uid: widget.uid, whichPage: 2, mini: 1,);
                    },
                  ),
                );
              }
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              width: size.width * 0.85,
              constraints: BoxConstraints(maxWidth: 1000),
              child: RichText(
                text:TextSpan(
                  text: "",
                  style: TextStyle( fontSize: 17),
                  children: <TextSpan>[
                    TextSpan(text: "Below, you can see all the completed forms sent by ", style: TextStyle( color: Colors.black)),
                    TextSpan(text: "$title $patient_name", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                    TextSpan(text: ', from the most recent one to the least recent one. If you press on any of them, you will be redirected to their answers for the questionnaire.', style: TextStyle( color: Colors.black))
                  ],
                )
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Expanded(
              child: ListView.builder(
                itemCount:  snapshot.data!.length,
                itemBuilder: (BuildContext context,int index){
                  final date = snapshot.data![index];
                  return Container(
                    alignment: Alignment.center,
                    width: size.width * 0.85,
                    constraints: BoxConstraints(maxWidth: 1000),
                    child: SquareButton(
                      text: "Form completed on $date", 
                      press: () async{
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context){
                                return NavBarDoctor(uid: widget.uid, whichPage: 3, mini: 1, date: date);
                              },
                            ),
                          );
                        },
                    )
                  );
                }
              ),
            ),
            SizedBox(height: size.height * 0.02),
            ];
          }else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Loading Data...'),
              )
            ];
          }
       return Container(
        width:double.infinity,
        height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children
          ),
      );}),
    );
  }
}
