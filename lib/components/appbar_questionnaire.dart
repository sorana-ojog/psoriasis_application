// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/diagnostics.dart';
// import 'package:psoriasis_application/Screens/QuestionnaireP1/questionnaire_page1.dart';
// import 'package:psoriasis_application/constants.dart';
// import 'package:psoriasis_application/components/button_title.dart';

// class AppBarTitle extends PreferredSizeWidget {


//   @override
//   PreferredSizeWidget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return AppBar(
//         automaticallyImplyLeading: false,
//         title: Container(
//           alignment: Alignment.center,
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: <Widget>[
//                 // for (int i in [1,2,3,4,5])
//                 ButtonTitle(
//                 page: QuestionnaireP1(),
//                 text: 'Part 1A (front)',
//                 ),
//                 SizedBox(width: size.width * 0.015),
//                 ButtonTitle(
//                   page: QuestionnaireP1(),
//                   text: 'Part 1A (back)',
//                   ),
//                 SizedBox(width: size.width * 0.015),
//                 ButtonTitle(
//                   page: QuestionnaireP1(),
//                   text: 'Part 1B',
//                   ),
//                 SizedBox(width: size.width * 0.015),
//                 ButtonTitle(
//                   page: QuestionnaireP1(),
//                   text: 'Part 2',
//                   ),
//                 SizedBox(width: size.width * 0.015),
//                 ButtonTitle(
//                   page: QuestionnaireP1(),
//                   text: 'Part 3',
//                   ),
//                 SizedBox(width: size.width * 0.015),
//               ],
//             ),
//           ),
//         ),
//         backgroundColor: kPrimaryColor,
//     );
//   }

//   @override
//   Element createElement() {
//     // TODO: implement createElement
//     throw UnimplementedError();
//   }

// }