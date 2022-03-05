import 'package:flutter/material.dart';
import 'package:psoriasis_application/Screens/Blank/blank.dart';
import 'package:psoriasis_application/Screens/Signup/components/background.dart';

import 'package:flutter/material.dart';
import 'package:psoriasis_application/Screens/Login/login_screen.dart';
import 'package:psoriasis_application/Screens/Signup/signup_screen.dart';
import 'package:psoriasis_application/components/already_have_an_account.dart';
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


// class Body extends StatelessWidget{
//   @override
//   Widget build(BuildContext context){
//     Size size = MediaQuery.of(context).size;
//     return Background(
//       child: Column(
//         children: <Widget>[],
//       ),
//     );
//   }
// }
FirebaseAuth auth = FirebaseAuth.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Body());
}

String email = ""; 
String password = "";
String password_confirmation = "";
String title = "";
String first_name = ""; 
String last_name = ""; 
String date_of_birth = "";
String code= "";
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
            "Sign Up",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          SizedBox(height: size.height * 0.03),
          // Image.asset(
          //     "assets/images/doctor.png", 
          //     height: size.height * 0.08,
          // ),
          RoundedInputField(
            hintText: "Title",
            icon: Icons.title,
            onChanged: (value) => title = value,
          ),
          RoundedInputField(
            hintText: "First Name",
            icon: Icons.person,
            onChanged: (value) => first_name = value,
          ),
          RoundedInputField(
            hintText: "Last Name",
            icon: Icons.person_outline,
            onChanged: (value) => last_name = value,
          ),
          RoundedInputField(
            hintText: "Date Of Birth",
            icon: Icons.calendar_month,
            onChanged: (value) => date_of_birth = value,
          ),
          RoundedInputField(
            hintText: "Email",
            onChanged: (value) => email = value,
          ),
          RoundedPasswordField(
            hintText: "Password",
            onChanged: (value) => password = value,
          ),
          RoundedPasswordField(
            hintText: "Password Confirmation",
            onChanged: (value) => password_confirmation = value,
          ),
          RoundedInputField(
            hintText: "Code Given By GP",
            icon: Icons.confirmation_num,
            onChanged: (value) => code = value,
          ),
          RoundedButton(
            text: "SIGN UP", 
            press: ()async {
              try {
                      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                         const snackBar = SnackBar(
                          duration: const Duration(seconds:5),
                          content: Text('The password is too weak!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        print('The password provided is too weak.');
                        return;
                      } else if (e.code == 'email-already-in-use') {
                         const snackBar = SnackBar(
                          duration: const Duration(seconds:5),
                          content: Text('Email already used for another account!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        print('The account already exists for that email.');
                        return;
                      }else {
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
                content: Text('Successfully registered!'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context){
                    FirebaseFirestore f =FirebaseFirestore.instance;
                    CollectionReference c = f.collection('users');
                    c.add({
                      "title" : title,
                      "first_name": first_name,
                      "last_name": last_name,
                      "date_of_birth:": date_of_birth,
                      "email": email,
                      "code": code
                      });
                    
                    return BlankScreen();
                  },
                ),
              );
            },
          ),
          SizedBox(height: size.height * 0.03),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                  return LoginScreen();
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
