import 'package:animal_crossing_radio/Control/control.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../Screens/screen.dart';

class Announcement extends StatefulWidget{
  const Announcement({
    required this.genre,
    super.key});

  final String genre;

  @override
  AnnouncementState createState() => AnnouncementState(genre: genre);
}

class AnnouncementState extends State with Control{

  AnnouncementState({
    required this.genre,
});

  final String genre;
  String currentDialog = "assets/isabelle/dialog_1_boy_morning.png";
  String currentDialogType = "morning_boy";
  int currentDialogIndex = 0;
  int maxDialogIndex = 3;
  AudioPlayer player = AudioPlayer();
  Duration fullPosition = Duration();
  Duration currentPosition = Duration();
  String currentDuration = "";
  String fullDuration = "";
  String fixedDuration = "";
  bool isabelleCompleted = false;
  bool isBoy = false;
  bool isMorning = false;
  bool isAfternoon = false;
  bool isEvening = false;

  Map<String,dynamic> dialogs = {
    "morning_boy" : ["assets/isabelle/dialog_1_boy_morning.png", "assets/isabelle/dialog_2.png", "assets/isabelle/dialog_3.png", "assets/isabelle/dialog_4.png"],
    "morning_girl" : ["assets/isabelle/dialog_1_girl_morning.png", "assets/isabelle/dialog_2.png", "assets/isabelle/dialog_3.png", "assets/isabelle/dialog_4.png"],
    "afternoon_boy" :  ["assets/isabelle/dialog_1_boy_afternoon.png", "assets/isabelle/dialog_2.png", "assets/isabelle/dialog_3.png", "assets/isabelle/dialog_4.png"],
    "afternoon_girl" :  ["assets/isabelle/dialog_1_girl_afternoon.png", "assets/isabelle/dialog_2.png", "assets/isabelle/dialog_3.png", "assets/isabelle/dialog_4.png"],
    "evening_boy" :  ["assets/isabelle/dialog_1_boy_evening.png", "assets/isabelle/dialog_2.png", "assets/isabelle/dialog_3.png", "assets/isabelle/dialog_4.png"],
    "evening_girl" :  ["assets/isabelle/dialog_1_girl_evening.png", "assets/isabelle/dialog_2.png", "assets/isabelle/dialog_3.png", "assets/isabelle/dialog_4.png"],
  };

  @override
  void initState(){
    player.pause();
    startBackgroundMusic();
    listenMusicPosition();
    setSomeSettings();
    super.initState();
  }

  setSomeSettings() async {
    await checkGenre();
    await getCurrentTime();
    await getDialogType();
  }

  checkGenre() async {
    // We need to know if user sex is boy or girl before continue
    // In order to show dialogs based on sex

    if (genre == "boy"){
      setState(() {
        isBoy = true;
      });
    } else {
      setState(() {
        isBoy = false;
      });
    }
  }

  getDialogType(){
    // With given hour from current device
    // Set current type for dialog

    if (isMorning && isBoy){
      setState(() {
        currentDialogType = "morning_boy";
        currentDialog = dialogs[currentDialogType][0];
      });
    } else if (isMorning && !isBoy){
      setState(() {
        currentDialogType = "morning_girl";
        currentDialog = dialogs[currentDialogType][0];
      });
    } else if (isAfternoon && isBoy){
      setState(() {
        currentDialogType = "afternoon_boy";
        currentDialog = dialogs[currentDialogType][0];
      });
    } else if (isAfternoon && !isBoy){
      setState(() {
        currentDialogType = "afternoon_girl";
        currentDialog = dialogs[currentDialogType][0];
      });
    } else if (isEvening && isBoy){
      setState(() {
        currentDialogType = "evening_boy";
        currentDialog = dialogs[currentDialogType][0];
        print(currentDialog);
      });
    } else if (isEvening && !isBoy ){
      setState(() {
        currentDialogType = "evening_girl";
        currentDialog = dialogs[currentDialogType][0];
      });
    }

  }

  getCurrentTime() {
    DateTime duration = DateTime.now();
    int hour = duration.hour;

    if (hour >= 0 && hour < 6 || hour >= 21 && hour <= 23) {
      setState(() {
        isEvening = true;

      });
    } else if (hour >= 6 && hour < 12) {
      setState(() {
        isMorning = true;
      });
    } else if (hour >= 12 && hour < 21) {
      setState(() {
        isAfternoon = true;
      });
    }



  }

  startBackgroundMusic(){
    // Play background music on loop :)
    player.play(AssetSource("songs/stores/isabelle.mp3"));
  }

  formatDuration(Duration d, String type ){
    // In order to control music playback
    // We need to format current duration to human readable format

    int rawHours = Duration(milliseconds: d.inMilliseconds).inHours;
    int rawMinutes = Duration(milliseconds: d.inMilliseconds).inMinutes;
    int rawSeconds = Duration(milliseconds: d.inMilliseconds).inSeconds;

    int hours = rawHours;
    int minutes = rawMinutes - (rawHours * 60);
    int seconds = rawSeconds - (rawMinutes * 60 + rawHours * 60 * 60);

     if (type == "full"){
       setState(() {
         fullDuration = "$hours:$minutes:$seconds";
       });
     } else {
       setState(() {
         currentDuration = "$hours:$minutes:$seconds";
         fixedDuration = "$hours:$minutes:${seconds - 1}";
         print("$currentDuration/$fullDuration");
         playMusicInLoop();
       });
     }
  }

  playMusicInLoop(){
    // Check if current position is equals to full duration or fixed duration
    if (currentDuration == fullDuration || fixedDuration == fullDuration){
      // Time to play song again :)
      player.pause();
    startBackgroundMusic();
    }
  }

  listenMusicPosition(){
    // Check if music stops to start playing again and again
    player.onDurationChanged.listen((Duration d) {
      setState(() {
        fullPosition = d;
        formatDuration(d, "full");
      });
    });

    player.onPositionChanged.listen((Duration d) {
      setState(() {
        currentPosition = d ;
        formatDuration(d, "current");
      });
    });
  }

  onTapListener(int currentDialogIndex){
    // If user press the navigator button
    // Expects to get a new dialog on screen in order to continue

    switch(currentDialogIndex){

      case 0 :

    }

  }

  Container isabelleBanner(){
    return Container(
      width: double.maxFinite,
      height: 550,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/res/isabelle_model.png"),
          fit: BoxFit.fitWidth,
        )
      ),
      child: Column(
        children: [
          const SizedBox(height: 350,),
          Image.asset(currentDialog, width: 400, height: 200,)
        ],
      ),
    );
  }

  Stack navigationCursor(){
    return Stack(
      children: [
        Row(
          children: [
            const Spacer(),
            InkWell(
              onTap: (){
                //TO-DO
              },
              child : Image.asset("assets/res/cursor.png", width: 150, height: 150,),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context){
    return  WillPopScope(
      onWillPop: () => stopServices(player, context),
      child : Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView(
                children: [
                  // Isabelle Banner
                  isabelleBanner(),
                ],
              )),

          // Cursor
          navigationCursor(),
        ],
      ),
      ),
    );
  }
}