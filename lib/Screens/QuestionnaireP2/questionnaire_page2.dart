import 'package:flutter/material.dart';
import 'package:psoriasis_application/components/button_title.dart';
import 'package:psoriasis_application/constants.dart';
import 'package:psoriasis_application/components/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class  QuestionnaireP2 extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

enum SingingCharacter { clear, mild, definite, moderate, very_red, intense }
class _AppState extends State< QuestionnaireP2> {
  SingingCharacter? _character = SingingCharacter.clear;
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
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: size.height * 0.03),
              Text(
                'PART 1B',
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
                  'Please select whichever of these choices best describes the overall state of your psoriasis today. Your score should reflect the average of all of your psoriasis, not just the worst areas.', 
                  style: TextStyle(
                  fontSize: 17,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width * 0.90,
                constraints: BoxConstraints(maxWidth: 1000),
                child:   Theme(
                  data: ThemeData(unselectedWidgetColor: Color(0xFF69b34c)),
                  child: 
                  RadioListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text('Clear or just slight redness or staining'),
                    autofocus: false,
                    activeColor: Color(0xFF69b34c),
                    selectedTileColor: Colors.amber,
                    groupValue: _character,
                    value: SingingCharacter.clear,
                    onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                    });
                    }, 
                  ), 
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width * 0.90,
                constraints: BoxConstraints(maxWidth: 1000),
                child:   Theme(
                  data: ThemeData(unselectedWidgetColor: Color(0xFFacb334)),
                  child: RadioListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text('Mild redness or scaling with no more than slight thickening'),
                    autofocus: false,
                    activeColor: Color(0xFFacb334),
                    groupValue: _character,
                    value: SingingCharacter.mild,
                    onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                    });
                    }, 
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width * 0.90,
                constraints: BoxConstraints(maxWidth: 1000),
                child:   Theme(
                  data: ThemeData(unselectedWidgetColor: Color(0xFFfab733)),
                  child: RadioListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text('Definite redness, scaling or thickening'),
                    autofocus: false,
                    activeColor: Color(0xFFfab733),
                    groupValue: _character,
                    value: SingingCharacter.definite,
                    onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                    });
                    }, 
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width * 0.90,
                constraints: BoxConstraints(maxWidth: 1000),
                child:   Theme(
                  data: ThemeData(unselectedWidgetColor: Color(0xFFff8e15)),
                  child: RadioListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text('Moderately severe with obvious redness, scaling or thickening'),
                    autofocus: false,
                    activeColor: Color(0xFFff8e15),
                    groupValue: _character,
                    value: SingingCharacter.moderate,
                    onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                    });
                    }, 
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width * 0.90,
                constraints: BoxConstraints(maxWidth: 1000),
                child:   Theme(
                  data: ThemeData(unselectedWidgetColor: Color(0xFFff4e11)),
                  child: RadioListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text('Very red and inflamed, very scaly or very thick'),
                    autofocus: false,
                    activeColor: Color(0xFFff4e11),
                    groupValue: _character,
                    value: SingingCharacter.very_red,
                    onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                    });
                    }, 
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width * 0.90,
                constraints: BoxConstraints(maxWidth: 1000),
                child:   Theme(
                  data: ThemeData(unselectedWidgetColor: Color(0xFFff0d0d)),
                  child: RadioListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text('Intensely inflamed skin with or without pustules (pus spots)'),
                    autofocus: false,
                    activeColor: Color(0xFFff0d0d),
                    groupValue: _character,
                    value: SingingCharacter.intense,
                    onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                    });
                    }, 
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
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
                          return NavBar(whichPage: 2, mini: 1);
                          },
                        ),
                      );
                    },
                        child: Text('Previous'),
                      ),
                    ),
                  ),
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
                        final prefs = await SharedPreferences.getInstance();
                        switch (_character) {
                          case SingingCharacter.clear:
                            await prefs.setInt('psoriasis_today', 0);
                            break;
                          case SingingCharacter.mild:
                            await prefs.setInt('psoriasis_today', 1);
                            break;
                          case SingingCharacter.definite:
                            await prefs.setInt('psoriasis_today', 2);
                            break;
                          case SingingCharacter.moderate:
                            await prefs.setInt('psoriasis_today', 3);
                            break;
                          case SingingCharacter.very_red:
                            await prefs.setInt('psoriasis_today', 4);
                            break;
                          case SingingCharacter.intense:
                            await prefs.setInt('psoriasis_today', 5);
                            break;
                          default:
                            break;
                        }
                        final int? counter = prefs.getInt('psoriasis_today');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                            return NavBar(whichPage: 4, mini: 1);
                            },
                          ),
                        );
                      },
                        child: Text('Next'),
                      ),
                    ),
                  )
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

