import 'package:flutter/material.dart';

class ActionsContainer extends StatelessWidget{
  @override
  Widget build(BuildContext context){

    final height = MediaQuery.of(context).size.height ;
    final width = MediaQuery.of(context).size.width ;

    return Container(
      width: double.maxFinite,
      height: height * 0.2,
      margin: EdgeInsets.only(left: width * 0.1, right: width * 0.1, top: height * 0.7, bottom: height * 0.1),
      decoration: BoxDecoration(
        color: Colors.orangeAccent.withOpacity(0.9),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              const Spacer(),
              Container(
                width: width * 0.2,
                height: height * 0.1 ,
                margin: EdgeInsets.only(top: height * 0.05, bottom: height * 0.05 ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(height * 0.1)
                ),
              ),
              const Spacer(),
              Container(
                width: width * 0.2,
                height: height * 0.1 ,
                margin: EdgeInsets.only(top: height * 0.05, bottom: height * 0.05 ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(height * 0.1)
                ),
              ),
              const Spacer(),
              Container(
                width: width * 0.2,
                height: height * 0.1 ,
                margin: EdgeInsets.only(top: height * 0.05, bottom: height * 0.05 ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(height * 0.1)
                ),
              ),
              const Spacer(),
            ],
          ),
        ],
      )
    );
  }
}