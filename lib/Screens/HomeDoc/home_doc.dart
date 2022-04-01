import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psoriasis_application/constants.dart';

FirebaseAuth auth = FirebaseAuth.instance;
class  HomeScreenDoc extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State< HomeScreenDoc> {
  Future<List<String>> data() async{
    final User? user = await auth.currentUser;
    final uid = user!.uid;
    List<String> datas = [];
    String rez = "";
    int no_patients = 0;
    CollectionReference ref = await FirebaseFirestore.instance.collection('users');
    await ref
        .where("user_ID", isEqualTo: uid)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        rez = result["title"];
        rez = rez + " " + result["first_name"];
        rez = rez + " " + result["last_name"];
        datas.add(rez);
      });
    });
    CollectionReference ref1 = await FirebaseFirestore.instance.collection('doctors');
    await ref1
        .where("user_ID", isEqualTo: uid)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        rez = result["doctor_code"];
        datas.add(rez);
      });
    });
    CollectionReference ref2 = await FirebaseFirestore.instance.collection('users');
    await ref2
        .where("signup_code", isEqualTo: rez)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        no_patients += 1;
      });
    });
    datas.add(no_patients.toString());
    return datas;
  }
  @override
  Widget build(BuildContext context) {
    final Future<List<String>> doctor_data = data();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: FutureBuilder<List<String>>(
        future: doctor_data, // a previously-obtained Future<List<String>> or null
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
      List<Widget> children;
          if (snapshot.hasData && snapshot.data != [] && snapshot.data!.length == 3) {
            children = <Widget>[
              SizedBox(height: size.height * 0.05),
              Text(
                "Hi, ${snapshot.data![0]}!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
              SizedBox(height: size.height * 0.04),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.85,
                constraints: BoxConstraints(maxWidth: 900),
                child: Text(
                  'Welcome to Psoriasis Control! Here, you can manage your patients\' psoriasis and keep track of their evolution by seeing their completed saSPI forms and their specific charts.', 
                  style: TextStyle(
                  fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                constraints: BoxConstraints(maxWidth: 900),
                child:Divider(
                  color: kPrimaryLightColor2,
                  thickness: 3
                ),
              ),
              SizedBox(height: size.height * 0.02),
              RichText(
                text:TextSpan(
                  text: "",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                  children: <TextSpan>[
                    TextSpan(text: "Your code: ", style: TextStyle(color: Colors.black)),
                    TextSpan(text: "${snapshot.data![1]}", style: TextStyle(color: kPrimaryColor)),
                  ],
                )
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.85,
                constraints: BoxConstraints(maxWidth: 900),
                child: Text(
                  'Your patients can send their data to you by using the code above on sign up. By doing so, whenever they complete a saSPI form, the results will be send automatically to you from wherever they are.',
                  style: TextStyle(
                  fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                constraints: BoxConstraints(maxWidth: 900),
                child:Divider(
                  color: kPrimaryLightColor2,
                  thickness: 3
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.85,
                child: Text(
                  "Number of patients: ${snapshot.data![2]}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.85,
                constraints: BoxConstraints(maxWidth: 900),
                child: Text(
                  'You now have ${snapshot.data![2]} patients registered to you on Psoriasis Control. You can see their data by pressing on the "Your Patients" button below.',
                  style: TextStyle(
                  fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.06),
            ];
          } else if (snapshot.hasError) {
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children
          ),
      )
      );}),
    );
  }
}
