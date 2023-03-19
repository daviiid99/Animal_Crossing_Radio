import 'package:flutter/material.dart';
import '../Data/kk_songs.dart';
import '../DataBases/kk.dart';

class Tota extends StatefulWidget{
  @override
  TotaState createState()=> TotaState();
}

class TotaState extends State<Tota>{

  Map<String, dynamic> songs = {};
  KkSongs songsData = KkSongs();
  KK database = KK(songName: "songName", songArt: "songArt", songPath: "songPath");
  Map<String,dynamic> dialogs = {
  "presentation" : ["assets/totakeke/presentation/dialog_1.png", "assets/totakeke/presentation/dialog_2.png", "assets/totakeke/presentation/dialog_3.png", "assets/totakeke/presentation/dialog_4.png", "assets/totakeke/presentation/dialog_5.png", "assets/totakeke/presentation/dialog_6.png"],
  };

  // Dialog variables
  int currentDialogIndex = 0;
  String currentDialog = "assets/totakeke/presentation/dialog_1.png";
  bool isPresentation =  true;
  bool isPresentationCompleted = false;
  String currentDialogType = "presentation";

  @override
  void initState(){
    getAllTotaSongs();
    super.initState();
  }

  Container totakekeStage(){
    // Let's bring our Tota to life :)
    return Container(
      height: 500,
      width : 500,
      decoration: const BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.center,
          image: AssetImage("assets/res/totakeke_model.png"),
          fit: BoxFit.fitHeight
        )
      ),
      child: Column(
        children: [
          const SizedBox(height: 300,),
          Image.asset(currentDialog, width: 400, height: 200, alignment: Alignment.center,),

        ],
      ) ,
    );
  }

  nextDialog(){
    // A method to choose next dialog based on tap and other events
    switch (currentDialogIndex) {
      case 0 :
        if(!isPresentationCompleted){
          setState(() {
            currentDialogIndex ++;
            currentDialog = dialogs[currentDialogType][currentDialogIndex];
          });
        }{}
        break;

      case 1 :
        if(!isPresentationCompleted){
          setState(() {
            currentDialogIndex ++;
            currentDialog = dialogs[currentDialogType][currentDialogIndex];
          });
        }{}
        break;


      case 2 :
        if(!isPresentationCompleted){
          setState(() {
            currentDialogIndex ++;
            currentDialog = dialogs[currentDialogType][currentDialogIndex];
          });
        }{}
        break;

      case 3 :
        if(!isPresentationCompleted){
          setState(() {
            currentDialogIndex ++;
            currentDialog = dialogs[currentDialogType][currentDialogIndex];
          });
        }{}
        break;

      case 4 :
        if(!isPresentationCompleted){
          setState(() {
            currentDialogIndex ++;
            currentDialog = dialogs[currentDialogType][currentDialogIndex];
          });
        }{}
        break;

    }

  }

  Stack cursor(){
    // We need a cursor to interact with K.K.

    return Stack(
      children: [
        Row(
          children: [
            const Spacer(),
            InkWell(
              onTap : (){
                nextDialog();
             },
              child : Image.asset("assets/res/cursor.png", height: 150, width: 150,)),
          ],
        )
      ],
    );
  }

  getAllTotaSongs() async {
    // Request all songs to database
    try{
      setState(() async {
        songs = await database.retrieveTotaSongs();
        print(songs);
      });

    } catch(e){
      // If it fails, database is empty or table isn't created yet
      //  Let's create everything
      setState(() async {
        songsData.addSongsToDatabase();
        songs = await database.retrieveTotaSongs();
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      appBar : AppBar(
        automaticallyImplyLeading: false ,
        elevation: 0.0,
        backgroundColor : Colors.black,
      ),
      body : Column(
        children : [
          Expanded(
              child: ListView(
                children: [
                  totakekeStage(),
                ],
              )),
          cursor(),
        ]
      )
    );
  }
}