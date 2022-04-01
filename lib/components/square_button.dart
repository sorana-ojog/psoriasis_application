import 'package:flutter/material.dart';
import 'package:psoriasis_application/constants.dart';


class SquareButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color;
  const SquareButton({
    Key? key, 
    required this.text, 
    required this.press, 
    this.color = kPrimaryLightColor2,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      width: size.width * 0.80,
      height: size.height * 0.05,
      constraints: BoxConstraints(maxWidth: 800),
      child: ClipRRect(
        // borderRadius: BorderRadius.circular(25),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: color,
          ),
          onPressed: press,
          child: Text(text),
        ),
      ),
    );
  }
}