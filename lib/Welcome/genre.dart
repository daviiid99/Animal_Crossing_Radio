import 'package:flutter/material.dart';
import '../Control/control.dart';

class Genre extends StatelessWidget with Control{
  @override
  Genre({super.key});

  final List<String> models = ["assets/models/boy.png", "assets/models/girl.png"];
  final List<String> modelsSex =  ["Chico", "Chica"];
  bool isBoy = false;
  bool onTap = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Row(
          children: [
            const Spacer(),

            Stack(
              children  : [


                if (isBoy && onTap)
                  ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child : Container(
                        width: 210,
                        height: 210,
                        color: Colors.white,
                      )
                  ),
                Column(
                  children: [
                    const SizedBox(height: 5,),
                    Row(
                      children: [
                        const SizedBox(width: 5,),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child : InkWell(
                            onTap: (){
                              isBoy = true;
                              if (!onTap)  onTap = true;
                              hotReload(context);
                            },
                            child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  image: DecorationImage(
                                      image: AssetImage(models[0])
                                  )
                              ),
                              child: Text(modelsSex[0], style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5,),
                      ],
                    ),

                    const SizedBox(height: 5,),
                  ],
                )


              ],
            ),

            const Spacer(),

            Stack(
              children  : [

                if (!isBoy && onTap)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child : Container(
                    width: 210,
                    height: 210,
                    color: Colors.white,
                  )
                  ),
                Column(
                  children: [
                    const SizedBox(height: 5,),
                    Row(
                      children: [
                        const SizedBox(width: 5,),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child : InkWell(
                            onTap: (){
                              isBoy = false;
                              if (!onTap)  onTap = true;
                              hotReload(context);
                            },
                            child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                  color: Colors.pinkAccent,
                                  image: DecorationImage(
                                      image: AssetImage(models[1])
                                  )
                              ),
                              child: Text(modelsSex[1], style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5,),
                      ],
                    ),

                    const SizedBox(height: 5,),
                  ],
                )


              ],
            ),
            const Spacer(),
          ],
        )
    );
  }

}