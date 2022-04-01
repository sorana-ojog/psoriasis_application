// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psoriasis_application/components/text_field_container.dart';
import 'package:psoriasis_application/constants.dart';


class ChangeDialog extends StatefulWidget {
  @override
  _ChangeDialogState createState() => _ChangeDialogState();
}

class _ChangeDialogState extends State<ChangeDialog> {
  String password = "";
  String new_password = "";
  String new_password_confirmation = "";
  bool visible = false;
  bool visible2 = false;
  bool visible3 = false;
  List<String> _tempSelectedTablets = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: size.width * 0.8,
        height: size.height * 0.45,
        constraints: BoxConstraints(maxWidth: 350),
        child: Column(
          children: <Widget>[
                const Text(
                  'Change your password',
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
                          hintText: "Old Password",
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
                    TextFieldContainer(
                      child: TextField(
                        obscureText: !visible2,
                        onChanged: (value) => new_password = value,
                        decoration: InputDecoration(
                          hintText: "New Password",
                          icon: Icon(
                            Icons.lock,
                            color: kPrimaryColor,
                          ),
                          suffixIcon: IconButton(
                              icon: visible2 ? Icon(Icons.visibility, color:  kPrimaryColor ):
                                              Icon(Icons.visibility_off,color:  Colors.grey),
                              onPressed: () {
                                setState(() {
                                  visible2 = !visible2;
                                });
                              }),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    TextFieldContainer(
                      child: TextField(
                        obscureText: !visible3,
                        onChanged: (value) => new_password_confirmation = value,
                        decoration: InputDecoration(
                          hintText: "New Password Confirmation",
                          icon: Icon(
                            Icons.lock_outline,
                            color: kPrimaryColor,
                          ),
                          suffixIcon: IconButton(
                              icon: visible3 ? Icon(Icons.visibility, color:  kPrimaryColor ):
                                              Icon(Icons.visibility_off,color:  Colors.grey),
                              onPressed: () {
                                setState(() {
                                  visible3 = !visible3;
                                });
                              }),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
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
                            print('Wrong password provided for that user.');
                            return;
                            }else{
                              const snackBar = SnackBar(
                              duration: const Duration(seconds: 5),
                              content: Text('Something went wrong. Try again in 1 minute.'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            return;
                            }
                          }
                          if (new_password_confirmation != new_password) {
                            const snackBar = SnackBar(
                              duration: const Duration(seconds: 5),
                              content: Text('The passwords do not match!'),
                            );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          return;
                          }
                          user.updatePassword(new_password).then((_){
                          print("Successfully changed password");
                          }).catchError((error){
                          print('Something went wrong. The password was not changed.' + error.toString());
                          });

                          const snackBar = SnackBar(
                          content: Text('Password changed successfully!'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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