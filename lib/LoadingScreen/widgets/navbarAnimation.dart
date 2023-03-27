import 'package:flutter/material.dart';

class NavbarAnimation extends StatelessWidget{

  final String currentAnim = "assets/animation/animation.gif";

  @override
  Widget build(BuildContext context){

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(top: height * 0.8, left: width * 0.6),
      width: width * 0.4,
      height: height * 0.4,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(currentAnim),
          fit: BoxFit.fitHeight
        )
      ),
    );
  }
}