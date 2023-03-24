import 'package:flutter/material.dart';

class BannerWdg extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.transparent,
      width: double.maxFinite,
      height: 100,
      margin: EdgeInsets.only(bottom: 100, top: 100),
      child: Row(
        children: [
          const Spacer(),
          Image.asset("assets/models/boy_white.png", width: 100, height: 100,),
          const Spacer(),
        ],
      ),
    );
  }
}