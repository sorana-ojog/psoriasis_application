import 'package:flutter/material.dart';
import 'package:psoriasis_application/constants.dart';

class ButtonTitle extends StatelessWidget {
  final String text;
  final Widget page;
  ButtonTitle({
    Key? key, 
    required this.text, 
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
      primary: kPrimaryLightColor, 
      onPrimary: kPrimaryColor
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
            return page;
            },
          ),
        );
      },
      child: Text(text),
    );
  }
}