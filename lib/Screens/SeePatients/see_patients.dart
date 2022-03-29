import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psoriasis_application/Screens/Home/components/body.dart';
import 'package:psoriasis_application/Screens/SpecificPacient/specific_patient.dart';
import 'package:psoriasis_application/components/square_button.dart';
import 'package:psoriasis_application/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class  SeePatients extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State< SeePatients> {
  int count = 0;
  List<String> user_IDs = [];
  Future<List<String>> data() async{
    final User? user = await auth.currentUser;
    final uid = user!.uid;
    List<String> patients = [];
    List<String> birth_dates = [];
    String doctor_id = "";
    String name = "";
    String birth_date = "";
    String patient_ID = "";
    int no_patients = 0;
    print (uid);
    // CollectionReference ref = await FirebaseFirestore.instance.collection('users');
    // await ref
    //     .where("user_ID", isEqualTo: uid)
    //     .get()
    //     .then((value) {
    //   value.docs.forEach((result) {
    //     rez = result["title"];
    //     rez = rez.toLowerCase();
    //     rez = rez + " " + result["first_name"];
    //     rez = rez + " " + result["last_name"];
    //     patients.add(rez);
        
    //   });
    // });
    CollectionReference ref1 = await FirebaseFirestore.instance.collection('doctors');
    await ref1
        .where("user_ID", isEqualTo: uid)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        doctor_id = result["doctor_code"];
      });
    });
    CollectionReference ref2 = await FirebaseFirestore.instance.collection('users');
    await ref2
        // .orderBy("last_name", descending: false)
        .where("signup_code", isEqualTo: doctor_id)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        name = result["last_name"];
        name = name + ", " + result["first_name"];
        print(name);
        patients.add(name);
        birth_date = result["date_of_birth"];
        birth_dates.add(birth_date);
        patient_ID = result["user_ID"];
        user_IDs.add(patient_ID);
      });
    });
    List<String> newList = patients + birth_dates;
    count = (newList.length/2) as int;
    return newList;
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
        title: Text('Your Patients'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
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
            Container(
              alignment: Alignment.center,
              width: size.width * 0.85,
              constraints: BoxConstraints(maxWidth: 1000),
              child: Text(
                'Below, you can see all your patients.',
                style: TextStyle(
                fontSize: 17,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Expanded(
              child: ListView.builder(
                itemCount:  count,
                itemBuilder: (BuildContext context, index){
                  final patient_name = snapshot.data![index];
                  final date = snapshot.data![index+count];
                  return Container(
                    alignment: Alignment.center,
                    width: size.width * 0.85,
                    constraints: BoxConstraints(maxWidth: 900),
                    child: SquareButton(
                      text: "$patient_name, $date", 
                      press: () async{
                        Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context){
                      return SpecificPacient(uid: user_IDs[index]);
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
}
