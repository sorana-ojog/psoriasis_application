// import 'package:psoriasis_application/themes/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psoriasis_application/components/button_title.dart';
import 'package:psoriasis_application/components/rounded_button.dart';
import 'package:psoriasis_application/components/square_button.dart';
import 'package:psoriasis_application/constants.dart';
import 'package:psoriasis_application/components/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';


class  SingleForm extends StatefulWidget {
  final double part1;
  final int part1b;
  final int part2;
  final int part3;
  final bool p3_10years;
  final bool p3_20years;
  final bool p3_bright_red;
  final bool p3_rheumatologist;
  final bool p3_ultraviolet;
  final String p3_number_of_tablets;
  final List p3_which_tablets;
  final String date_time;
  final double scalp1;
  final double face2;
  final double arms3;
  final double hands4;
  final double chest5;
  final double back6;
  final double genitals7;
  final double thighs8;
  final double legs9;
  final double feets10;

  const SingleForm({
    Key? key, 
    required this.part1, 
    required this.part1b, 
    required this.part2, 
    required this.part3, 
    required this.p3_10years, 
    required this.p3_20years, 
    required this.p3_bright_red, 
    required this.p3_rheumatologist, 
    required this.p3_ultraviolet, 
    required this.p3_number_of_tablets, 
    required this.p3_which_tablets, 
    required this.date_time, 
    required this.scalp1, 
    required this.face2, 
    required this.arms3, 
    required this.hands4, 
    required this.chest5, 
    required this.back6, 
    required this.genitals7, 
    required this.thighs8, 
    required this.legs9, 
    required this.feets10, 
  }):super(key: key);
  @override
  _AppState createState()
  {
    return _AppState(
      part1: part1,
      part1b: part1b,
      part2: part2,
      part3: part3,
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
      feets10: feets10,
    );
  }
}

class _AppState extends State<SingleForm> {
  double part1;
  int part1b;
  int part2;
  int part3;
  bool p3_10years;
  bool p3_20years;
  bool p3_bright_red;
  bool p3_rheumatologist;
  bool p3_ultraviolet;
  String p3_number_of_tablets;
  List p3_which_tablets;
  String date_time;
  double scalp1;
  double face2;
  double arms3;
  double hands4;
  double chest5;
  double back6;
  double genitals7;
  double thighs8;
  double legs9;
  double feets10;
  _AppState({
    Key? key, 
    required this.part1, 
    required this.part1b, 
    required this.part2, 
    required this.part3, 
    required this.p3_10years, 
    required this.p3_20years, 
    required this.p3_bright_red, 
    required this.p3_rheumatologist, 
    required this.p3_ultraviolet, 
    required this.p3_number_of_tablets, 
    required this.p3_which_tablets, 
    required this.date_time, 
    required this.scalp1, 
    required this.face2, 
    required this.arms3, 
    required this.hands4, 
    required this.chest5, 
    required this.back6, 
    required this.genitals7, 
    required this.thighs8, 
    required this.legs9, 
    required this.feets10, 
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
        title: Text('Form from $date_time'),
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
        child: SingleChildScrollView(
          child:Column(
          children: <Widget>[
              SizedBox(height: size.height * 0.04),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.85,
                constraints: BoxConstraints(maxWidth: 1000),
                child: Text(
                  'This is the form you completed at $date_time.',
                  style: TextStyle(
                  fontSize: 17,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.85,
                constraints: BoxConstraints(maxWidth: 1000),
                child: Text(
                  'Part 1',
                  style: TextStyle(
                  fontSize: 20,
                  ),
                ),
              ),
              Container(  
                margin: EdgeInsets.all(10),  
                constraints:BoxConstraints(maxWidth: 1000),
                child: Table(  
                  defaultColumnWidth: FlexColumnWidth(size.width * 0.75),  
                  border: TableBorder.all(  
                    color: Colors.black,  
                    style: BorderStyle.solid,  
                    width: 2),  
                  children: [  
                    TableRow( children: [  
                      Column(children:[Text('Questionnaire Question', style: TextStyle(fontSize: 20.0))]),  
                      Column(children:[Text('You completed ', style: TextStyle(fontSize: 20.0))]),
                    ]), 
                    TableRow( children: [  
                      Column(children:[Text('Results', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(part1.toString(), style: TextStyle(fontSize: 17.0))]),  
                    ]),
                    TableRow( children: [  
                      Column(children:[Text('Overall state of my psoriasis', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(part1b.toString(), style: TextStyle(fontSize: 17.0))]),  
                    ]),    
                    TableRow( children: [  
                      Column(children:[Text('Scalp and hairline' , style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(scalp1.toString(), style: TextStyle(fontSize: 17.0))]),   
                    ]),  
                    TableRow( children: [  
                      Column(children:[Text('Face, neck and ears', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(face2.toString(), style: TextStyle(fontSize: 17.0))]),  
                    ]),  
                    TableRow( children: [  
                      Column(children:[Text('Right arm and armpit', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(arms3.toString(), style: TextStyle(fontSize: 17.0))]),  
                    ]),  
                    TableRow( children: [  
                      Column(children:[Text('Left hand, fingers and fingernails', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(hands4.toString(), style: TextStyle(fontSize: 17.0))]),  
                    ]), 
                    TableRow( children: [  
                      Column(children:[Text('Chest and abdomen', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(chest5.toString(), style: TextStyle(fontSize: 17.0))]),  
                    ]), 
                    TableRow( children: [  
                      Column(children:[Text('Back', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(back6.toString(), style: TextStyle(fontSize: 17.0))]),  
                    ]), 
                    TableRow( children: [  
                      Column(children:[Text('Genital area', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(genitals7.toString(), style: TextStyle(fontSize: 17.0))]),  
                    ]), 
                    TableRow( children: [  
                      Column(children:[Text('Thighs', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(thighs8.toString(), style: TextStyle(fontSize: 17.0))]),  
                    ]), 
                    TableRow( children: [  
                      Column(children:[Text('Knees and lower legs', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(legs9.toString(), style: TextStyle(fontSize: 17.0))]),  
                    ]), 
                    TableRow( children: [  
                      Column(children:[Text('Feet, toes and toenails', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(feets10.toString(), style: TextStyle(fontSize: 17.0))]),  
                    ]),
                  ],  
                ),  
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.85,
                constraints: BoxConstraints(maxWidth: 1000),
                child: Text(
                  'Part 2',
                  style: TextStyle(
                  fontSize: 20,
                    ),
                  ),
                ),
              Container(  
                margin: EdgeInsets.all(10),  
                constraints:BoxConstraints(maxWidth: 1000),
                child: Table(  
                  defaultColumnWidth: FlexColumnWidth(size.width * 0.75),  
                  border: TableBorder.all(  
                    color: Colors.black,  
                    style: BorderStyle.solid,  
                    width: 2),  
                  children: [  
                    TableRow( children: [  
                      Column(children:[Text('Questionnaire Question', style: TextStyle(fontSize: 20.0))]),  
                      Column(children:[Text('Completed ', style: TextStyle(fontSize: 20.0))]),
                    ]),  
                    TableRow( children: [  
                      Column(children:[Text('Results', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(part2.toString(), style: TextStyle(fontSize: 17.0))]),   
                    ]),
                    TableRow( children: [  
                      Column(children:[Text('How much my psoriasis was affecting me', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(part2.toString(), style: TextStyle(fontSize: 17.0))]),   
                    ]),
                  ],  
                ),  
              ),    
              SizedBox(height: size.height * 0.02),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.85,
                constraints: BoxConstraints(maxWidth: 1000),
                child: Text(
                  'Part 3',
                  style: TextStyle(
                  fontSize: 20,
                  ),
                ),
              ),
              Container(  
                margin: EdgeInsets.all(10),  
                constraints:BoxConstraints(maxWidth: 1000),
                child: Table(  
                  defaultColumnWidth: FlexColumnWidth(size.width * 0.75),  
                  border: TableBorder.all(  
                    color: Colors.black,  
                    style: BorderStyle.solid,  
                    width: 2),  
                  children: [  
                    TableRow( children: [  
                      Column(children:[Text('Results', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(part3.toString(), style: TextStyle(fontSize: 17.0))]),   
                    ]),
                    TableRow( children: [  
                      Column(children:[Text('Questionnaire Question', style: TextStyle(fontSize: 20.0))]),  
                      Column(children:[Text('Completed ', style: TextStyle(fontSize: 20.0))]),
                    ]),  
                    TableRow( children: [  
                      Column(children:[Text(' I have had psoriasis for at least 10 years.', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(p3_10years.toString(), style: TextStyle(fontSize: 17.0))]),   
                    ]),
                    TableRow( children: [  
                      Column(children:[Text(' My psoriasis first developed before I was 10 years old and/or has been present for more than 20 years.', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(p3_20years.toString(), style: TextStyle(fontSize: 17.0))]),   
                    ]),
                    TableRow( children: [  
                      Column(children:[Text(' I have had bright red and very inflamed psoriasis covering all my skin.', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(p3_bright_red.toString(), style: TextStyle(fontSize: 17.0))]),   
                    ]),
                    TableRow( children: [  
                      Column(children:[Text(' A rheuumatologist has confirmed that I have psoriatic arthrtis.', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(p3_rheumatologist.toString(), style: TextStyle(fontSize: 17.0))]),   
                    ]),
                    TableRow( children: [  
                      Column(children:[Text(' Ultraviolet light treatment', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(p3_ultraviolet.toString(), style: TextStyle(fontSize: 17.0))]),   
                    ]),
                    TableRow( children: [  
                      Column(children:[Text(' The number of my psoriasis tablets and/or injections', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(p3_number_of_tablets.toString(), style: TextStyle(fontSize: 17.0))]),   
                    ]),
                    TableRow( children: [  
                      Column(children:[Text(' My psoriasis tablets and/or injections', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(p3_which_tablets.toString(), style: TextStyle(fontSize: 17.0))]),   
                    ]),
                  ],  
                ),  
              ), 
              SizedBox(height: size.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}

