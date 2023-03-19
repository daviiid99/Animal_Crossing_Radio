import 'package:animal_crossing_radio/Control/control.dart';
import 'package:animal_crossing_radio/DataBases/app.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Store extends StatefulWidget{
  @override
  StoreState createState() => StoreState();
}

class StoreState extends State<Store> with Control{

  String currentDialog = "assets/tendo/dialog_0.png";
  String currentDialogType = "presentation";
  int currentDialogIndex = 0;
  bool welcomeCompleted = false;
  Map<String, dynamic> dialogs = {
    "presentation" :  ["assets/tendo/dialog_0.png", "assets/nendo/dialog_0.png", "assets/tendo/dialog_2.png", "assets/tendo/dialog_1.png"],
  };

  // Global product variables
  List<String> productAsset = ["assets/disc/ds.png", "assets/songs/totakeke/art/CAPULLOS_EN_FLOR.png", "assets/disc/switch.png"];
  List<String> productName = ["Fuegos Artificales", "Capullos en flor", "5PM - New Horizons"];
  List<String> productPrice = ["3000", "3500", "3000"];

  // Choosed product variables
  String choosedProductAsset = "";
  String choosedProductName = "";
  String choosedProductPrice = "";

  AudioPlayer player = AudioPlayer();
  Duration total = Duration();
  Duration currentPosition = Duration();
  int npcHeight = 500;
  String audioTotal = "";
  String audioPosition = "";
  String fixedAudioPosition = "";
  Color backgroundColor = Colors.transparent;
  late WillPopScope home_screen;
  bool isHome = true;

  @override
  void initState() {
    home_screen = mainScreen(isHome);
    player.pause();
    playSong();
    storeSongInLoop();
    super.initState();
  }

  playSong() {
    // The main method to play the background music if needed
    setState(() {
      player.pause();
      player.play(AssetSource("songs/stores/nook.mp3"));
      storeSongInLoop();
    });
  }

  getReadyForSelling(int index){
    // User choosed a product
    // Set new scaffold
    setState(() {
      isHome = false;
      choosedProductAsset = productAsset[index];
      choosedProductName = productName[index];
      choosedProductPrice = productPrice[index];
    });
  }

  WillPopScope sellingScreenDialog(){
    // This is a widget to show a real time selling screen
    // If the user clicks into a product, the screen will be rebuilt
    // This means a new Scaffold is gonna be loaded instead
    return WillPopScope(
      onWillPop: ()=> stopServices(player, context),
      child : Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            // Banner
            const SizedBox(height: 10,),
            Container(
              width: double.maxFinite,
              height: 300,
              child: Row(
                children: [
                  const SizedBox(width: 10,),
                  Image.asset("assets/res/tendo_2_model.png", width: 200, height: 200,),
                  const SizedBox(width: 10,),
                  Column(
                    children: [
                      const SizedBox(height: 65,),
                      // Disc preview
                      Image.asset(choosedProductAsset, width: 100, height: 100, ),
                      // Disc Title
                      const SizedBox(height: 10,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child : Container(
                        width: 200,
                        height: 80,
                        color: Colors.white,
                        child: Row(
                          children: [
                            const Spacer(),
                            Center(child: Text(choosedProductName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                      const SizedBox(height: 15,),
                    ],
                  ),
                  const SizedBox(width: 10,),
                ],
              ),
            ),
            const SizedBox(height: 10,),

            // Price
            ClipRRect(
              borderRadius: BorderRadius.circular(70),
              child : Container(
              width: 500,
              height: 120,
              color: Colors.orangeAccent,
              child : Column(
                children: [
                  const SizedBox(height : 10),
                Row(
                  children: [
                    const SizedBox(width: 10,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child : Container(
                        height: 100,
                        width: 480,
                        color: Colors.white,
                        child: Row(
                          children: [
                            const SizedBox(width : 100 ),
                            Image.asset("assets/items/bolsa_grande.png", width: 50, height: 50,),
                            const SizedBox(width : 10),
                            Text(choosedProductPrice, style: TextStyle(color: Colors.black, fontSize: 50, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                            const SizedBox(width : 100 ),

                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                  ],
                ),
                    ],
                  ),

            ),
            ),
            const SizedBox(height: 10,),
          ],
        ),
      )
    );
  }

  formatDuration(Duration d, String type){
    // This is needed to format current duration
    // Into human readable format
    int rawHours = Duration(milliseconds: d.inMilliseconds).inHours;
    int rawMinutes = Duration(milliseconds: d.inMilliseconds).inMinutes;
    int rawSeconds = Duration(milliseconds: d.inMilliseconds).inSeconds;

    int hours = rawHours;
    int minutes = rawMinutes - (rawHours * 60);
    int seconds = rawSeconds - (rawMinutes * 60 + rawHours * 60 * 60);

    if (type == "full"){
      setState(() {
        audioTotal = "$hours:$minutes:$seconds";
      });
    } else {
      setState(() {
        audioPosition = "$hours:$minutes:$seconds";
        fixedAudioPosition = "$hours:$minutes:${seconds-1}";
        print("$audioPosition / $audioTotal");
        if(audioTotal == fixedAudioPosition || audioTotal == audioPosition ){
          playSong();
        }
      });
    }
  }

  storeSongInLoop() async {
    // We need a method to create infinite ambient sound in shop :)
    player.onDurationChanged.listen((Duration d) {
      setState(() {
        total = d;
      });
      formatDuration(d, "full");
    });

    player.onPositionChanged.listen((Duration d) {
      setState(() {
        currentPosition = d;
      });
      formatDuration(d, "current");
    });

  }

  changeDialog(int index){

    switch (index){

      case  0 :
        if (!welcomeCompleted){
          setState(() {
            currentDialogIndex ++;
            currentDialog = dialogs[currentDialogType][currentDialogIndex];
          });
        }
        break;

      case 1 :
        if (!welcomeCompleted){
          setState(() {
            currentDialogIndex ++;
            currentDialog = dialogs[currentDialogType][currentDialogIndex];
          });
        }
        break;

      case 2 :
        if (!welcomeCompleted){
          setState(() {
            currentDialogIndex ++;
            currentDialog = dialogs[currentDialogType][currentDialogIndex];
            welcomeCompleted = true;
            npcHeight = 300;
            backgroundColor = Colors.blueAccent;
          });
        }
        break;
    }

  }

  Container tendoBanner(){
    return Container(
          width: double.maxFinite,
          height: npcHeight.toDouble(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/res/tendo_model.png"),
            )
          ),
          child: Column(
            children: [
              const SizedBox(height: 300,),
              Image.asset(currentDialog, width: 400, height: 200,),
            ],
          ),
        );
  }

  ClipRRect stand(){
    return ClipRRect(
      borderRadius: BorderRadius.only(
       topLeft : Radius.circular(100),
        topRight: Radius.circular(100),
      ),
        child : Container(
          width: double.maxFinite,
          height: 425,
          color: Colors.white,
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, mainAxisSpacing: 20,),
              itemCount: productAsset.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index){
                return InkWell(
                  onTap :  (){
                    getReadyForSelling(index);
                  },
                    child : SizedBox(
                      width: 400,
                      height: 300,
                      child : Column(
                        children  : [
                          // Disc image
                          const SizedBox(height: 15,),
                          Center(
                              child : ClipRRect(
                                borderRadius: BorderRadius.circular(225),
                                  child : Container(
                                  width: 225,
                                  height: 225,
                                  color: Colors.orangeAccent,
                                  child: Column(
                                      children : [
                                        const SizedBox(height: 12.5),
                                        Row(
                                            children : [
                                              const SizedBox(width: 12.5,),
                                              Image.asset(productAsset[index], width: 200, height: 200,),
                                              const SizedBox(width: 12.5,),
                                            ]
                                        ),
                                        const SizedBox(height: 12.5),
                                      ]
                                  ),
                                ),
                              ),
                          ),
                          const SizedBox(height: 25,),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(70),
                            child : Container(
                              height: 125,
                              width: 350,
                              color: Colors.orangeAccent,
                              child : Column(
                                children  : [
                                  const SizedBox(height : 12),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(70),
                                  child : Container(
                                    height: 100,
                                    width: 325,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        // Title
                                        const SizedBox(height: 10,),
                                        Text(productName[index], style: TextStyle(color: Colors.black, fontSize: 30), textAlign: TextAlign.center,),
                                        const SizedBox(height: 10,),

                                        Row(
                                          children: [
                                            const Spacer(),
                                            Image.asset("assets/items/bolsa_grande.png", width: 30, height: 30,),
                                            Text(productPrice[index], style: TextStyle(color: Colors.black, fontSize: 25), textAlign: TextAlign.center,),
                                            const Spacer(),
                                          ],
                                        )
                                        ],
                                      ),
                                  ),
                                ),
                              const SizedBox(height : 12),
                           ],
                         )
                       ),
                      ),
                    ]
                    ),
                ),
                );
              },
          )
        )
    );
  }

  Stack cursor(){
    return Stack(
      children: [
        Row(
          children: [
            const Spacer(),
            InkWell(
              onTap : () {
                changeDialog(currentDialogIndex);
              },

             child : Image.asset("assets/res/cursor.png", width: 100, height: 100,)
            ),
          ],
        )
      ],
    );
  }

  WillPopScope mainScreen(bool isHome){

    if (isHome){
      return home();
    } else {
      return sellingScreenDialog();
    }
  }

  WillPopScope home() {
    return WillPopScope(
      onWillPop: ()=> stopServices(player, context),
      child : Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: backgroundColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                tendoBanner(),
              ],
            ),
          ),
          if(!welcomeCompleted)
            cursor(),

          if(welcomeCompleted)
            Stack(
                children : [
                  stand(),
                ]
            ),
        ],
      ),
    ),
    );
  }

  @override
  Widget build(BuildContext context){
    return mainScreen(isHome) ;
  }
}