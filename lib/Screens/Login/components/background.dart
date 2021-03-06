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
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: size.width,
            height: size.height,
            alignment: Alignment.topLeft,
            child: Image.asset(
              "assets/images/main_top.png",
              width: size.width * 0.3,
              alignment: Alignment.topLeft,
            ),
          ),
          Container(
            width: size.width,
            height: size.height,
            alignment: Alignment.bottomRight,
            child: Image.asset(
              "assets/images/login_bottom.png",
              width: size.width * 0.3,
              alignment: Alignment.bottomRight,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
