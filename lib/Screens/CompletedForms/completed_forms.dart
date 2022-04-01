import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psoriasis_application/components/bottom_navigation_bar.dart';
import 'package:psoriasis_application/components/square_button.dart';
import 'package:psoriasis_application/constants.dart';

FirebaseAuth auth = FirebaseAuth.instance;
class CompletedForms extends StatefulWidget {
  const CompletedForms({Key? key}) : super(key: key);
  @override
  _AppState createState() => _AppState();
}
var uid;
class _AppState extends State<CompletedForms> {
  int finish = 0;
  String date1 = "";
  List<String> dates = [];

  Future<List<String>> data() async{
    final User? user = await auth.currentUser;
    uid = user!.uid;
    List<String> formsDates = [];
    String date = "";
    CollectionReference ref2 = await FirebaseFirestore.instance.collection('form');
    await ref2
        .orderBy("date_time", descending: true)
        .where("user_ID", isEqualTo: uid)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        date1 = result["date_time"];
        dates.add(date1);
        var splitDate = date1.split(" ");
        var splitDate2 = splitDate[0].split("/");
        date = splitDate2[2]+ "/" + splitDate2[1] +"/"+ splitDate2[0];
        formsDates.add(date);
      });
    });
    finish = 1;
    return formsDates;
  }
  @override
  Widget build(BuildContext context) {
    final Future<List<String>> my_data = data();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Pacient Forms'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: FutureBuilder<List<String>>(
        future: my_data, // a previously-obtained Future<List<String>> or null
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
       List<Widget> children;
          if (snapshot.hasData && snapshot.data != [] && finish != 0) {
            children = <Widget>[
            SizedBox(height: size.height * 0.05),
            Container(
              alignment: Alignment.center,
              width: size.width * 0.85,
              constraints: BoxConstraints(maxWidth: 1000),
              child: Text(
                'Below you can see all your completed forms, from the most recent one to the least recent one.',
                style: TextStyle(
                fontSize: 17,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.05),
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
                                return NavBar(whichPage: 0, mini: 2, whichPage2: 3, date: dates[index]);
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
