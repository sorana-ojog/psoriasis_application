import 'package:flutter/material.dart';
import 'package:psoriasis_application/Screens/Signup/components/background.dart';
import 'dart:math';
import 'package:psoriasis_application/Screens/Login/login_screen.dart';
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
String password_confirmation = "";
String title = "";
String first_name = ""; 
String last_name = ""; 
String date_of_birth = "";
String code= "";
class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool visible = false;
  bool visible2 = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height * 0.03),
          Text(
            "Sign Up",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          SizedBox(height: size.height * 0.01),
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
            TextFieldContainer(
              child: TextField(
                obscureText: !visible2,
                onChanged: (value) => password_confirmation = value,
                decoration: InputDecoration(
                  hintText: "Password Confirmation",
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
          RoundedInputField(
            hintText: "GP's Code/ NHS Badge",
            icon: Icons.confirmation_num,
            onChanged: (value) => code = value,
          ),
          RoundedButton(
            text: "SIGN UP", 
            press: ()async {
              if (password_confirmation != password) {
                  const snackBar = SnackBar(
                    duration: const Duration(seconds: 5),
                    content: Text('The passwords do not match!'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return;
                }
              final regex = RegExp(r'[0-9]{9}');
              //checks if the code used in login is a 9 digits one
              var doctor_code= "";
              if(regex.hasMatch(code)){
                var r = Random();
                const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
                doctor_code = List.generate(10, (index) => _chars[r.nextInt(_chars.length)]).join();
              }else{
                var count = 0;
                CollectionReference ref2 = await FirebaseFirestore.instance.collection('doctors');
                await ref2
                    .where("doctor_code", isEqualTo: code)
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
              }
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
              final User? user = await auth.currentUser;
              final uid = user!.uid;
              if (user!= null && !user.emailVerified) {
                await user.sendEmailVerification();
              }
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
                      "date_of_birth": date_of_birth,
                      "email": email,
                      "signup_code": code,
                      "user_ID": uid
                      });
                    if(doctor_code != ""){
                      CollectionReference p = f.collection('doctors');
                      p.add({
                      "doctor_code": doctor_code,
                      "user_ID": uid
                      });
                    }
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
                      if(doctor_code != ""){
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
          SizedBox(height: size.height * 0.01),
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
          SizedBox(height: size.height * 0.05),
        ],
      ),
      ),
    );
  }
}
