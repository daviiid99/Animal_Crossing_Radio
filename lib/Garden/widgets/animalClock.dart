import 'package:flutter/material.dart';

class AnimalClock extends StatelessWidget{
  @override
  Widget build(BuildContext context){

    final height =  MediaQuery.of(context).size.height;
    final width  = MediaQuery.of(context).size.width;

    return Container(
      width: width * 0.4 ,
      height: height * 0.1,
      margin: const EdgeInsets.only(top: 5, left: 5),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/res/clock_model.png"),
          fit: BoxFit.fill
        )
      ),
      child: Column(
        children: [
          // Row 1

          // Row 2
        ],
      ),
    );
  }
}