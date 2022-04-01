import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psoriasis_application/Screens/Signup/components/body.dart';
import 'package:psoriasis_application/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class  HomeScreen extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State< HomeScreen> {
  Future<List<String>> data() async{
    final User? user = await auth.currentUser;
    final uid = user!.uid;
    List<String> datas = [];
    String rez = "";
    String signup_code = "";
    int no_forms = 0;
    print (uid);
    CollectionReference ref = await FirebaseFirestore.instance.collection('users');
    await ref
        .where("user_ID", isEqualTo: uid)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        rez = result["title"];
        rez = rez + " " + result["first_name"];
        rez = rez + " " + result["last_name"];
        signup_code = result["signup_code"];
        datas.add(rez);
      });
    });
    CollectionReference ref1 = await FirebaseFirestore.instance.collection('doctors');
    await ref1
        .where("doctor_code", isEqualTo: signup_code)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        rez = result["user_ID"];
      });
    });
    CollectionReference ref2 = await FirebaseFirestore.instance.collection('users');
    await ref2
        .where("user_ID", isEqualTo: rez)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        rez = result["title"];
        rez = rez + " " + result["first_name"];
        rez = rez + " " + result["last_name"];
        datas.add(rez);
      });
    });
    CollectionReference ref3 = await FirebaseFirestore.instance.collection('form');
    await ref3
        .where("user_ID", isEqualTo: uid)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        no_forms += 1;
      });
    });
    datas.add(no_forms.toString());
    return datas;
  }
  @override
  Widget build(BuildContext context) {
    final Future<List<String>> doctor_data = data();
    // final String mine = doctor_data as String;
    print("yes here");
    print (doctor_data);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // actions: <Widget>[
        // ],
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
                  'Welcome to Psoriasis Control! Here, you can manage your psoriasis and keep track of its evolution. You can complete the saSPI form by clicking on NEW ENTRY below. Also, you can see your completed saSPI forms and your charts on PAST ENTRIES.', 
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
              Container(
                alignment: Alignment.center,
                width: size.width * 0.85,
                constraints: BoxConstraints(maxWidth: 900),
                child: 
                  Text(
                    "You are registered with ${snapshot.data![1]}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                  ),
              ),
              
              SizedBox(height: size.height * 0.02),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.85,
                constraints: BoxConstraints(maxWidth: 900),
                child: Text(
                  'You can change that by going to your PROFILE. There, you can also change your password and Log Out.', 
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
                  "Number of forms completed: ${snapshot.data![2]}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.85,
                constraints: BoxConstraints(maxWidth: 900),
                child: Text(
                  'You now have ${snapshot.data![2]} completed saSPI forms. Congratulations! You can see more insight for them by going to PAST ENTRIES.',
                  style: TextStyle(
                  fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.06),
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
