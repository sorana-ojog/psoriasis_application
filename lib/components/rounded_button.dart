import 'package:flutter/material.dart';
import 'package:psoriasis_application/constants.dart';


class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color;
  const RoundedButton({
    Key? key, 
    required this.text, 
    required this.press, 
    this.color = kPrimaryColor,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.5,
      height: size.height * 0.05,
      constraints: BoxConstraints(maxWidth: 350),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
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