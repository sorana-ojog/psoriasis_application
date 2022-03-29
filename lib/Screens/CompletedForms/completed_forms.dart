// import 'package:psoriasis_application/themes/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psoriasis_application/Screens/SingleForm/single_form.dart';
import 'package:psoriasis_application/components/button_title.dart';
import 'package:psoriasis_application/components/rounded_button.dart';
import 'package:psoriasis_application/components/square_button.dart';
import 'package:psoriasis_application/constants.dart';
import 'package:psoriasis_application/components/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';


class  CompletedForms extends StatefulWidget {
  final List<String> formsDate;
  final String uid;
  const CompletedForms({
    Key? key, 
    required this.formsDate, 
    required this.uid, 
  }):super(key: key);
  @override
  _AppState createState()
  {
    return _AppState(formsDate: formsDate, uid:uid);
  }
}

class _AppState extends State<CompletedForms> {
  List<String> formsDate;
  String uid;
  _AppState({
    Key? key, 
    required this.formsDate,
    required this.uid
  });

  double _currentSliderValue = 0;
  @override
  Widget build(BuildContext context) {
     int _selectedIndex = 2;
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Scaffold(
      appBar: AppBar(
        // actions: <Widget>[
        // ],
        title: Text('Completed Forms'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
        bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: kPrimaryLightColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.border_color),
            label: 'New Entry',
            backgroundColor: kPrimaryLightColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Past Entries',
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
      onTap:(int index)
  {
    _selectedIndex = index;
    setState(() {

    });
  }
    ),
      body: 
      Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
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
                itemCount:  widget.formsDate.length,
                itemBuilder: (BuildContext context,int index){
                  final date = widget.formsDate[index];
                  return Container(
                    alignment: Alignment.center,
                    width: size.width * 0.85,
                    constraints: BoxConstraints(maxWidth: 1000),
                    child: SquareButton(
                      text: "Form completed on $date", 
                      press: () async{
                        List<String> formDates = [];
                        var part1;
                        var part1b;
                        var part2;
                        var part3;
                        var p3_10years;
                        var p3_20years;
                        var p3_bright_red;
                        var p3_rheumatologist;
                        var p3_ultraviolet;
                        var p3_number_of_tablets;
                        var p3_which_tablets;
                        var date_time;
                        var scalp1;
                        var face2;
                        var arms3;
                        var hands4;
                        var chest5;
                        var back6;
                        var genitals7;
                        var thighs8;
                        var legs9;
                        var feets10;
                        print (uid);
                        CollectionReference ref = await FirebaseFirestore.instance.collection('form');
                        await ref
                            .where("user_ID", isEqualTo: uid)
                            .where("date_time", isEqualTo: date)
                            .get()
                            .then((value) {
                          value.docs.forEach((result) {
                            part1 = result["part1"];
                            part1b = result["part1b"];
                            part2 = result["part2"];
                            part3 = result["part3"];
                            p3_10years = result["p3_10years"];
                            p3_20years = result["p3_20years"];
                            p3_bright_red = result["p3_bright_red"];
                            p3_rheumatologist = result["p3_rheumatologist"];
                            p3_ultraviolet = result["p3_ultraviolet"];
                            p3_number_of_tablets = result["p3_number_of_tablets"];
                            p3_which_tablets = result["p3_which_tablets"];
                            date_time = result["date_time"];
                            scalp1 = result["scalp1"];
                            face2 = result["face2"];
                            arms3 = result["arms3"];
                            hands4 = result["hands4"];
                            chest5 = result["chest5"];
                            back6 = result["back6"];
                            genitals7 = result["genitals7"];
                            thighs8 = result["thighs8"];
                            legs9 = result["legs9"];
                            feets10 = result["feets10"];
                          });
                        });
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context){
                                print("here");
                                print(formDates);
                                return SingleForm(
                                  part1: part1,
                                  part2: part2, 
                                  part3: part3, 
                                  part1b: part1b,
                                  p3_10years: p3_10years, 
                                  p3_20years: p3_20years, 
                                  p3_bright_red: p3_bright_red, 
                                  p3_rheumatologist: p3_rheumatologist, 
                                  p3_ultraviolet: p3_ultraviolet, 
                                  p3_number_of_tablets: p3_number_of_tablets, 
                                  p3_which_tablets: p3_which_tablets, 
                                  date_time: date_time, 
                                  scalp1: scalp1, 
                                  face2: face2, 
                                  arms3: arms3, 
                                  hands4: hands4, 
                                  chest5: chest5, 
                                  back6: back6, 
                                  genitals7: genitals7, 
                                  thighs8: thighs8, 
                                  legs9: legs9, 
                                  feets10: feets10
                                  );
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
      ),
    );
  }

}

