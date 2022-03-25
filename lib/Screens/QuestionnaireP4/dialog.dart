// import 'package:psoriasis_application/themes/constants.dart';
// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:psoriasis_application/Screens/Blank/blank.dart';
import 'package:psoriasis_application/Screens/QuestionnaireP1/questionnaire_page1.dart';
import 'package:psoriasis_application/Screens/QuestionnaireP2/questionnaire_page2.dart';
import 'package:psoriasis_application/Screens/QuestionnaireP3/questionnaire_page3.dart';
import 'package:psoriasis_application/Screens/Welcome/welcome_screen.dart';
import 'package:psoriasis_application/components/button_title.dart';
import 'package:psoriasis_application/components/rounded_button.dart';
import 'package:psoriasis_application/components/svg_data1.dart';
import 'package:psoriasis_application/constants.dart';
import 'package:psoriasis_application/components/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyDialog extends StatefulWidget {
  MyDialog({
    required this.tablets,
    required this.selectedTablets,
    required this.onSelectedTabletsListChanged,
    other
  });

  final List<String> tablets;
  final List<String> selectedTablets;
  final ValueChanged<List<String>> onSelectedTabletsListChanged;
  String other ='';
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  List<String> _tempSelectedTablets = [];
  @override
  void initState() {
    _tempSelectedTablets = widget.selectedTablets;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: size.width * 0.3,
        height: size.height * 0.5,
        constraints: BoxConstraints(maxWidth: 350),
        child: Column(
          children: <Widget>[
                const Text(
                  'Select psoriasis tablets and/or injections',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    ),  
                ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.tablets.length,
                  itemBuilder: (BuildContext context, int index) {
                    final cityName = widget.tablets[index];
                    return Container(
                      child: CheckboxListTile(
                          title: Text(cityName),
                          value: _tempSelectedTablets.contains(cityName),
                          activeColor: kPrimaryColor,
                          checkColor: Colors.white,
                          onChanged: (bool? value) {
                            if (value!) {
                              if (!_tempSelectedTablets.contains(cityName)) {
                                setState(() {
                                  _tempSelectedTablets.add(cityName);
                                });
                              }
                            } else {
                              if (_tempSelectedTablets.contains(cityName)) {
                                setState(() {
                                  _tempSelectedTablets.removeWhere(
                                      (String city) => city == cityName);
                                });
                              }
                            }
                            widget
                                .onSelectedTabletsListChanged(_tempSelectedTablets);
                          }),
                    );
                  }),
            ),
            // Container(
            //   alignment: Alignment.center,
            //   margin: EdgeInsets.symmetric(vertical: 10),
            //   width: size.width * 0.5,
            //   height: size.height * 0.05,
            //   constraints: BoxConstraints(maxWidth: 500),
            //   child: TextField(
            //     onChanged: (value) => widget.other = value,
            //     decoration: InputDecoration(
            //       counterText: "",
            //       border: OutlineInputBorder(),
            //       focusedBorder: OutlineInputBorder(
            //           borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
            //       ),
            //     ),
            //   ),
            // ),
            Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: size.width * 0.20,
                  height: size.height * 0.05,
                  constraints: BoxConstraints(maxWidth: 100),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor,
                      ),
                      onPressed: (){
                        Navigator.pop(context);
                        }, 
                      child: Text('Done'),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}