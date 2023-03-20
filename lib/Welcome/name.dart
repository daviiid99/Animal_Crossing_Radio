import 'package:flutter/material.dart';

class Name extends StatelessWidget{
  @override
  Name({super.key});

  bool nameAsked = false;
  TextEditingController name = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return SizedBox(

        child : Row(
          children: [
            const Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child : SizedBox(
                width: 350,
                child : InkWell(
                  child : TextField(
                    style: const TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    controller: name,
                    decoration: const InputDecoration(
                        hintMaxLines: 1,
                        hintText: "Introduce un nombre",
                        hintStyle: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
                        filled: true,
                        fillColor: Colors.white
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        )
    );
  }
}

