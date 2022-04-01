// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psoriasis_application/components/text_field_container.dart';
import 'package:psoriasis_application/constants.dart';


class ChangeCodeDialog extends StatefulWidget {
  @override
  _ChangeGPDialogState createState() => _ChangeGPDialogState();
}

class _ChangeGPDialogState extends State<ChangeCodeDialog> {
  String password = "";
  String doctor_code = "";
  bool visible = false;
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
                  'Change your code',
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
                    Text("To change your code, type in your password and press DONE. A new code will be automatically generated for you"),
                    SizedBox(height: size.height * 0.01),
                    Text("WARNING! If you change your code, you will lose all patients that have registered with your code previously.")
                      ])
                    );
                  }
                  ),
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
                        var r = Random();
                        const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
                        doctor_code = List.generate(10, (index) => _chars[r.nextInt(_chars.length)]).join();
                          CollectionReference users = FirebaseFirestore.instance.collection('doctors');
                          await users
                            .where("user_ID", isEqualTo: uid)
                            .get()
                            .then((value) {
                            value.docs.forEach((result) {
                              result.reference.update({'doctor_code' : doctor_code});
                            });
                          })
                          .catchError((error) => text = "Failed to update your code: $error");
                          if(text == ""){
                            const snackBar = SnackBar(
                          content: Text('Code changed successfully!'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.pop(context);
                          }else{
                          const snackBar = SnackBar(
                          content: Text('Failed to change your code.'),
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