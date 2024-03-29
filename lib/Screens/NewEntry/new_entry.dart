import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psoriasis_application/components/bottom_navigation_bar.dart';
import 'package:psoriasis_application/components/description_text.dart';
import 'package:psoriasis_application/components/rounded_button.dart';
import 'package:psoriasis_application/constants.dart';
import 'package:intl/intl.dart';


FirebaseAuth auth = FirebaseAuth.instance;
class NewEntry extends StatefulWidget {
  @override
   _AppState createState() => _AppState();
}

class _AppState extends State<NewEntry> {
  bool? _value = false;
   DateTime currentPhoneDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('New Entry'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Container(
        width:double.infinity,
        height: size.height,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: size.height * 0.03),
              Text(
                'Simplified Psoriasis Index',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  ),
              ),
              SizedBox(height: size.height * 0.03),
              DescriptionText(
                titleText: 'Description', 
                text: 'The Self-Assessment Simplified Psoriasis Index (saSPI-s) is a tool which has been developed to enable patients with psoriasis to make regular assessments of disease severity and its impact on well-being. It also incorporates a summary of past behaviour and treatment. ',
                titleSize: 20,
              ),
              SizedBox(height: size.height * 0.03),
              DescriptionText(
                titleText: 'DOMAIN 1: Current Severity', 
                text: 'The current severity domain accords extra weight to certain functionally or psychosocially important body sites (scalp, face, anogenital area, hands, feet). It consists of two components:',
                titleSize: 20,
              ),
              SizedBox(height: size.height * 0.01),
              DescriptionText(
                titleText: '• Psoriasis extent (part 1A)', 
                text: '  The extent of psoriasis in each of 10 unequally sized body sites is scored on a 3-point scale (0 : absent or minimal, 0.5 : noticeable (+/-), 1 : extensive). The score is based on the distribution of psoriasis across each of the ten areas. ', 
                titleSize: 15
              ),
              SizedBox(height: size.height * 0.01),
              DescriptionText(
                titleText: '• Overall average plaque severity (part 1B)', 
                text: '  The average severity of psoriasis across all involved areas is scored on a 6-point scale ranging from 0 (essentially clear) to 5 (intensely inflamed skin). ', 
                titleSize: 15
              ),
              SizedBox(height: size.height * 0.03),
              DescriptionText(
                titleText: 'DOMAIN 2: Psychosocial Impact',
                text: 'The current impact of psoriasis on patient well-being is marked by the patient on a numbered visual analogue scale: from 0 ("my psoriasis is not affecting me at all") to 10 ("my psoriasis is affecting me very much/ I could not imagine it affecting me more"). ', 
                titleSize: 20
              ),
              SizedBox(height: size.height * 0.03),
              DescriptionText(
                titleText: 'DOMAIN 3: Historical course and interventions', 
                text: 'The historical course and interventions score is assessed by 10 questions, four relating to disease course and six to previous interventions received.', 
                titleSize: 20
              ),
              SizedBox(height: size.height * 0.03),
              DescriptionText(
                titleText: 'ATTENTION! You can only submit one form per day!', 
                text: '', 
                titleSize: 20
              ),
              SizedBox(height: size.height * 0.01),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width * 0.95,
                constraints: BoxConstraints(maxWidth: 1000),
                child: CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text('I understand what I am about to complete and I agree to the processing of my data by the practice I am enrolled at.'),
                    autofocus: false,
                    activeColor: kPrimaryColor,
                    checkColor: Colors.white,
                    value: _value,
                    onChanged: (bool? value) {
                      setState(() {
                        _value = value;
                      });
                    },
                  ),
              ),
              SizedBox(height: size.height * 0.02),
              RoundedButton(
                text: 'Start Questionnaire', 
                press: ()async{
                  final User? user = await auth.currentUser;
                  final uid = user!.uid;
                  List<String> datas = [];
                  var date;
                  int no_forms = 0;
                  CollectionReference ref3 = await FirebaseFirestore.instance.collection('form');
                  await ref3
                      .where("user_ID", isEqualTo: uid)
                      .limit(1)
                      .orderBy("date_time", descending: true)
                      .get()
                      .then((value) {
                    value.docs.forEach((result) {
                      date = result["date_time"];
                      no_forms += 1;
                    });
                  });
                  if (no_forms == 0){
                    date = "none";
                  }else{
                    var date1 = date.split(" ");
                    date = date1[0];
                  }
                 
                  Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate);
                  DateTime myDateTime = myTimeStamp.toDate();
                  final DateFormat formatter = DateFormat('yyyy/MM/dd');
                  final String formatted = formatter.format(myDateTime);
                  if(_value == false){
                    const snackBar = SnackBar(
                    duration: const Duration(seconds: 5),
                    content: Text('You did not agree to the conditions!'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    return;
                  }else if(date == formatted){
                    const snackBar = SnackBar(
                    duration: const Duration(seconds: 5),
                    content: Text('You already submitted the form for today!'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    return;
                  }else{
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                      builder: (context){
                        return NavBar(whichPage: 1, mini: 1);
                        },
                      ),
                    );
                  }
                }
              ),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      )
    );
  } 
}