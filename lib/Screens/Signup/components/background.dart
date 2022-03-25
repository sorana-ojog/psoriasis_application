import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      //or size.width
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: size.width,
            height: size.height,
            alignment: Alignment.topLeft,
            child: Image.asset(
              "assets/images/signup_top.png",
              width: size.width * 0.3,
              alignment: Alignment.topLeft,
            ),
          ),
          Container(
            width: size.width,
            height: size.height,
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              "assets/images/main_bottom.png",
              width: size.width * 0.3,
              alignment: Alignment.bottomLeft,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
