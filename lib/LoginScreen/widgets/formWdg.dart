import 'package:animal_crossing_radio/Control/control.dart';
import 'package:flutter/material.dart';

class FormWdg extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size;
    return Container(
      width: 400,
      height: 400,
      margin: EdgeInsets.only(top: size.height *  0.3, left: 20, right: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.5,
            blurRadius: 7,
            offset: Offset(0,3),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          // Banner
          Column(
          children : [
            // Banner
            const SizedBox(height: 20,),
            FormBanner(),
            const SizedBox(height: 40,),

            // Fields
            FormFields(),
            const SizedBox(height: 20,),

            // Button
            FormNavBarButton(),
            const SizedBox(height: 20,),

            ],
          ),
        ],
      ),
    );
  }
}

class FormBanner extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Row(
      children: [
        const Spacer(),
        const DefaultTextStyle(
          style: TextStyle(color: Colors.grey, fontSize: 35, fontWeight: FontWeight.bold),
          child : Text("Iniciar Sesión",)),
        const Spacer(),
      ],
    );
  }
}

class FormFields extends StatelessWidget with Control{

  TextEditingController name = TextEditingController(text: "");
  TextEditingController password = TextEditingController(text: "");

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Row(
          children: [
            // Name Text Field
            const SizedBox(width: 15,),
            SizedBox(
              width: 360,
              height: 100,
              child: TextField(
                controller: name,
                textAlign: TextAlign.left,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  icon: Icon(Icons.face_rounded, color: Colors.blue,),
                  hintText: "Introduce un nombre",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ) ,
            ),
            const SizedBox(width: 15,)
          ],
        ),

        Row(
          children: [
            // Password Text Field
            const SizedBox(width: 15,),
            SizedBox(
              width: 360,
              height: 100,
              child: TextField(
                controller: password,
                textAlign: TextAlign.left,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  hintText: "Introduce una contraseña",
                  alignLabelWithHint: true,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                  icon: Icon(Icons.lock_rounded)
                ),
              ),
            ),
            const SizedBox(width: 15,),
          ],
        )

      ],
    );
  }
}

class FormNavBarButton extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Row(
      children: [
        const SizedBox(width: 95,),
        SizedBox(
          width: 200,
          height: 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
              child : TextButton(
              onPressed : (){
                // TO-DO
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              child: Text("Comprobar", style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.center,),
           ),
          ),
        ),
        const SizedBox(width: 95,),
      ],
    );
  }
}