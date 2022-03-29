// import 'package:psoriasis_application/themes/constants.dart';
// ignore_for_file: deprecated_member_use
import 'package:firebase_core/firebase_core.dart';
import 'package:psoriasis_application/Screens/Results/results.dart';
import 'package:psoriasis_application/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:psoriasis_application/Screens/QuestionnaireP4/dialog.dart';
import 'package:intl/intl.dart';

FirebaseAuth auth = FirebaseAuth.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(QuestionnaireP4());
}

class  QuestionnaireP4 extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State< QuestionnaireP4> {
    bool? _value1 = false;
    bool? _value2 = false;
    bool? _value3 = false;
    bool? _value4 = false;
    bool? _value5 = false;
    String tablets_no= "0";
    bool checkboxValueCity = false;
    List<String> allTablets = ['Acitretin', 'Ciclosporin', 'Efalizumab', 'Methotrexate', 'Infliximab', 'Dimethylfumarate', 'Etanercept', 'Apremilast', 'Secukinumab', 'Ustekinumab', 'Other'];
    List<String> selectedTablets = [];
    DateTime currentPhoneDate = DateTime.now(); //DateTime

//     @override
//     initState() {
//       super.initState();
//       loadSwitchValue();
//     }


//     checkValue() async{
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       setState(() {
//         prefs.setBool('astricin', _valueA!);
//       });
// print('no');
//     }

//     loadSwitchValue()async{
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       setState(() {
//         _valueA = (prefs.getBool('astricin')) ?? false;
//       });
//       print('yes');
//     }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                // for (int i in [1,2,3,4,5])
                  ButtonTitle(
                  page: NavBar(whichPage: 1, mini: 1),
                  text: 'Part 1A (front)',
                  ),
                  SizedBox(width: size.width * 0.015),
                  ButtonTitle(
                    page: NavBar(whichPage: 2, mini: 1),
                    text: 'Part 1A (back)',
                    ),
                  SizedBox(width: size.width * 0.015),
                  ButtonTitle(
                    page: NavBar(whichPage: 3, mini: 1),
                    text: 'Part 1B',
                    ),
                  SizedBox(width: size.width * 0.015),
                  ButtonTitle(
                    page: NavBar(whichPage: 4, mini: 1),
                    text: 'Part 2',
                    ),
                  SizedBox(width: size.width * 0.015),
                  ButtonTitle(
                    page: NavBar(whichPage: 5, mini: 1),
                    text: 'Part 3',
                    ),
                  SizedBox(width: size.width * 0.015),
                ],
            ),
          ),
        ),
        backgroundColor: kPrimaryColor,
      ),
      // bottomNavigationBar: NavBar(), ///////maybe copy paste bar
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: size.height * 0.05),
              Text(
                'PART 3',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  ),
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width * 0.85,
                constraints: BoxConstraints(maxWidth: 1000),
                child: Text(
                  'This part forms a record about you and your psoriasis.', 
                  style: TextStyle(
                  fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width * 0.85,
                constraints: BoxConstraints(maxWidth: 1000),
                child: Text(
                  'About your psoriasis',
                  style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  // decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width * 0.90,
                constraints: BoxConstraints(maxWidth: 1000),
                child: CheckboxListTile(
                    title: const Text('I have had psoriasis for at least 10 years.'),
                    autofocus: false,
                    activeColor: kPrimaryColor,
                    checkColor: Colors.white,
                    // selected: this._value,
                    value: _value1,
                    onChanged: (bool? value) {
                      setState(() {
                        _value1 = value;
                      });
                    },
                  ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width * 0.90,
                constraints: BoxConstraints(maxWidth: 1000),
                child: CheckboxListTile(
                    title: const Text('My psoriasis first developed before I was 10 years old and/or has been present for more than 20 years.'),
                    autofocus: false,
                    activeColor: kPrimaryColor,
                    checkColor: Colors.white,
                    // selected: this._value,
                    value: _value2,
                    onChanged: (bool? value) {
                      setState(() {
                        _value2 = value;
                      });
                    },
                  ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width * 0.90,
                constraints: BoxConstraints(maxWidth: 1000),
                child: CheckboxListTile(
                    title: const Text('I have had bright red and very inflamed psoriasis (with or without pus spots) covering all my skin (erythrodermic or generalised pustular psoriasis).'),
                    autofocus: false,
                    activeColor: kPrimaryColor,
                    checkColor: Colors.white,
                    // selected: this._value,
                    value: _value3,
                    onChanged: (bool? value) {
                      setState(() {
                        _value3 = value;
                      });
                    },
                  ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width * 0.90,
                constraints: BoxConstraints(maxWidth: 1000),
                child: CheckboxListTile(
                    title: const Text('A rheuumatologist (arthritis specialist) has confirmed that I have psoriatic arthrtis.'),
                    autofocus: false,
                    activeColor: kPrimaryColor,
                    checkColor: Colors.white,
                    // selected: this._value,
                    value: _value4,
                    onChanged: (bool? value) {
                      setState(() {
                        _value4 = value;
                      });
                    },
                  ),
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width * 0.85,
                constraints: BoxConstraints(maxWidth: 1000),
                child: Text(
                  'About your psoriasis treatment',
                  style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width * 0.90,
                constraints: BoxConstraints(maxWidth: 1000),
                child: CheckboxListTile(
                    title: const Text('Ultraviolet light treatment(UVB and/or PUVA)'),
                    autofocus: false,
                    activeColor: kPrimaryColor,
                    checkColor: Colors.white,
                    // selected: this._value,
                    value: _value5,
                    onChanged: (bool? value) {
                      setState(() {
                        _value5= value;
                      });
                    },
                  ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width * 0.87,
                constraints: BoxConstraints(maxWidth: 1000),
                child: 
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric( horizontal: 10),
                      width: size.width * 0.60,
                      height: size.height * 0.10,
                      constraints: BoxConstraints(maxWidth: 900),
                      child: 
                    Text(
                      'The number of your psoriasis tablets and/or injections',
                      style: TextStyle(
                      fontSize: 16,
                      ),
                     ),),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      width: size.width * 0.10,
                      height: size.height * 0.03,
                      constraints: BoxConstraints(maxWidth: 50),
                      child: TextField(
                        maxLength: 2,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                        onChanged: (value) => tablets_no = value,
                        decoration: InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    
                  ]
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width * 0.87,
                constraints: BoxConstraints(maxWidth: 1000),
                child: 
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric( horizontal: 10),
                      width: size.width * 0.60,
                      height: size.height * 0.10,
                      constraints: BoxConstraints(maxWidth: 850),
                      child: 
                    Text(
                      'Add your psoriasis tablets and/or injections',
                      // maxLines: 2,
                      style: TextStyle(
                      fontSize: 16,
                      ),
                     ),
                      ), 
                    Container(
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: size.width * 0.18,
                      height: size.height * 0.03,
                      constraints: BoxConstraints(maxWidth: 100),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: 
                        
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: kPrimaryColor,
                          ),
                          onPressed: (){
                            showDialog(
                              context: context,
                              builder: (context) {
                                return MyDialog(
                                  tablets: allTablets,
                                  selectedTablets: selectedTablets,
                                  onSelectedTabletsListChanged: (tablets) {
                                    selectedTablets = tablets;
                                    print(selectedTablets);
                                  }
                                );
                              }
                            );
                          },
                          child: const Text('Add'),
                        ),
                      ),
                    ),
                    
                  ]
                ),
              ),
              SizedBox(height: size.height * 0.10),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width * 0.90,
                constraints: BoxConstraints(maxWidth: 1000),
                child: 
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: size.width * 0.3,
                    height: size.height * 0.05,
                    constraints: BoxConstraints(maxWidth: 350),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor,
                        ),
                        onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                          return NavBar(whichPage: 4, mini: 1);
                          },
                        ),
                      );
                    },
                        child: Text('Previous'),
                      ),
                    ),
                  ),
                  // SizedBox(width: size.width * 0.3),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: size.width * 0.3,
                    height: size.height * 0.05,
                    constraints: BoxConstraints(maxWidth: 350),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor,
                        ),
                        onPressed: ()async {
                          final User? user = auth.currentUser;
                          final uid = user!.uid;
                          Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate);
                          DateTime myDateTime = myTimeStamp.toDate();
                          final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
                          final String formatted = formatter.format(myDateTime);
                          print("current phone data is: $currentPhoneDate");
                          print("current phone data is: $formatted");
                          final prefs = await SharedPreferences.getInstance();
                          final int? part1b = await prefs.getInt('psoriasis_today');
                          final double? _part2 = await prefs.getDouble('affected_today'); 

                          double _part1AScore = 0;
                          Map<String, double?> zoneIntensity = {
                            'scalp1': 0,
                            'face2': 0,
                            'arms3': 0,
                            'hands4': 0,
                            'chest5': 0,
                            'back6': 0,
                            'genitals7': 0,
                            'thighs8': 0,
                            'legs9': 0,
                            'feets10': 0,
                          };

                          for(var z in zoneIntensity.keys){
                            double? thisZone = await prefs.getDouble(z);
                            if(thisZone != null){
                              zoneIntensity[z] = thisZone;
                              _part1AScore = _part1AScore + zoneIntensity[z]!;          
                            }
                            print(zoneIntensity[z]);
                          }
                          double part1 = 0;
                          if(part1b != null){
                            part1 = _part1AScore * part1b;
                          }

                          
                          // final int? part1 = 0;
                          final int? part2 = _part2?.toInt();
                          // ///////// 
                          int part3Res = 0;
                          for (var name in [_value1, _value2, _value3, _value4, _value5]) {
                            if(name == true){
                              part3Res += 1;
                            }
                          }
                          ////////null error
                          if(int.parse(tablets_no) <= 5){
                            part3Res += int.parse(tablets_no);
                          }else{
                            part3Res += 5;
                          }
                          await prefs.setDouble('part1Score', part1);
                          await prefs.setInt('history', part3Res);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                FirebaseFirestore f = FirebaseFirestore.instance;
                                CollectionReference c = f.collection('form');
                                c.add({
                                  "part1" : part1,
                                  "part1b" : part1b,
                                  "part2": part2,
                                  "part3": part3Res,
                                  "p3_10years": _value1,
                                  "p3_20years": _value2,
                                  "p3_bright_red": _value3,
                                  "p3_rheumatologist": _value4,
                                  "p3_ultraviolet": _value5,
                                  "p3_number_of_tablets": tablets_no,
                                  "p3_which_tablets": selectedTablets,
                                  "user_ID": uid,
                                  "date_time": formatted,
                                  'scalp1': zoneIntensity['scalp1'],
                                  'face2': zoneIntensity['face2'],
                                  'arms3': zoneIntensity['arms3'],
                                  'hands4': zoneIntensity['hands4'],
                                  'chest5': zoneIntensity['chest5'],
                                  'back6': zoneIntensity['back6'],
                                  'genitals7': zoneIntensity['genitals7'],
                                  'thighs8': zoneIntensity['thighs8'],
                                  'legs9': zoneIntensity['legs9'],
                                  'feets10': zoneIntensity['feets10'],
                                });
                                //remove stuff
                                return Results();
                              },
                            ),
                          );
                        },
                          child: Text('Send Form'),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                  ],
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }

}
