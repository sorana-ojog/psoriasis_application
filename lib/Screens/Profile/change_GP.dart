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
import 'package:psoriasis_application/components/text_field_container.dart';
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
  String password = "";
  String new_GP = "";
  bool visible = false;
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
        height: size.height * 0.35,
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
                    return  Container( 
                      child: Column(children:
                      <Widget>[
                        TextFieldContainer(
                      child: TextField(
                        obscureText: !visible,
                        onChanged: (value) => password = value,
                        decoration: InputDecoration(
                          hintText: "Password",
                          icon: Icon(
                            Icons.vpn_key,
                            color: kPrimaryColor,
                          ),
                          suffixIcon: IconButton(
                              icon: visible ? Icon(Icons.visibility, color:  kPrimaryColor ):
                                              Icon(Icons.visibility_off,color:  Colors.grey),
                              onPressed: () {
                                setState(() {
                                  visible = !visible;
                                });
                              }),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  constraints: BoxConstraints(maxWidth: 500),
                      child: 
                          RoundedInputField(
                            hintText: "New Code From GP", 
                            onChanged: (value) => new_GP = value,
                            icon: Icons.title,
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
                      onPressed: ()async{
                        FirebaseAuth auth = FirebaseAuth.instance;
                        final User? user = await auth.currentUser;
                        final uid = user!.uid;
                        var email ="";
                        var text = "";
                        var count = 0;
                        CollectionReference ref = await FirebaseFirestore.instance.collection('users');
                        await ref
                            .where("user_ID", isEqualTo: uid)
                            .get()
                            .then((value) {
                          value.docs.forEach((result) {
                            email = result["email"];
                          });
                        });
                        try {
                          UserCredential userCredential = await auth.signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'wrong-password') {
                            const snackBar = SnackBar(
                              duration: const Duration(seconds: 5),
                              content: Text('Wrong Password!'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            return;
                            }else{
                              const snackBar = SnackBar(
                              duration: const Duration(seconds: 5),
                              content: Text('Something went wrong. Try again soon.'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            return;
                            }
                          }
                          CollectionReference ref2 = await FirebaseFirestore.instance.collection('doctors');
                        await ref2
                            .where("doctor_code", isEqualTo: new_GP)
                            .get()
                            .then((value) {
                          value.docs.forEach((result) {
                            count += 1;
                          });
                        });
                        if(count == 0){
                          const snackBar = SnackBar(
                          content: Text('There is no GP with this code.'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          return;
                        }
                          CollectionReference users = FirebaseFirestore.instance.collection('users');
                          await users
                            .where("user_ID", isEqualTo: uid)
                            .get()
                            .then((value) {
                            value.docs.forEach((result) {
                              result.reference.update({'signup_code' : new_GP});
                            });
                          })
                          .catchError((error) => text = "Failed to update user: $error");
                        // on patient side, change gp, on gp side, change code => not available to patients anymore


  //                             .where("user_ID", isEqualTo: uid)
  // .get()
  // .then(function(querySnapshot) {
  //   querySnapshot.forEach(function(document) {
  //    document.ref.update({ ... }); 
  //   });
  // });

                              // .where("user_ID", isEqualTo: uid)
                          //     .doc("asdfg")
                          //     .update({'company': 'Stokes and Sons'})
                          //     .then((value) => text = "GP changed successfully!")
                          //     .catchError((error) => text = "Failed to update user: $error");
                          
                          if(text == ""){
                            const snackBar = SnackBar(
                          content: Text('GP changed successfully!'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.pop(context);
                          }else{
                          const snackBar = SnackBar(
                          content: Text('Failed to change GP.'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          return;
                          }
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