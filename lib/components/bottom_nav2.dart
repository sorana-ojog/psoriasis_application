import 'package:flutter/material.dart';
import 'package:psoriasis_application/Screens/Blank/blank.dart';
import 'package:psoriasis_application/Screens/Graphs/graphs.dart';
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
import 'package:psoriasis_application/components/bottom_navigation_bar.dart';
import 'package:psoriasis_application/constants.dart';

import '../Screens/Home/home_screen.dart';


class NavBar2 extends StatefulWidget {
  const NavBar2({
    Key? key, 
  }):super(key: key);
  @override
  _MyHomePageState createState()
  {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<NavBar2> {
  _MyHomePageState({
    Key? key, 
  });
  
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    // whichPage == 0 ? _miniIndex = 0 : _miniIndex = 1;
    return Scaffold(
      // body:Center(
      //   child: IndexedStack(
      //     index: _selectedIndex,
      //     children: <Widget>[
      //       HomeScreen(),
      //       NewEntry(),
      //       PastEntries(),
      //       Profile()
      //     ]
      //   )//_items.elementAt(_index),
      // ),
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
      currentIndex: _selectedIndex,
      selectedItemColor: kPrimaryColor,
      unselectedItemColor: Colors.white,
      onTap: _onTap,
    );
  }

  void _onTap(int index)
  {
    _selectedIndex = index;
    setState(() {

    });
  }
}

