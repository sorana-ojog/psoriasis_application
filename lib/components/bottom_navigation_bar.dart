import 'package:flutter/material.dart';
import 'package:psoriasis_application/Screens/CompletedForms/completed_forms.dart';
import 'package:psoriasis_application/Screens/Graphs/graphs.dart';
import 'package:psoriasis_application/Screens/Home/home_screen.dart';
import 'package:psoriasis_application/Screens/HomeDoc/home_doc.dart';
import 'package:psoriasis_application/Screens/NewEntry/new_entry.dart';
import 'package:psoriasis_application/Screens/PacientGraph/patient_graph.dart';
import 'package:psoriasis_application/Screens/PastEntries/past_entries.dart';
import 'package:psoriasis_application/Screens/PatientForm/patient_form.dart';
import 'package:psoriasis_application/Screens/Profile/profile_screen.dart';
import 'package:psoriasis_application/Screens/QuestionnaireP1/image_click.dart';
import 'package:psoriasis_application/Screens/QuestionnaireP2/questionnaire_page2.dart';
import 'package:psoriasis_application/Screens/QuestionnaireP3/questionnaire_page3.dart';
import 'package:psoriasis_application/Screens/QuestionnaireP4/questionnaire_page4.dart';
import 'package:psoriasis_application/Screens/SeePatients/see_patients.dart';
import 'package:psoriasis_application/Screens/SingleForm/single_form.dart';
import 'package:psoriasis_application/Screens/SpecificPacient/specific_patient.dart';
import 'package:psoriasis_application/constants.dart';

class NavBar extends StatefulWidget {
  final int whichPage;
  final int whichPage2;
  final int mini;
  final String date;
  const NavBar ({
    Key? key, 
    required this.whichPage, 
    required this.mini,
    this.date = "", 
    this.whichPage2 = 0
  }):super(key: key);
  @override
  _MyHomePageState createState()
  {
    return _MyHomePageState(whichPage: whichPage, mini:mini);
  }
}
int finish = 0;
// List<Widget> page_items2 =[SeePatients()];
class _MyHomePageState extends State<NavBar > {
  int whichPage;
  int mini;

  List list = [];
  _MyHomePageState({
    Key? key, 
    required this.whichPage,
    required this.mini
  });
  
   List<Widget> page_items = [
    NewEntry(), //0
    ImageClick(whichImage: "front"), //1
    ImageClick(whichImage: "back"), //2
    QuestionnaireP2(), //3
    QuestionnaireP3(), //4
    QuestionnaireP4(), //5
  ];

  Future<List<Widget>> data() async{
    String date = "";
    date = widget.date;
    List<Widget> page_items2  = [
      PastEntries(), //0
      CompletedForms(), //1
      Graphs(), //2
      SingleForm( date: date) //3
    ];
    finish = 1;
    return page_items2;
  }
  
  List<int> _selectedIndex =[0,1,2];

  @override
  Widget build(BuildContext context) {
    
    final Future<List<Widget>> page_items2 = data();
    // whichPage == 0 ? _miniIndex = 0 : _miniIndex = 1;
    return Scaffold(
      bottomNavigationBar: _showBottomNav(),
      body:FutureBuilder<List<Widget>>(
        future: page_items2, // a previously-obtained Future<List<String>> or null
        builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
      List<Widget> children;
      if (snapshot.hasData && snapshot.data != [] && finish != 0) {
        children = <Widget>[
            HomeScreen(),
            page_items[whichPage],
            snapshot.data![widget.whichPage2],
            Profile()
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
      Center(
        child: IndexedStack(
          index: _selectedIndex[mini],
          children: children
        )//_items.elementAt(_index),
      );
      }
      )
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
      currentIndex: _selectedIndex[mini],
      selectedItemColor: kPrimaryColor,
      unselectedItemColor: Colors.white,
      onTap: _onTap,
    );
  }

  void _onTap(int index)
  {
    _selectedIndex[mini] = index;
    setState((){
    });
  }
}

