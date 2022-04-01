import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psoriasis_application/components/bottom_nav_doc.dart';
import 'package:psoriasis_application/components/square_button.dart';
import 'package:psoriasis_application/components/text_field_container.dart';
import 'package:psoriasis_application/constants.dart';

FirebaseAuth auth = FirebaseAuth.instance;
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
        patients.add(name);
        birth_date = result["date_of_birth"];
        birth_dates.add(birth_date);
        patient_ID = result["user_ID"];
        user_IDs.add(patient_ID);
      });
    });
    List<String> newList = patients + birth_dates;
    double length = newList.length/2;
    count = length.floor();
    return newList;
  }
  @override
  Widget build(BuildContext context) {
    String input = "";
    final Future<List<String>> patient_data = data();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Patients'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: FutureBuilder<List<String>>(
        future: patient_data, // a previously-obtained Future<List<String>> or null
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
      List<Widget> children;
      if (snapshot.hasData && snapshot.data != [] && count != 0) {
            children = <Widget>[
              SizedBox(height: size.height * 0.05),
              TextFieldContainer(
              child: TextField(
                onChanged: (value) => input = value,
                decoration: InputDecoration(
                  hintText: "Search for patients by name",
                  suffixIcon: IconButton(
                      icon: Icon(Icons.search, color:  kPrimaryColor ),
                      onPressed: () async{
                        for(var i in snapshot.data!){
                          if (i.contains(input)){

                          }
                        }
                        snapshot.data!= [];
                      }),
                  border: InputBorder.none,
                ),
              ),
            ),
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
                      return NavBarDoctor(uid: user_IDs[index], whichPage: 1, mini: 1,);
                    },
                  ),
                );
                      },
                    )
                  );
                }
              ),
            ),
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
       return 
       Container(
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
