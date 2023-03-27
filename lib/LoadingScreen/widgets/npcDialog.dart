import 'package:flutter/material.dart';

class NpcDialog extends StatelessWidget{

  NpcDialog({
    required this.message,
    required this.npc,
});

  final String message;
  final String npc;

  @override
  Widget build(BuildContext context){
    return SizedBox(
      width: double.maxFinite,
      height: 500 ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Centered icon
          SafeArea(child: NpcPortrait(npc : npc)),

          // Centered Dialog
          NpcDialogField(message: message),
        ],
      ) ,
    );
  }
}

class NpcDialogField extends StatelessWidget{

  NpcDialogField({
    required this.message,
});

  final String message;
  @override
  Widget build(BuildContext context){

    final width = MediaQuery.of(context).size.width;

    return Container(
      width: double.maxFinite,
      height: 125,
      margin: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Expanded(
            child : ListView(
            children: [
              DefaultTextStyle(
                  style: TextStyle(color: Colors.black, fontSize: 25,),
                  child: Text(message, textAlign: TextAlign.center,),)

            ],
            )
          ),
        ],
      ),
    );
  }
}

class NpcPortrait extends StatelessWidget{

  NpcPortrait({
    required this.npc,
});

  final String npc;

  @override
  Widget build(BuildContext context){

    final width = MediaQuery.of(context).size.width;

    return Container(
      width: 150,
      height: 150,
      margin: EdgeInsets.only(top: 50, bottom: 25, left: width * 0.2, right: width * 0.2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        gradient: LinearGradient (
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          colors: [Colors.black, Colors.yellowAccent]
        ),
        image: DecorationImage(
          image: AssetImage(npc),
          fit: BoxFit.fill
        )
      ),
    );
  }
}