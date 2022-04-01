// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:psoriasis_application/Screens/Login/components/background.dart';
import 'package:psoriasis_application/Screens/Signup/signup_screen.dart';
import 'package:psoriasis_application/components/already_have_an_account.dart';
import 'package:psoriasis_application/components/bottom_nav_doc.dart';
import 'package:psoriasis_application/components/bottom_navigation_bar.dart';
import 'package:psoriasis_application/components/rounded_button.dart';
import 'package:psoriasis_application/components/rounded_input_field.dart';
import 'package:psoriasis_application/components/text_field_container.dart';
import 'package:psoriasis_application/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:psoriasis_application/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Body());
}
String email = ""; 
String password = "";
class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Login",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          
          SizedBox(height: size.height * 0.03),
          Image.asset(
              "assets/images/doctor.png", 
              height: size.height * 0.4,
          ),
          RoundedInputField(
            hintText: "Your Email",
            onChanged: (value) => email = value,
          ),
          TextFieldContainer(
              child: TextField(
                obscureText: !visible,
                onChanged: (value) => password = value,
                decoration: InputDecoration(
                  hintText: "Password",
                  icon: Icon(
                    Icons.lock,
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
          RoundedButton(
            text: "SIGN IN", 
            press: ()async {
              try {
                UserCredential userCredential = await auth.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  const snackBar = SnackBar(
                    duration: const Duration(seconds:5),
                    content: Text('No user found for this email.'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  print('No user found for this email.');
                  return;
                } else if (e.code == 'wrong-password') {
                  const snackBar = SnackBar(
                    duration: const Duration(seconds: 5),
                    content: Text('Wrong Password!'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  print('Wrong password provided for that user.');
                  return;
                } else {
                  const snackBar = SnackBar(
                    duration: const Duration(seconds: 5),
                    content: Text('This is not a valid email!'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  print('This is not a valid email.');
                  return;
                }
              } catch (e) {
                print(e);
              }
              final User? user = await auth.currentUser;
              final uid = user!.uid;
              String badge ="";
              print (uid);
              CollectionReference ref = await FirebaseFirestore.instance.collection('users');
              await ref
                  .where("user_ID", isEqualTo: uid)
                  .get()
                  .then((value) {
                value.docs.forEach((result) {
                  badge = result["signup_code"];
                  print(badge);
                });
              });
              final regex = RegExp(r'[0-9]{9}');

              const snackBar = SnackBar(
                content: Text('Successfully signed in!'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context){
                    if ( !user.emailVerified) {
                      return Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(50),
                        constraints: BoxConstraints(maxWidth: 800),
                        child: Text(
                          'Welcome to Psoriasis Control. Before using this service, you must verify your email. Go to your inbox and click on the link there. Afterwards, come here again and refresh the page.', 
                          style: TextStyle(
                          fontSize: 18,
                          color: kPrimaryColor
                          ),
                        ),
                      );
                      }else{
                        if(regex.hasMatch(badge) ){
                          print("i am doctor");
                          return NavBarDoctor(whichPage:0, mini: 0);
                        }else{
                          print("i am not a doctor");
                          return NavBar(whichPage:0, mini: 0);
                        }
                      }
                  },
                ),
              );
            },
          ),
          SizedBox(height: size.height * 0.03),
          AlreadyHaveAnAccountCheck(
            press: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                  return SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
      ),
    );
  }
}
