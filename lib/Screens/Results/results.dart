import 'package:flutter/material.dart';
import 'package:psoriasis_application/constants.dart';
import 'package:psoriasis_application/components/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class  Results extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<Results> {
  double? _part1 = 0;
  double? _part2 = 0;
  int? _part3 = 0;
  Future<void> preference() async {
  final prefs = await SharedPreferences.getInstance();
  // ignore: await_only_futures
  final double? part1 = await prefs.getDouble('part1Score');
  double? part2 = await prefs.getDouble('affected_today');
  if(part2 == null){
    part2 = 0;
  }
  final int? part3 = await prefs.getInt('history');
  setState(() => _part1 = part1);
  setState(() => _part2 = part2);
  setState(() => _part3 = part3);
  }

  

  @override
  void initState(){
    super.initState();
    preference();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    final Future<void> counter = preference();

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: size.width * 0.85,
                constraints: BoxConstraints(maxWidth: 1000),
                child: Text(
                  'Congratulations on completing the form!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 30,
                  color: kPrimaryLightColor,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.65,
                constraints: BoxConstraints(maxWidth: 1000),
                child: Text(
                  'These are your results: ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 22,
                  color: Color.fromARGB(255, 255, 137, 58),
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.65,
                constraints: BoxConstraints(maxWidth: 1000),
                child: Text(
                  'Part 1:  '+ _part1.toString() + ' points',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 22,
                  color: Color.fromARGB(255, 255, 163, 58),
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.65,
                constraints: BoxConstraints(maxWidth: 1000),
                child: Text(
                  'Part 2:  '+ _part2.toString() + ' points',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 22,
                  color: Color.fromARGB(255, 255, 209, 58),
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.65,
                constraints: BoxConstraints(maxWidth: 1000),
                child: Text(
                  'Part 3:  '+ _part3.toString() + '.0 points',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 22,
                  color: Color.fromARGB(255, 255, 225, 58),
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.18),
              Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: size.width * 0.3,
                    height: size.height * 0.05,
                    constraints: BoxConstraints(maxWidth: 350),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: kPrimaryLightColor,
                          onPrimary: kPrimaryColor,
                        ),
                        onPressed: () async{
                           
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.remove('scalp1');
                          await prefs.remove('face2');
                          await prefs.remove('arms3');
                          await prefs.remove('hands4');
                          await prefs.remove('chest5');
                          await prefs.remove('back6');
                          await prefs.remove('genitals7');
                          await prefs.remove('thighs8');
                          await prefs.remove('legs9');
                          await prefs.remove('feets10');
                          await prefs.remove('psoriasis_today');
                          await prefs.remove('affected_today');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                          return NavBar(whichPage: 0, mini: 0);
                          },
                        ),
                      );
                    },
                        child: Text('Finish'),
                      ),
                    ),
                  ),
            ]
          ),
        ),
      ),
    );
  }
}

