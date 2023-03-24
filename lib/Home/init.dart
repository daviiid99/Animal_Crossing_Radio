import 'package:flutter/material.dart';
import '../Playlist/playlist.dart';

class Init extends StatefulWidget{
  @override
  Init({
    required this.game,
});

  final String game;

  @override
  InitState createState() => InitState(game : this.game);
}

class InitState extends State<Init>{
  @override
  InitState({
    required this.game,
  });

  final String game;
  String currentDisc = "";
  String currentTitle = "";
  String currentSubTitle = "";
  Map<String, dynamic> availableDisc = {
    "gc" : "assets/disc/gc.png",
    "ds" : "assets/disc/ds.png",
    "wii" : "assets/disc/wii.png",
    "3ds" : "assets/disc/3ds.png",
    "switch" : "assets/disc/switch.png"
  };

  checkGame() async {
    // Determines game type and return a disc
    setState(() {
      if (game.contains("gamecube")){
        currentDisc = availableDisc["gc"];
        currentTitle = "Animal Crossing :";
        currentSubTitle = "Population Growing";
      } else if (game.contains("ds") && !game.contains("3")){
        currentDisc = availableDisc["ds"];
        currentTitle = "Animal Crossing :";
        currentSubTitle = "Wild World";
      } else if (game.contains("wii")){
        currentDisc = availableDisc["wii"];
        currentTitle = "Animal Crossing :";
        currentSubTitle = "Let's Go To The City";
      } else if (game.contains("3ds")){
        currentDisc = availableDisc["3ds"];
        currentTitle = "Animal Crossing :";
        currentSubTitle = "New Leaf";
      } else if (game.contains("switch")){
        currentDisc = availableDisc["switch"];
        currentTitle = "Animal Crossing :";
        currentSubTitle = "New Horizons";
      }
    });
  }

  @override
  void initState(){
    checkGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView(
                children : [
                  // Banner
                  Image.asset(currentDisc, width: 500, height: 500,),

                  const SizedBox(height: 25,),

                  Row(
                    children: [
                      const SizedBox(width: 25,),
                      Text(currentTitle, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 40), textAlign: TextAlign.left,),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 25,),
                      Text(currentSubTitle, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30), textAlign: TextAlign.left,),
                    ],
                  ),
                  const SizedBox(height: 25,),
                  // Button
                  Stack(
                    children : [
                      Center(
                        child : Row(
                          children : [
                            const SizedBox(width: 25,),
                            SizedBox(
                              width: 300,
                              child : ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50),
                                ),
                                child : TextButton(
                                onPressed: (){
                                  Playlist list = Playlist(game: currentSubTitle, disc: currentDisc,);
                                  Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => list));
                                },
                                style: TextButton.styleFrom(
                                backgroundColor: Colors.blueAccent
                            ),
                               child: const Text("Cargar Disco", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25)),
                                      ),
                                )
                            ),
                            const Spacer(),
                          ]
                                )
                      )
                      ]
                  )
                ]
              )
          )
        ],
      ),
    );
  }
}