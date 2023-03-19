import 'package:animal_crossing_radio/Control/control.dart';
import 'package:animal_crossing_radio/Data/kk_songs.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'name.dart';
import 'genre.dart';
import 'birthday.dart';
import '../DataBases/users.dart';
import '../Home/home.dart';
import '../Data/kk_songs.dart';
import '../Transactions/transaction.dart';

class Welcome extends StatefulWidget{
  @override
  const Welcome({
  super.key,
});

  @override
  WelcomeState createState() => WelcomeState();
}

class WelcomeState extends State<Welcome> with Control{

  // Standard variables
  AudioPlayer audio = AudioPlayer();
  String nookModel = "assets/res/nook_model.png";
  String cursor = "assets/res/cursor.png";
  String currentDialog = "assets/welcome/presentation/dialog_1.png";
  String currentDialogType = "presentation";
  int currentDialogIndex = 0;
  Duration _duration = new Duration();

  // Widgets
  Name name = Name();
  Genre genre = Genre();
  late Birthday birthday;

  Map<String, dynamic> dialogs = {
    "presentation" : ["assets/welcome/presentation/dialog_1.png", "assets/welcome/presentation/dialog_2.png", "assets/welcome/presentation/dialog_3.png"],
    "name" : ["assets/welcome/name/dialog_1.png", "assets/welcome/name/dialog_2.png", "assets/welcome/name/dialog_3.png"],
    "genre"  : ["assets/welcome/genre/dialog_1.png", "assets/welcome/genre/dialog_2.png", "assets/welcome/genre/dialog_boy.png", "assets/welcome/genre/dialog_girl.png"],
    "birthday" : ["assets/welcome/birthday/dialog_1.png", "assets/welcome/birthday/dialog_2.png"],
    "creation" : ["assets/welcome/creation/dialog_1.png", "assets/welcome/creation/dialog_2.png"],
  };

  // First block
  // Includes all elements at first screen
  bool presentationCompleted = false;

  // Second block
  // Includes elements at name screen
  bool chooseName = false;
  bool chooseNameCompleted = false;

  // Third Block
  // Includes all elements for choose your genre
  bool chooseGenre = false;
  bool genreCompleted = false;

  // Four Block
  // Includes all elements for choose your date of birth
  bool chooseBirthday = false;
  bool birthdayCompleted = false;

  // Final Block
  // Creating final user
  bool creatingUser = false;

  @override
  void initState(){
    enablefullScreenMode();
    audio.pause();
    audio.play(AssetSource("audio/tom_nook_theme.mp3"));
    birthday = Birthday(context: context);
    super.initState();
  }

  SizedBox welcomeScreen(){
    // This screen will introduce Tom Nooks
    // Asking for several things
    return SizedBox(
      height: 400,
      child: Column(
        children: [
          Container(
            height: 400,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(nookModel),
              )
            ),
            child: Column(
              children : [
                const SizedBox(height: 200,),
                Image.asset(currentDialog, height: 200, width: 400,),
            ]
            ),
          )
          // Nook Model
        ],
      ),
    );
  }

  onTapAction() async {
    // Check what's the next action based on current action
    switch (currentDialogIndex){
      case 0 :
        if (!presentationCompleted){
          // User still trying to complete setup
          setState(() {
            currentDialogIndex ++;
            currentDialog = dialogs[currentDialogType][currentDialogIndex];
          });
    } else if (presentationCompleted && !chooseNameCompleted){
          setState(() {
            currentDialogIndex ++;
            currentDialog = dialogs[currentDialogType][currentDialogIndex];
          });
        } else if (presentationCompleted && chooseNameCompleted && !genreCompleted){
          setState(() {
            currentDialogIndex ++;
            currentDialog = dialogs[currentDialogType][currentDialogIndex];
            chooseGenre = true;
          });
        } else if (presentationCompleted && chooseNameCompleted && genreCompleted && !creatingUser){
          setState(() {
            currentDialogIndex ++;
            currentDialog = dialogs[currentDialogType][currentDialogIndex];
          });
        } else if (creatingUser){
          setState(() {
            currentDialogIndex++;
            currentDialog = dialogs[currentDialogType][currentDialogIndex];
          });
        }
        break;

      case 1 :
        if (!presentationCompleted){
          // User still trying to complete setup
          setState(() {
            currentDialogIndex ++;
            currentDialog = dialogs[currentDialogType][currentDialogIndex];
          });
        } else if (presentationCompleted && !chooseNameCompleted){
          setState(() {
            chooseName = true;
            chooseNameCompleted = true;
          });
        }  else if (presentationCompleted && chooseNameCompleted && !chooseGenre && !chooseBirthday && !creatingUser){
          if (name.name.text.toString().isNotEmpty) {
            setState(() {
              currentDialogIndex ++;
              currentDialog = dialogs[currentDialogType][currentDialogIndex];
              print("okay ${name.name.text.toString()}");
              print(currentDialogIndex);
            });
          }
        } else if (presentationCompleted && chooseNameCompleted && !genreCompleted) {
          print(genre.onTap);
          if (genre.onTap) {
            // User choosed already a genre
            if (genre.isBoy) {
              setState(() {
                chooseGenre = false;
                genreCompleted = true;
                currentDialogIndex = 2;
                currentDialog = dialogs[currentDialogType][currentDialogIndex];
                print("chico ");
              });
            } else {
              setState(() {
                chooseGenre = false;
                genreCompleted = true;
                currentDialogIndex = 3;
                currentDialog =
                dialogs[currentDialogType][currentDialogIndex];
                print("chica");
              });
            }
          }
        } else if (presentationCompleted && chooseNameCompleted && genreCompleted && !creatingUser){
          setState(() {
            birthdayCompleted = true;
            chooseBirthday = false;
            currentDialogIndex = 0;
            creatingUser = true;
            currentDialogType = "creation";
            currentDialog = dialogs[currentDialogType][currentDialogIndex];
          });

        } else if (creatingUser){
          setState(() {
            creatingUser = false;
            createUser();
          });
        }
        break;

      case 2 :
        if (!presentationCompleted){
          setState(() {
            currentDialogIndex = 0;
            presentationCompleted = true;
            currentDialogType = "name";
            currentDialog = dialogs[currentDialogType][currentDialogIndex];
          });
        } else if (presentationCompleted && chooseNameCompleted && !genreCompleted){
          setState(() {
            chooseName = false;
            currentDialogIndex ++;
          });
        } else if (presentationCompleted && chooseNameCompleted && genreCompleted){
          setState(() {
            currentDialogIndex = 0;
            currentDialogType = "birthday";
            chooseBirthday = true;
            currentDialog = dialogs[currentDialogType][currentDialogIndex];
          });
        }
        break;

      case 3 :
        if (presentationCompleted && chooseNameCompleted && !genreCompleted){
          setState(() {
            currentDialogIndex = 0 ;
            currentDialogType = "genre";
            currentDialog = dialogs[currentDialogType][currentDialogIndex];
          });
        } else if (presentationCompleted && chooseNameCompleted && genreCompleted){
          setState(() {
            currentDialogIndex = 0;
            currentDialogType = "birthday";
            chooseBirthday = true;
            currentDialog = dialogs[currentDialogType][currentDialogIndex];
          });
        }
        break;
    }
  }

  createUser() async {
    audio.stop(); // Kill service if still up
    User user = User(name: name.name.text.toString(), picture: genre.isBoy ? genre.models[0] : genre.models[1], genre: genre.isBoy? "boy" : "girl", date_of_birth: "${birthday.currentDay}/${birthday.currentMonth}/${birthday.currentYear}", bells: 500, library: "Playlist de ${name.name.text.toString()}");
    Transaction creation = Transaction();
    creation.createTable(user);
    Map<String, dynamic> users = await user.retrieveUser();
    Home home = Home(userName: users.keys.first, userPicture: users[users.keys.first][0], userDate: users[users.keys.first][2], userGenre: users[users.keys.first][1], userBells: 500,);
    Navigator.push(context, MaterialPageRoute(builder: (context) => home));
  }



  Stack cursorButton(){
    return Stack(
      children: [
        // Cursor Button
        Row(
          children: [
            const Spacer(),
            InkWell(
                onTap : () {
                  onTapAction();
                },
                child : Image.asset(cursor, width: 150, height: 150,)),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [

          Expanded(
            child : ListView(
              children : [
                // Nook model + dialog
                welcomeScreen(),
                const SizedBox(height: 100,),

                // Widgets
                if (chooseName)
                  name.enterNameDialog(),

                if (chooseGenre)
                  genre.chooseCharacter(),

                if (chooseBirthday)
                  birthday.dateWidget(),

              ]
            )
          ),

          // Button
          cursorButton(),

        ],
      ),
    );
  }
}