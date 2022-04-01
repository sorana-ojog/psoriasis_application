import 'package:flutter/material.dart';
import 'package:psoriasis_application/Screens/HomeDoc/home_doc.dart';
import 'package:psoriasis_application/Screens/PacientGraph/patient_graph.dart';
import 'package:psoriasis_application/Screens/PatientForm/patient_form.dart';
import 'package:psoriasis_application/Screens/ProfileGP/profile_gp.dart';
import 'package:psoriasis_application/Screens/SeePatients/search_patients.dart';
import 'package:psoriasis_application/Screens/SeePatients/see_patients.dart';
import 'package:psoriasis_application/Screens/SpecificPacient/specific_patient.dart';
import 'package:psoriasis_application/constants.dart';

class NavBarDoctor extends StatefulWidget {
  final int whichPage;
  final int mini;
  final String uid;
  final String date;
  final String input;
  const NavBarDoctor({
    Key? key, 
    required this.whichPage, 
    required this.mini,
    this.uid = "",
    this.date = "",
    this.input = ""
  }):super(key: key);
  @override
  _MyHomePageState createState()
  {
    return _MyHomePageState(whichPage: whichPage, mini:mini);
  }
}
int finish = 0;
// List<Widget> page_items =[SeePatients()];
class _MyHomePageState extends State<NavBarDoctor> {
  int whichPage;
  int mini;

  List list = [];
  _MyHomePageState({
    Key? key, 
    required this.whichPage,
    required this.mini
  });
  
  Future<List<Widget>> data() async{
    String uid ="";
    String date = "";
    uid = widget.uid;
    date = widget.date;
    List<Widget> page_items  = [
      SeePatients(), //0
      SpecificPacient(uid: uid), //1
      PacientGraph(uid: uid), //2
      PatientForm(uid: uid, date: date), //3
      SearchPatients(last_name: widget.input) //4
    ];
    finish = 1;
    return page_items;
  }
  
  List<int> _selectedIndex =[0,1];

  @override
  Widget build(BuildContext context) {
    
    final Future<List<Widget>> page_items = data();
    // whichPage == 0 ? _miniIndex = 0 : _miniIndex = 1;
    return Scaffold(
      bottomNavigationBar: _showBottomNav(),
      body:FutureBuilder<List<Widget>>(
        future: page_items, // a previously-obtained Future<List<String>> or null
        builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
      List<Widget> children;
      if (snapshot.hasData && snapshot.data != [] && finish != 0) {
        children = <Widget>[
            HomeScreenDoc(),
            snapshot.data![whichPage],
            ProfileGP()
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
            icon: Icon(Icons.assignment),
            label: 'Your Patients',
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

