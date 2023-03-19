import 'package:flutter/material.dart';

class Genre extends StatelessWidget{
  @override
  Genre({super.key});

  final List<String> models = ["assets/models/boy.png", "assets/models/girl.png"];
  final List<String> modelsSex =  ["Chico", "Chica"];
  bool isBoy = false;
  bool onTap = false;

  SizedBox chooseCharacter(){
    // This creates a grid of two characters
    // Let user choose whatever he/she identifies with

    return SizedBox(
      child: Row(
      children: [
        const Spacer(),

        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child : InkWell(
            onTap: (){
              isBoy = true;
              !onTap ? onTap = true : onTap = false;
            },
            child : SizedBox(
              width: 200,
              height: 200,
              child : Card(
                child: ColoredBox(
                  color: Colors.blueAccent,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(models[0])
                      )
                    ),
                    child: Text(modelsSex[0], style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            ),
          ),
        ),

        const Spacer(),

        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child : InkWell(
            onTap: (){
              isBoy = false;
              !onTap ? onTap = true : onTap = false;
            },
            child : SizedBox(
              width: 200,
              height: 200,
              child : Card(
                child: ColoredBox(
                  color: Colors.pinkAccent,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(models[1])
                        )
                    ),
                    child: Text(modelsSex[1], style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                  ),
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



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}