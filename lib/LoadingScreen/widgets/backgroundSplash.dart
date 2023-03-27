import 'package:flutter/material.dart';

class BackgroundSplash extends StatelessWidget{
  @override
  Widget build(BuildContext context){

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color : Colors.black,
    );
  }
}