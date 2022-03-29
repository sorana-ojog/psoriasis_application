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
import 'package:psoriasis_application/components/rounded_input_field.dart';
import 'package:psoriasis_application/components/rounded_password_field.dart';
import 'package:psoriasis_application/components/svg_data1.dart';
import 'package:psoriasis_application/constants.dart';
import 'package:psoriasis_application/components/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ChangeGPDialog extends StatefulWidget {
  // ChangeGPDialog({
  //   required this.tablets,
  //   required this.selectedTablets,
  //   required this.onSelectedTabletsListChanged,
  //   other
  // });

  // final List<String> tablets;
  // final List<String> selectedTablets;
  // final ValueChanged<List<String>> onSelectedTabletsListChanged;
  // String other ='';
  @override
  _ChangeGPDialogState createState() => _ChangeGPDialogState();
}

class _ChangeGPDialogState extends State<ChangeGPDialog> {
  List<String> _tempSelectedTablets = [];
  // @override
  // void initState() {
  //   _tempSelectedTablets = widget.selectedTablets;
  //   super.initState();
  // }

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
                  'Change your GP',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    ),  
                ),
            Expanded(
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    // final tabletName = widget.tablets[index];
                    String old_password;
                    String new_password;
                    String confirm_new_password;
                    return  Container( 
                      child: Column(children:
                      <Widget>[
                        Container(
                      alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  constraints: BoxConstraints(maxWidth: 500),
                      child: 
                          RoundedPasswordField(
                            hintText: "Password", 
                            onChanged: (value) => old_password = value,
                          )
                      // CheckboxListTile(
                      //     title: Text(tabletName),
                      //     value: _tempSelectedTablets.contains(tabletName),
                      //     activeColor: kPrimaryColor,
                      //     checkColor: Colors.white,
                      //     onChanged: (bool? value) {
                      //       if (value!) {
                      //         if (!_tempSelectedTablets.contains(tabletName)) {
                      //           setState(() {
                      //             _tempSelectedTablets.add(tabletName);
                      //           });
                      //         }
                      //       } else {
                      //         if (_tempSelectedTablets.contains(tabletName)) {
                      //           setState(() {
                      //             _tempSelectedTablets.removeWhere(
                      //                 (String tablet) => tablet == tabletName);
                      //           });
                      //         }
                      //       }
                      //       widget
                      //           .onSelectedTabletsListChanged(_tempSelectedTablets);
                      //     }),
                    ),
                    Container(
                      alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  constraints: BoxConstraints(maxWidth: 500),
                      child: 
                          RoundedInputField(
                            hintText: "New Code From GP", 
                            onChanged: (value) => new_password = value,
                            icon: Icons.vpn_key,
                          )),
                          
                      ])
                    );
                  }),
            ),
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