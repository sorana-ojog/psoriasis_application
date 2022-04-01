// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:psoriasis_application/Screens/QuestionnaireP1/image_data.dart';
import 'package:psoriasis_application/Screens/QuestionnaireP1/geometry_and_maths.dart';
import 'package:psoriasis_application/components/bottom_navigation_bar.dart';
import 'package:psoriasis_application/components/button_title.dart';
import 'package:psoriasis_application/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/rendering.dart';

class ImageClick extends StatefulWidget {
  final String whichImage;
  const ImageClick({Key? key, required this.whichImage}) : super(key: key);

  @override
  State<ImageClick> createState() => _ImageClickState();
}

enum Intensity { low, medium, high }

class Marker extends StatelessWidget {
  final double x;
  final double y;
  final Widget child;

  Marker({this.x: 0.0, this.y: 0.0, this.child: const Text("+")});

  static Widget childFromText(String text) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.pink,
          border: Border.all(
            color: Colors.pink,
          )),
      child: Center(
          child: Text(
        text,
        style: TextStyle(fontSize: 28, color: Colors.white),
        textAlign: TextAlign.center,
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
        transform: Matrix4.translationValues(x - 16, y - 16, 0.0),
        child: child);
  }
}

// Intensity? intensity = Intensity.low;
Map<String, Intensity> zoneIntensity = {
  'scalp1': Intensity.low,
  'face2': Intensity.low,
  'arms3': Intensity.low,
  'hands4': Intensity.low,
  'chest5': Intensity.low,
  'back6': Intensity.low,
  'genitals7': Intensity.low,
  'thighs8': Intensity.low,
  'legs9': Intensity.low,
  'feets10': Intensity.low,
};

Map<String, Map<String, Marker?>> zoneMarker = {
  "back": {
    'scalp1': null,
    'face2': null,
    'arms3': null,
    'hands4': null,
    'chest5': null,
    'back6': null,
    'genitals7': null,
    'thighs8': null,
    'legs9': null,
    'feets10': null,
  },
  "front": {
    'scalp1': null,
    'face2': null,
    'arms3': null,
    'hands4': null,
    'chest5': null,
    'back6': null,
    'genitals7': null,
    'thighs8': null,
    'legs9': null,
    'feets10': null,
  }
};

Widget _buildPopupDialog(
    BuildContext context, String key, Marker marker, String image) {
  String descrText = "";
  String actualZone = "";
  switch (key) {
    //17 in total
    case 'ankles':
      descrText = "9. Lower legs and ankles";
      actualZone = 'legs9';
      break;
    case 'chest':
      descrText = "5. Chest and abdomen";
      actualZone = 'chest5';
      break;
    case 'left_arm':
      descrText = "3. Left arm and armpit";
      actualZone = 'arms3';
      break;
    case 'right_arm':
      descrText = "3. Right arm and armpit";
      actualZone = 'arms3';
      break;
    case 'left_hand':
      descrText = "4. Left hand, fingers and fingernails";
      actualZone = 'hands4';
      break;
    case 'right_hand':
      descrText = "4. Right hand, fingers and fingernails";
      actualZone = 'hands4';
      break;
    case 'genitals':
      descrText = "7. Genital area";
      actualZone = 'genitals7';
      break;
    case 'face':
      descrText = "2. Face, neck and ears";
      actualZone = 'face2';
      break;
    case 'upper_head':
      descrText = "1. Scalp and hairline";
      actualZone = 'scalp1';
      break;
    case 'left_upper_leg':
      descrText = "8. Thighs";
      actualZone = 'thighs8';
      break;
    case 'right_upper_leg':
      descrText = "8. Thighs";
      actualZone = 'thighs8';
      break;
    case 'legs':
      descrText = "9. Knees and lower legs";
      actualZone = 'legs9';
      break;
    case 'feet':
      descrText = "10. Feet, toes and toenails";
      actualZone = 'feets10';
      break;
    case 'head':
      descrText = "1. Scalp and hairline";
      actualZone = 'scalp1';
      break;
    case 'back':
      descrText = "6. Back";
      actualZone = 'back6';
      break;
    case 'thighs':
      descrText = "8. Buttocks and thighs";
      actualZone = 'thighs8';
      break;
    default:
      break;
  }
  return AlertDialog(
    // TODO: you need to prettify the key
    title: Text(descrText),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        IntensityRadioList(
          zone: actualZone,
          marker: marker,
          image: image,
        ), 
      ],
    ),
    actions: <Widget>[
      FlatButton(
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          final success = await prefs.remove(actualZone);
          zoneIntensity[actualZone] = Intensity.low;
          zoneMarker[image]?[actualZone] = null;
          print(prefs.getDouble(actualZone));
          Navigator.of(context).pop();
        },
        textColor: kPrimaryColor,
        child: const Text('Don\'t save any score'),
      ),
      FlatButton(
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          print(prefs.getDouble(actualZone));
          print(zoneIntensity[actualZone]);
          if (zoneIntensity[actualZone] == Intensity.low) {
            zoneMarker[image]?[actualZone] = Marker(
              x: marker.x,
              y: marker.y,
              child: Marker.childFromText("-"),
            );
          }
          Navigator.of(context).pop();
        },
        textColor: kPrimaryColor,
        child: const Text('Save'),
      ),
    ],
  );
}

class IntensityRadioList extends StatefulWidget {
  final String zone;
  final Marker marker;
  final String image;
  const IntensityRadioList(
      {Key? key, required this.zone, required this.marker, required this.image})
      : super(key: key);

  @override
  State<IntensityRadioList> createState() =>
      _IntensityRadioListState(zone: zone);
}

class _IntensityRadioListState extends State<IntensityRadioList> {
  String zone;
  _IntensityRadioListState({Key? key, required this.zone});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('[−]  clear or so minor that it does no bother me'),
          leading: Radio<Intensity>(
            value: Intensity.low,
            groupValue: zoneIntensity[zone],
            onChanged: (Intensity? value) async {
              final prefs = await SharedPreferences.getInstance();
              setState(() {
                zoneIntensity[zone] = value!;
                zoneMarker[widget.image]?[zone] = Marker(
                  x: widget.marker.x,
                  y: widget.marker.y,
                  child: Text("-"),
                );
              });
              await prefs.setDouble(zone, 0);
            },
          ),
        ),
        ListTile(
          title: const Text(
              '[±]  obvious but still leaving plenty of normal skin'),
          leading: Radio<Intensity>(
            value: Intensity.medium,
            groupValue: zoneIntensity[zone],
            onChanged: (Intensity? value) async {
              final prefs = await SharedPreferences.getInstance();
              setState(() {
                zoneIntensity[zone] = value!;
                zoneMarker[widget.image]?[zone] = Marker(
                  x: widget.marker.x,
                  y: widget.marker.y,
                  child: Marker.childFromText("±"),
                );
              });
              await prefs.setDouble(zone, 0.5);
            },
          ),
        ),
        ListTile(
          title: const Text(
              '[+]  widespread and involving much of the affected area'),
          leading: Radio<Intensity>(
            value: Intensity.high,
            groupValue: zoneIntensity[zone],
            onChanged: (Intensity? value) async {
              final prefs = await SharedPreferences.getInstance();
              setState(() {
                zoneIntensity[zone] = value!;
                zoneMarker[widget.image]?[zone] = Marker(
                    x: widget.marker.x,
                    y: widget.marker.y,
                    child: Marker.childFromText("+"));
              });
              await prefs.setDouble(zone, 1);
            },
          ),
        ),
      ],
    );
  }
}

class _ImageClickState extends State<ImageClick> {
  List<Point> points = [];
  List<Marker> markers = [];

  double computeWidth(double oh, double ow, double h) {
    return (ow * h) /
        oh; // computes the actual height of the image using the original size and the current height
  }

  Point normalizePoint(double maxH, double maxW, Point p) {
    // transforms a point from (0, maxSize) to (0, 1) coordinates

    double x = p.x / maxW;
    double y = p.y / maxH;

    return Point(x, y);
  }

  // normalized point, normalized image width, normalized screen width
  bool pointOnImageWidth(Point np, double niw, double nsw) {
    return np.x <= (niw + nsw) / 2 &&
        np.x >= (nsw - niw) / 2; // the image is centered
  }

  double widthOffest(double niw, double nsw) {
    return (nsw - niw) /
        2; // the whitespace between the image and the left part of the screen
  }

  @override
  Widget build(BuildContext context) {
    IImagePoly imageData;
    if (this.widget.whichImage == "front") {
      imageData = FrontImage();
    } else {
      imageData = BackImage();
    }

    final originalImageHeight = imageData.getOriginalImageHeight();
    final originalImageWidth = imageData.getOriginalImageWidth();
    final zones = imageData.getZones();
    final imagePath = imageData.getImagePath();

    Size size = MediaQuery.of(context).size;
    double realHeight = size.height * 0.8;
    final double realWidth =
        computeWidth(originalImageHeight, originalImageWidth, realHeight);

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
        body: Center(
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                child: Column(children: <Widget>[
                  SizedBox(height: size.height * 0.03),
                  Text(
                    'PART 1A',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: size.width * 0.85,
                    constraints: BoxConstraints(maxWidth: 1000),
                    child: Text(
                      'For each of your body areas that are affected by psoriasis, please press on them on the interactive photo below and select how much that area is affected today*. There will be two separate photos (front and back) and you will see both of them as you progress through the questionnaire.',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: size.width * 0.85,
                    constraints: BoxConstraints(maxWidth: 1000),
                    child: Text(
                      '  * even if the skin of the hands or feet is unaffected you can score ± for severe psoriasis of at least 2 and + for 6 or more fingers/toenails',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ]),
              ),
              SizedBox(height: size.height * 0.035),
              GestureDetector(
                  onTap: () {},
                  onTapDown: (TapDownDetails details) {
                    Point normalizedPoint = normalizePoint(
                        realHeight,
                        realWidth,
                        Point(details.localPosition.dx,
                            details.localPosition.dy));

                    double normalizedScreenWidth = normalizePoint(
                            realHeight, realWidth, Point(size.width, 0))
                        .x;

                    double woffset = widthOffest(1, normalizedScreenWidth);
                    print(details.localPosition.dx.toString());
                    print(details.localPosition.dy.toString());
                    for (final key in zones.keys) {
                      final polygon = zones[key];
                      if (polygon != null) {
                        if (polygon.inArea(Point(normalizedPoint.x - woffset,
                                normalizedPoint.y)) ==
                            true) {
                          showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      _buildPopupDialog(
                                          context,
                                          key,
                                          Marker(
                                              x: normalizedPoint.x - woffset,
                                              y: normalizedPoint.y),
                                          widget.whichImage))
                              .then((_) => setState(() {}));
                        }
                      }
                    }

                    points.add(
                        Point(normalizedPoint.x - woffset, normalizedPoint.y));

                    setState(() {
                      markers.add(Marker(
                          x: normalizedPoint.x - woffset,
                          y: normalizedPoint.y));
                    });
                  },
                  child: Container(
                      alignment: Alignment.center,
                      width: size.width,
                      height: realHeight,
                      child: Stack(children: [
                        ...((zoneMarker[widget.whichImage]?.values.map((e) {
                              if (e == null) {
                                return Text("");
                              }
                              return Marker(
                                x: e.x * realWidth,
                                y: e.y * realHeight,
                                child: e.child,
                              );
                            })) ??
                            [Text("hello")]),
                        Image.asset(
                          imagePath,
                          height: realHeight,
                        ),
                      ]))),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width * 0.90,
                constraints: BoxConstraints(maxWidth: 1000),
                child: Row(
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
                                  if (this.widget.whichImage == "front") {
                                    return NavBar(whichPage: 0, mini: 1);
                                  } else {
                                    return NavBar(whichPage: 1, mini: 1);
                                  }
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
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  if (this.widget.whichImage == "front") {
                                    return NavBar(whichPage: 2, mini: 1);
                                  } else {
                                    zoneIntensity = {
                                      'scalp1': Intensity.low,
                                      'face2': Intensity.low,
                                      'arms3': Intensity.low,
                                      'hands4': Intensity.low,
                                      'chest5': Intensity.low,
                                      'back6': Intensity.low,
                                      'genitals7': Intensity.low,
                                      'thighs8': Intensity.low,
                                      'legs9': Intensity.low,
                                      'feets10': Intensity.low,
                                    };
                                    zoneMarker = {
                                      "back": {
                                        'scalp1': null,
                                        'face2': null,
                                        'arms3': null,
                                        'hands4': null,
                                        'chest5': null,
                                        'back6': null,
                                        'genitals7': null,
                                        'thighs8': null,
                                        'legs9': null,
                                        'feets10': null,
                                      },
                                      "front": {
                                        'scalp1': null,
                                        'face2': null,
                                        'arms3': null,
                                        'hands4': null,
                                        'chest5': null,
                                        'back6': null,
                                        'genitals7': null,
                                        'thighs8': null,
                                        'legs9': null,
                                        'feets10': null,
                                      }
                                    };
                                    return NavBar(whichPage: 3, mini: 1);
                                  }
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
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ));
  }
}
