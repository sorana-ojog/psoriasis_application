import 'package:flutter/material.dart';

class DescriptionText extends StatelessWidget {
  final String titleText;
  final String text;
  final double titleSize;
  DescriptionText({
    Key? key, 
    required this.titleText, 
    required this.text, 
    required this.titleSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.centerLeft,
        width: size.width * 0.9,
        constraints: BoxConstraints(maxWidth: 1000),
        child: RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                text: titleText + '\n', 
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: titleSize,
                )
              ),
              TextSpan(
                text: text, 
                style: TextStyle(
                  fontSize: 15,
                )
              ),
            ],
          ),
        ),
    );
  }
}