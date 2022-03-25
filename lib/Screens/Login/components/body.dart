// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:psoriasis_application/Screens/Blank/blank.dart';
import 'package:psoriasis_application/Screens/Home/home_screen.dart';
import 'package:psoriasis_application/Screens/Login/components/background.dart';
import 'package:psoriasis_application/Screens/Login/login_screen.dart';
import 'package:psoriasis_application/Screens/Signup/signup_screen.dart';
import 'package:psoriasis_application/components/already_have_an_account.dart';
import 'package:psoriasis_application/components/bottom_navigation_bar.dart';
import 'package:psoriasis_application/components/rounded_button.dart';
import 'package:psoriasis_application/components/rounded_input_field.dart';
import 'package:psoriasis_application/components/rounded_password_field.dart';
import 'package:psoriasis_application/components/text_field_container.dart';
import 'package:psoriasis_application/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

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
          RoundedPasswordField(
            hintText: "Password",
            onChanged: (value) => password = value,
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
              
              const snackBar = SnackBar(
                content: Text('Successfully signed in!'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context){
                    // FirebaseFirestore f =FirebaseFirestore.instance;
                    // CollectionReference c = f.collection('users');
                    // c.add({email : password});
                    return NavBar(whichPage: 0, mini: 0);
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
