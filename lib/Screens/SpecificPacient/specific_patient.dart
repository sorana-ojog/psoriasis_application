import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psoriasis_application/Screens/Home/components/body.dart';
import 'package:psoriasis_application/Screens/PacientGraph/patient_graph.dart';
import 'package:psoriasis_application/Screens/PatientForm/patient_form.dart';
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
  int count = 0;

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
      bottomNavigationBar: _showBottomNav(),
      body: FutureBuilder<List<String>>(
        future: patient_data, // a previously-obtained Future<List<String>> or null
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
      
       return Container(
        width:double.infinity,
        height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.05),
              Text(
                "Data from $title $patient_name",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
              SizedBox(height: size.height * 0.05),
              Container(
              alignment: Alignment.center,
              width: size.width * 0.85,
              constraints: BoxConstraints(maxWidth: 1000),
              child: RichText(
                text:TextSpan(
                  text: "If you go to CHARTS you will see 3 line graphs showing the results for the past forms completed by ",
                  style: TextStyle( fontSize: 17),
                  children: <TextSpan>[
                    TextSpan(text: "$title $patient_name", style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '.')
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
                      return PacientGraph(uid: widget.uid);
                    },
                  ),
                );
              }
            ),
            SizedBox(height: size.height * 0.05),
            Container(
              alignment: Alignment.center,
              width: size.width * 0.85,
              constraints: BoxConstraints(maxWidth: 1000),
              child: Text(
                'Below, you can see all the completed forms sent by $title $patient_name, from the most recent one to the least recent one. If you press on any of them, you will be redirected to their answers for the questionnaire.',
                style: TextStyle(
                fontSize: 17,
                ),
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
                                return PatientForm(uid: widget.uid, date: date);
                              },
                            ),
                          );
                        },
                    )
                  );
                }
              ),
            ),

            ],
          ),
      );}),
    );
  }

   Widget _showBottomNav()
  {
    return BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: kPrimaryLightColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Your Pacients',
            backgroundColor: kPrimaryLightColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
            backgroundColor: kPrimaryLightColor,
          ),
        ],
      backgroundColor: kPrimaryLightColor,
      currentIndex: _selectedIndex,
      selectedItemColor: kPrimaryColor,
      unselectedItemColor: Colors.white,
      onTap: _onTap,
    );
  }

  void _onTap(int index)
  {
    _selectedIndex = index;
    setState(() {

    });
  }
}
