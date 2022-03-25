import 'dart:developer';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:psoriasis_application/Screens/QuestionnaireP1/questionnaire_page1.dart';
import 'package:psoriasis_application/Screens/QuestionnaireP2/questionnaire_page2.dart';
import 'package:psoriasis_application/Screens/QuestionnaireP3/questionnaire_page3.dart';
import 'package:psoriasis_application/Screens/Signup/components/body.dart';
import 'package:psoriasis_application/components/button_title.dart';
import 'package:psoriasis_application/constants.dart';

import '../QuestionnaireP4/questionnaire_page4.dart';

class ImageClick extends StatefulWidget {
  const ImageClick({Key? key}) : super(key: key);

  @override
  State<ImageClick> createState() => _ImageClickState();
}

class Point {
  double x; // between 0 and 1
  double y;
  Point(this.x, this.y);

  @override
  String toString() {
    return "{" + x.toString() + ", " + y.toString() + "}";
  }
}

class LineParams {
  double a;
  double b;
  double c;
  LineParams(this.a, this.b, this.c);
}

class Polygon {
  List<Point> points;
  Polygon(this.points);

  bool inArea(Point x) {
    final lines = [
      for (int i = 0; i < points.length - 1; i++) [points[i], points[i + 1]]
    ];

    int intersectionsCount = 0;

    for (var line in lines) {
      if (linesIntersect(x, Point(99999, x.y), line[0], line[1])) {
        intersectionsCount += 1;
        print(line);
      }
    }
    print(intersectionsCount);
    return intersectionsCount % 2 == 1;
  }

  double determinant(LineParams l1, LineParams l2) {
    return l1.a * l2.b - l2.a * l1.b;
  }

  LineParams computeLineParams(Point a, Point b) {
    double A = b.y - a.y; // y2 - y1
    double B = a.x - b.x; // x1 - x2
    double C = A * a.x + B * a.y;
    return LineParams(A, B, C);
  }

  bool linesIntersect(Point a1, Point b1, Point a2, Point b2) {
    // check if the lines [a,b] and [x,y] intersect

    LineParams l1 = computeLineParams(a1, b1);
    LineParams l2 = computeLineParams(a2, b2);

    double eps = 0.0001;

    double det = determinant(l1, l2);

    if (det == 0) {
      return false; // the lines are paralel
    } else {
      double x = (l2.b * l1.c - l1.b * l2.c) / det;
      double y = (l1.a * l2.c - l2.a * l1.c) / det;
      // intersection point of line

      // print("Point");
      // print(x);
      // print(y);
      return min(a1.x, b1.x) <= x + eps &&
          min(a2.x, b2.x) <= x + eps &&
          max(a2.x, b2.x) >= x - eps &&
          max(a1.x, b1.x) >= x - eps &&
          min(a1.y, b1.y) <= y + eps &&
          min(a2.y, b2.y) <= y + eps &&
          max(a2.y, b2.y) >= y - eps &&
          max(a1.y, b1.y) >= y - eps; // checks if point on both segments
    }
  }
}

class _ImageClickState extends State<ImageClick> {
  int clickedA = 0;
  int clickedB = 0;
  int clickedC = 0;

  double originalImageHeight = 988;
  double originalImageWidth = 514;

  List<Point> points = [];

  Map<String, int> zones_counter= {
    "chest": 0,
    "left_hand": 0,
  };

  Map<String, Polygon> zones = {
    "chest": Polygon([
      Point(0.33479221950442284, 0.1750790120374264),
      Point(0.353460880256109, 0.2493889297729184),
      Point(0.3783813715851039, 0.34144780934608915),
      Point(0.2856616721393086, 0.4780803195962994),
      Point(0.3948082143014926, 0.46936189155803193),
      Point(0.49202733726883574, 0.5036278188078217),
      Point(0.5978821959073608, 0.4769468828847771),
      Point(0.7141804533511631, 0.49986612305508826),
      Point(0.630128064478455, 0.3530942822224558),
      Point(0.676353720868254, 0.24862098533431454),
      Point(0.6673706612761106, 0.16701354210470984),
      Point(0.33255829519460156, 0.17306264455424725),
    ]),
    "left_hand": Polygon([
      Point(0.3023788535035107, 0.18520846225247523),
      Point(0.27602239776962867, 0.2067641456528465),
      Point(0.2628615937385629, 0.2445575978496287),
      Point(0.25150125274793417, 0.30142906868811875),
      Point(0.2151551311122723, 0.3450661838644801),
      Point(0.16525326516570682, 0.42005482286509893),
      Point(0.1336696586692656, 0.45431307046720293),
      Point(0.1833624385853287, 0.47115514774133654),
      Point(0.27143412098916, 0.3871804416769801),
      Point(0.3103473544437676, 0.35073459738551976),
      Point(0.3284332960822226, 0.29379060952970293),
      Point(0.35442965920801717, 0.2574474976794554),
      Point(0.354801367706688, 0.1993069790377475),
      Point(0.3321155333971809, 0.17351509320853958),
      Point(0.30610755438080295, 0.18497882503094057),
    ])
  };

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
    Size size = MediaQuery.of(context).size;
    double realHeight = size.height * 0.8;
    double width = size.width;
    double height = size.height;
    // final Future<int?> counter = preference();
    // print('alsoooo');
    // print(_counter);
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
                page: QuestionnaireP1(),
                text: 'Part 1A (front)',
                ),
                SizedBox(width: size.width * 0.015),
                ButtonTitle(
                  page: QuestionnaireP1(),
                  text: 'Part 1A (back)',
                  ),
                SizedBox(width: size.width * 0.015),
                ButtonTitle(
                  page: QuestionnaireP2(),
                  text: 'Part 1B',
                  ),
                SizedBox(width: size.width * 0.015),
                ButtonTitle(
                  page: QuestionnaireP3(),
                  text: 'Part 2',
                  ),
                SizedBox(width: size.width * 0.015),
                ButtonTitle(
                  page: QuestionnaireP4(),
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
              GestureDetector(
                  onTap: () {},
                  onTapDown: (TapDownDetails details) {
                    double realWidth = computeWidth(
                        originalImageHeight, originalImageWidth, realHeight);

                    Point normalizedPoint = normalizePoint(
                        realHeight,
                        realWidth,
                        Point(details.localPosition.dx,
                            details.localPosition.dy));

                    double normalizedScreenWidth = normalizePoint(
                            realHeight, realWidth, Point(size.width, 0))
                        .x;

                    double woffset = widthOffest(1, normalizedScreenWidth);

                    print(zones["left_hand"]?.inArea(
                        Point(normalizedPoint.x - woffset, normalizedPoint.y)));

                    // List<String> bp = ["left_hand", "chest"];
                    // for (var part in bp) {
                    //   if (zones[part]?.inArea(Point(normalizedPoint.x - woffset,
                    //           normalizedPoint.y)) ==
                    //       true) {
                    //     if (zones_counter[part] != null) {
                    //       zones_counter[part] += 1;
                    //     }
                    //   }
                    // }

                    points.add(
                        Point(normalizedPoint.x - woffset, normalizedPoint.y));
                    print("[");
                    for (var p in points) {
                      print("Point(${(p.x.toString())},${p.y.toString()}),");
                    }
                    print("]");
                  },
                  child: Image.asset(
                    'assets/images/front_body_crop.png',
                    height: realHeight,
                  )),
              Text("write something")
            ],
          ),
        ));
  }
}