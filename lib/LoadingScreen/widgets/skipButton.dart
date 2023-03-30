import 'package:animal_crossing_radio/LoginScreen/loginScreen.dart';
import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget{
  @override
  Widget build(BuildContext context){

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      height: height * 0.05,
      width: width * 0.5,
      margin: EdgeInsets.only(top: height * 0.90, bottom: height * 0.05, left: width * 0.1, right: width * 0.5 ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.blueAccent,
      ),
      child: InkWell(
        onTap : (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    },
        child : Column(
          children  : [
            const Spacer(),
            Row(
              children: const [
                Spacer(),
                DefaultTextStyle(
                style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                child: Text("Saltar",),
                textAlign: TextAlign.center,
               ),
                Spacer(),
              ],
            ),
            const Spacer(),
          ],
        )
      )
    );
  }
}