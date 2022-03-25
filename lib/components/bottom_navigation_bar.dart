import 'package:flutter/material.dart';
import 'package:psoriasis_application/Screens/Blank/blank.dart';
import 'package:psoriasis_application/Screens/Home/components/body.dart';
import 'package:psoriasis_application/Screens/Login/login_screen.dart';
import 'package:psoriasis_application/Screens/NewEntry/new_entry.dart';
import 'package:psoriasis_application/Screens/PastEntries/past_entries.dart';
import 'package:psoriasis_application/Screens/Profile/profile_screen.dart';
import 'package:psoriasis_application/Screens/QuestionnaireP1/image_click.dart';
import 'package:psoriasis_application/Screens/QuestionnaireP1/questionnaire_page1.dart';
import 'package:psoriasis_application/Screens/QuestionnaireP2/questionnaire_page2.dart';
import 'package:psoriasis_application/Screens/QuestionnaireP3/questionnaire_page3.dart';
import 'package:psoriasis_application/Screens/QuestionnaireP4/questionnaire_page4.dart';
import 'package:psoriasis_application/Screens/Signup/signup_screen.dart';
import 'package:psoriasis_application/constants.dart';

import '../Screens/Home/home_screen.dart';


class NavBar extends StatefulWidget {
  final int whichPage;
  final int mini;
  const NavBar({
    Key? key, 
    required this.whichPage, 
    required this.mini
  }):super(key: key);
  @override
  _MyHomePageState createState()
  {
    return _MyHomePageState(whichPage: whichPage, mini:mini);
  }
}

class _MyHomePageState extends State<NavBar> {
  int whichPage;
  int mini;
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

  // List<Widget> _items = [
  //   HomeScreen(),
  //   page_items[1],
  //   PastEntries(),
  //   Profile()
  // ];
  // int _selectedIndex = 1; //or 1
  
  List<int> _selectedIndex =[0,1];

  @override
  Widget build(BuildContext context) {
    // whichPage == 0 ? _miniIndex = 0 : _miniIndex = 1;
    return Scaffold(
      body:Center(
        child: IndexedStack(
          index: _selectedIndex[mini],
          children: <Widget>[
            HomeScreen(),
            page_items[whichPage],
            PastEntries(),
            Profile()
          ]
        )//_items.elementAt(_index),
      ),
      bottomNavigationBar: _showBottomNav(),
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
    setState(() {

    });
  }
}

