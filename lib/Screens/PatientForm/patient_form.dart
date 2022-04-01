import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:psoriasis_application/constants.dart';

class PatientForm extends StatefulWidget {
  final uid;
  final date;
  const PatientForm({Key? key, required this.uid, required this.date}) : super(key: key);
  @override
  _AppState createState() => _AppState();
}
int _selectedIndex = 1;
String patient_name = "";
String title = "";
List<String> patientData = [];
var part1;
var part1b;
var part2;
var part3;
var p3_10years;
var p3_20years;
var p3_bright_red;
var p3_rheumatologist;
var p3_ultraviolet;
var p3_number_of_tablets;
var p3_which_tablets;
var scalp1;
var face2;
var arms3;
var hands4;
var chest5;
var back6;
var genitals7;
var thighs8;
var legs9;
var feets10;
var which_tablets;
class _AppState extends State<PatientForm> {
  int finish = 0;
  Future<List<String>> data() async{
    CollectionReference ref1 = await FirebaseFirestore.instance.collection('users');
    await ref1
        .where("user_ID", isEqualTo: widget.uid)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        title = result["title"];
        patient_name = result["first_name"];
        patient_name = patient_name + " " + result["last_name"];
      });
    });
    CollectionReference ref = await FirebaseFirestore.instance.collection('form');
    await ref
        .where("user_ID", isEqualTo: widget.uid)
        .where("date_time", isEqualTo: widget.date)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        part1 = result["part1"];
        part1b = result["part1b"];
        part2 = result["part2"];
        part3 = result["part3"];
        p3_10years = result["p3_10years"];
        p3_20years = result["p3_20years"];
        p3_bright_red = result["p3_bright_red"];
        p3_rheumatologist = result["p3_rheumatologist"];
        p3_ultraviolet = result["p3_ultraviolet"];
        p3_number_of_tablets = result["p3_number_of_tablets"];
        p3_which_tablets = result["p3_which_tablets"];
        scalp1 = result["scalp1"];
        face2 = result["face2"];
        arms3 = result["arms3"];
        hands4 = result["hands4"];
        chest5 = result["chest5"];
        back6 = result["back6"];
        genitals7 = result["genitals7"];
        thighs8 = result["thighs8"];
        legs9 = result["legs9"];
        feets10 = result["feets10"];
      });
    });
    if(p3_which_tablets.toString() == "[]"){
      which_tablets = 0;
    }
    else{
      which_tablets = p3_which_tablets;
    }
    finish = 1;
    return patientData;
  }
 
  @override
  Widget build(BuildContext context) {
    final Future<List<String>> patient_data = data();
    var mydate = widget.date;
    var splitDate = mydate.split(" ");
    var splitDate2 = splitDate[0].split("/");
    mydate = splitDate2[2]+ "/" + splitDate2[1] +"/"+ splitDate2[0];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Pacient Forms'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: FutureBuilder<List<String>>(
        future: patient_data, // a previously-obtained Future<List<String>> or null
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
      List<Widget> children;
          if (snapshot.hasData && snapshot.data != [] && finish != 0) {
            children = <Widget>[
              SizedBox(height: size.height * 0.04),
              Container(
              alignment: Alignment.center,
              width: size.width * 0.85,
              constraints: BoxConstraints(maxWidth: 1000),
              child: RichText(
                text:TextSpan(
                  text: "",
                  style: TextStyle( fontSize: 17),
                  children: <TextSpan>[
                    TextSpan(text: "This is the form ", style: TextStyle( color: Colors.black)),
                    TextSpan(text: "$title $patient_name", style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryColor)),
                    TextSpan(text: " completed on ", style: TextStyle( color: Colors.black)),
                    TextSpan(text: "$mydate", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                    TextSpan(text: ".", style: TextStyle( color: Colors.black)),
                  ],
                )
              ),
            ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.85,
                constraints: BoxConstraints(maxWidth: 1000),
                child: Text(
                  'Part 1',
                  style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  ),
                ),
              ),
              Container(  
                margin: EdgeInsets.all(10),  
                constraints:BoxConstraints(maxWidth: 1000),
                child: Table(  
                  defaultColumnWidth: FlexColumnWidth(size.width * 0.75),  
                  border: TableBorder.all(  
                    color: Colors.black,  
                    style: BorderStyle.solid,  
                    width: 2),  
                  children: [  
                    TableRow( children: [  
                      Column(children:[Text(' Questionnaire Question', style: TextStyle(fontSize: 20.0))]),  
                      Column(children:[Text('Completed ', style: TextStyle(fontSize: 20.0))]),
                    ]), 
                    TableRow( children: [  
                      Column(children:[Text(' Results', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(part1.toString(), style: TextStyle(fontSize: 17.0))]),  
                    ]),
                    TableRow( children: [  
                      Column(children:[Text(' Overall state of my psoriasis', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(part1b.toString(), style: TextStyle(fontSize: 17.0))]),  
                    ]),    
                    TableRow( children: [  
                      Column(children:[Text(' Scalp and hairline' , style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(scalp1.toString(), style: TextStyle(fontSize: 17.0))]),   
                    ]),  
                    TableRow( children: [  
                      Column(children:[Text(' Face, neck and ears', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(face2.toString(), style: TextStyle(fontSize: 17.0))]),  
                    ]),  
                    TableRow( children: [  
                      Column(children:[Text(' Right arm and armpit', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(arms3.toString(), style: TextStyle(fontSize: 17.0))]),  
                    ]),  
                    TableRow( children: [  
                      Column(children:[Text(' Left hand, fingers and fingernails', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(hands4.toString(), style: TextStyle(fontSize: 17.0))]),  
                    ]), 
                    TableRow( children: [  
                      Column(children:[Text(' Chest and abdomen', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(chest5.toString(), style: TextStyle(fontSize: 17.0))]),  
                    ]), 
                    TableRow( children: [  
                      Column(children:[Text(' Back', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(back6.toString(), style: TextStyle(fontSize: 17.0))]),  
                    ]), 
                    TableRow( children: [  
                      Column(children:[Text(' Genital area', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(genitals7.toString(), style: TextStyle(fontSize: 17.0))]),  
                    ]), 
                    TableRow( children: [  
                      Column(children:[Text(' Thighs', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(thighs8.toString(), style: TextStyle(fontSize: 17.0))]),  
                    ]), 
                    TableRow( children: [  
                      Column(children:[Text(' Knees and lower legs', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(legs9.toString(), style: TextStyle(fontSize: 17.0))]),  
                    ]), 
                    TableRow( children: [  
                      Column(children:[Text(' Feet, toes and toenails', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(feets10.toString(), style: TextStyle(fontSize: 17.0))]),  
                    ]),
                  ],  
                ),  
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.85,
                constraints: BoxConstraints(maxWidth: 1000),
                child: Text(
                  'Part 2',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  fontSize: 20,
                    ),
                  ),
                ),
              Container(  
                margin: EdgeInsets.all(10),  
                constraints:BoxConstraints(maxWidth: 1000),
                child: Table(  
                  defaultColumnWidth: FlexColumnWidth(size.width * 0.75),  
                  border: TableBorder.all(  
                    color: Colors.black,  
                    style: BorderStyle.solid,  
                    width: 2),  
                  children: [  
                    TableRow( children: [  
                      Column(children:[Text(' Questionnaire Question', style: TextStyle(fontSize: 20.0))]),  
                      Column(children:[Text('Completed ', style: TextStyle(fontSize: 20.0))]),
                    ]),  
                    TableRow( children: [  
                      Column(children:[Text(' Results', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(part2.toString(), style: TextStyle(fontSize: 17.0))]),   
                    ]),
                    TableRow( children: [  
                      Column(children:[Text(' How much my psoriasis was affecting me', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(part2.toString(), style: TextStyle(fontSize: 17.0))]),   
                    ]),
                  ],  
                ),  
              ),    
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.85,
                constraints: BoxConstraints(maxWidth: 1000),
                child: Text(
                  'Part 3',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Container(  
                margin: EdgeInsets.all(10),  
                constraints:BoxConstraints(maxWidth: 1000),
                child: Table(  
                  defaultColumnWidth: FlexColumnWidth(size.width * 0.75),  
                  border: TableBorder.all(  
                    color: Colors.black,  
                    style: BorderStyle.solid,  
                    width: 2),  
                  children: [  
                    TableRow( children: [  
                      Column(children:[Text(' Questionnaire Question', style: TextStyle(fontSize: 20.0))]),  
                      Column(children:[Text('Completed ', style: TextStyle(fontSize: 20.0))]),
                    ]),  
                    TableRow( children: [  
                      Column(children:[Text(' Results', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(part3.toString(), style: TextStyle(fontSize: 17.0))]),   
                    ]),
                    TableRow( children: [  
                      Column(children:[Text(' I have had psoriasis for at least 10 years.', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(p3_10years.toString(), style: TextStyle(fontSize: 17.0))]),   
                    ]),
                    TableRow( children: [  
                      Column(children:[Text(' My psoriasis first developed before I was 10 years old and/or has been present for more than 20 years.', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(p3_20years.toString(), style: TextStyle(fontSize: 17.0))]),   
                    ]),
                    TableRow( children: [  
                      Column(children:[Text(' I have had bright red and very inflamed psoriasis covering all my skin.', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(p3_bright_red.toString(), style: TextStyle(fontSize: 17.0))]),   
                    ]),
                    TableRow( children: [  
                      Column(children:[Text(' A rheuumatologist has confirmed that I have psoriatic arthrtis.', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(p3_rheumatologist.toString(), style: TextStyle(fontSize: 17.0))]),   
                    ]),
                    TableRow( children: [  
                      Column(children:[Text(' Ultraviolet light treatment', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(p3_ultraviolet.toString(), style: TextStyle(fontSize: 17.0))]),   
                    ]),
                    TableRow( children: [  
                      Column(children:[Text(' The number of my psoriasis tablets and/or injections', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(p3_number_of_tablets.toString(), style: TextStyle(fontSize: 17.0))]),   
                    ]),
                    TableRow( children: [  
                      Column(children:[Text(' My psoriasis tablets and/or injections', style: TextStyle(fontSize: 17.0))]),  
                      Column(children:[Text(which_tablets.toString(), style: TextStyle(fontSize: 17.0))]),   
                    ]),
                    
                  ],  
                ),  
              ), 
              SizedBox(height: size.height * 0.02),
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Loading Data...'),
              )
            ];
          }
       return Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child:Column(
          children: children,
          ),
        ),
      );}),
    );
  }
}