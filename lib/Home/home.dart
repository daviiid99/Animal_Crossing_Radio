import 'package:animal_crossing_radio/LoginScreen/loginScreen.dart';
import 'package:animal_crossing_radio/main.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import '../Screens/screen.dart';
import 'init.dart';
import 'dart:math';

class Home extends StatefulWidget{
  @override
    const Home({
    required this.userName,
    required this.userPicture,
    required this.userDate,
    required this.userGenre,
    required this.userBells,
    super.key
});

  final String userName;
  final String userPicture;
  final String userDate;
  final String userGenre;
  final int userBells;

  @override
  HomeState createState() => HomeState(userName: userName, userPicture: userPicture, userDate: userDate, userGenre: userGenre, userBells: userBells);
}

class HomeState extends State<Home> with Control{

  HomeState({
    required this.userName,
    required this.userPicture,
    required this.userDate,
    required this.userGenre,
    required this.userBells,
});

  final String userName;
  final String userPicture;
  final String userDate;
  final String userGenre;
  final int userBells;

  List<String> games = ["assets/logo/ac_gamecube.png", "assets/logo/ac_ds.png", "assets/logo/ac_wii.png", "assets/logo/ac_3ds.png", "assets/logo/ac_switch.png"];
  List<String> backgrounds = ["assets/background/sky.png", "assets/background/sky.png", "assets/background/sky.png", "assets/background/sky.png", "assets/background/sky.png" ];
  bool isPlaying = false;
  AudioPlayer player = AudioPlayer();
  Songs database = Songs(name: "name", uri: "uri", logo: "logo", title: "title");
  Song mySongs = Song();
  List<Songs> songs = [];
  Map<String, dynamic> users = {};
  User user = User(name: "name", picture: "picture", genre: "genre", dateOfBirth: "date_of_birth", bells: 0, library: "library", userID: "");
  Settings settings = Settings();
  Map<String,dynamic> userPockets = {};
  AnnouncementDataBase announcementDataBase = AnnouncementDataBase(date : "");
  String currentDate = "";
  bool choosedOption = false;

  @override
  void initState()  {
    enablefullScreenMode();
    player.pause();
    checkDataBase();
    readPocket();
    //checkAnnouncements();
    super.initState();
  }

  checkAnnouncements() async {
    // Check if Isabelle already did an announcement today
    // To achieve that, we'll read current database

    List<AnnouncementDataBase> dates = [];

    compareDates(List<AnnouncementDataBase> dates) async {
      // Compare dates
      bool dateExists = false;
      dates.forEach((date) {
        if (date.date == currentDate) dateExists = true;
      });

      if (dates.isEmpty || !dateExists){
        // add current date
        AnnouncementDataBase newDate = AnnouncementDataBase(date: currentDate);
        announcementDataBase.insertRowIntoTable(newDate);

        Navigator.push(context, MaterialPageRoute(builder: (context) => Announcement(genre: userGenre)));
      }
    }

    // First, get current date from local device
    setState(() async  {
      currentDate = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";

    // Then, recover database existing dates
    try {
      dates =  await announcementDataBase.retrieveDates();
      compareDates(dates);
    } catch (e){
      announcementDataBase.createTable();
      compareDates(dates);
    }
    });

  }

  checkDataBase() async {
    // A method to check if database is empty or not
    // Retrieve all existing songs
    try {
      songs = await Songs.retrieveSongs();
   }
     catch (e) {
      if (songs.isEmpty){
        Song data = Song();
        await data.insertSongs();
        songs = await Songs.retrieveSongs();
      }
     }
     setState(() {
       songs;
     });
   }

  Expanded gamesGrid(){
    // A widget to display all available games
    return Expanded(
          child : GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 20,
                ),
            itemCount: games.length,
            itemBuilder: (context, index){
              return Row(
                children: [
                  InkWell(
                  onTap : (){
                    Init preview = Init(game: games[index]);
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => preview));

                  },
                    child : Center(
                      child : SizedBox(
                        width: 350,
                        height: 250,
                        child :  Column(
                             children: [
                               Expanded(
                                child : ListView(
                                  children : [
                                     Container(
                                       width: 350,
                                       height: 250,
                                       decoration: BoxDecoration(
                                         color : Colors.transparent,
                                         image: DecorationImage(
                                           fit: BoxFit.cover,
                                           image: AssetImage(games[index]),
                                         )
                                       ),
                                     ),
                                  ]
                                    )
                                  )
                              ],
                           ),
                      )
                    ),
                  )
                ],
              );
            }
        )
    );
  }

  Column titleBox(){
    // A widget to show a title with a wood background
    return Column(
        children : [
          SizedBox(
      height: 150,
      width: 400,
      child: Container(
        decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/background/wood.png"),
        ),
      ),
        child: const Center(
          child: Text("Juegos Principales", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 35),))
      )
          ),
        ]
    );
  }


  easterEgg() async {
    // A funny easter egg that reproduce a random Nintendo sound effect
    List<String> nintendoEffect = ["assets/songs/nintendo/nintendo_1.mp3","assets/songs/nintendo/nintendo_2.mp3","assets/songs/nintendo/nintendo_3.mp3","assets/songs/nintendo/nintendo_4.mp3","assets/songs/nintendo/nintendo_5.mp3"];
    Random sound = Random();

    if(isPlaying){
      await player.pause();
    }
    await player.play(AssetSource(nintendoEffect[sound.nextInt(4)].replaceAll("assets/", "")));
  }

  playSound() async {
    // Check if background sound is already playing
    // Stop or play audio flow
    if(isPlaying){
      await player.pause();
      setState(() {
        isPlaying = false;
      });
    } else if(!choosedOption) {
      await player.play(AssetSource("audio/ac_theme.mp3"));
      setState(() {
        isPlaying = true;
      });

    }
  }

  InkWell bannerImage(){
    //A widget to draw the home screen banner
    return InkWell(
      onTap: (){
        if (choosedOption) choosedOption = false;
        if (!choosedOption) playSound();
      },
      child : Container(
        height: 250,
        width: double.maxFinite,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/banner.png"),
              fit: BoxFit.fitWidth
            )
          ),
        ),
    );
  }

  loadOption(int option){
    // A method to load an option from main menu :)
    switch (option){

      case 0 :
        setState(() {
          choosedOption = true;
        });
        break;

      case 1 :
        setState(() {
          Tota totakeke = Tota();
          Navigator.push(context, MaterialPageRoute(builder: (context) => totakeke ));
        });
        break;

      case 2 :
        setState(() {
          Store store = Store();
          Navigator.push(context, MaterialPageRoute(builder: (context) => store)).then((value) =>setState((){}));
        });
        break;

      case 3 :
        setState(() {
        });
        break;
    }
  }

  SizedBox menuOptions(){
    // A widget to show all available options

    return SizedBox(
      width: 375,
      height: 375,
      child: Column(
        children: [

          // First pair of options
          Row(
            children: [
              const Spacer(),
              InkWell(
                onTap : (){
                  loadOption(0);
                },
                child : ClipRRect(
                borderRadius: BorderRadius.circular(30),
                  child : Container(
                    width: 150,
                    height: 150,
                    color: Colors.blueAccent,
                    child: Image.asset("assets/menu/option_1.png"),
                )
              ),
              ),
              const Spacer(),
              InkWell(
                onTap : (){
                  loadOption(1);
                },
                child : ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child : Container(
                      width: 150,
                      height: 150,
                      color: Colors.black,
                      child: Image.asset("assets/menu/option_2.png"),
                    )
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 25,),

          // Second pair of options
          Row(
            children: [
              const Spacer(),
              InkWell(
                onTap : (){
                  loadOption(2);
                },
                child : ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child : Container(
                      width: 150,
                      height: 150,
                      color: Colors.orangeAccent,
                      child: Image.asset("assets/menu/option_3.png"),
                    )
                ),
              ),
              const Spacer(),
              InkWell(
                onTap : (){
                  loadOption(3);
                },
                child : ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child : Container(
                      width: 150,
                      height: 150,
                      color: Colors.yellow,
                      child: Image.asset("assets/menu/option_4.png"),
                    )
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 25,),

        ],
      ),
    );
  }

  Column copyrightAdvertisement(){
    return Column(
      children: [
        Center(
          child: InkWell(
              onTap : (){easterEgg();},
              child : Image.asset("assets/menu/option_1.png", width: 55, height: 75,)),
        ),

        Row(
          children:  [
            Spacer(),
            Text(copyright_1, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
            Spacer(),
          ],
        ),
        const Text(copyright_2, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
        const SizedBox(height: 10,),

      ],
    );
  }

  readPocket() async {
    // This verifies if database contains the pockets table
    // Return the full pocket from current user
    PocketDatabase bolsillo  = PocketDatabase(itemField: "itemField", itemPicture: "itemPicture", itemName: "itemName", itemAmount: "itemAmount", user: "user");
    try {
        userPockets = await bolsillo.retrievePocketFields(userName);
    } catch (e){
      if (userPockets.isEmpty){
        Pockets data = Pockets();
        await data.createPocket(userName);
        userPockets = await bolsillo.retrievePocketFields(userName);
      }
    }
    setState(() {
      userPockets;
    });
  }


  @override
  Widget build(BuildContext context){
    return WillPopScope(
      onWillPop: ()=> stopServices(player, context),
      child : Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Row(
            children: [
            Row(
              children: [
                InkWell(
                onTap: (){
                Profile profile = Profile(userName: userName, userProfile: userPicture, userDate: userDate, userGenre: userGenre);
                Navigator.push(context, MaterialPageRoute(builder: (context) => profile));

                },
                child : ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child : Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                image: DecorationImage(
                image: AssetImage("assets/background/sky.png"),
                                      fit: BoxFit.fill
                                    )
                                  ),
                                   child: Center(
                                     child: Image.asset(userPicture),
                              ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5,),
                            Text(userName, style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),)
                        ],
                    ),

                    const Spacer(),
                    InkWell(
                      onTap: () async {
                        PocketDatabase database = PocketDatabase(itemField: "itemField", itemPicture: "itemPicture", itemName: "itemName", itemAmount: "itemAmount", user: "user");
                        Pocket pocket = Pocket(userName: userName, pockets: userPockets, userBells: userBells,);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => pocket));
                      },
                        child : ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child : Container(
                            width: 40,
                            height: 40,
                            color: Colors.orangeAccent,
                            child : Image.asset("assets/res/backpack.png", width: 40, height: 40,),
                        ),
                        ),
                    ),
                  ],
              ),
          ),
          body: Column(
            children: [

              // Main Menu
              if (!choosedOption)
                Expanded(
                  child: ListView(
                    children: [

                      // Banner
                      bannerImage(),

                      // Main Menu
                      const SizedBox(height: 50,),
                      menuOptions(),

                      // Copyright
                      copyrightAdvertisement(),
                    ],
                  )
               ),

              // Albums Menu
              if (choosedOption)
                // Banner
                bannerImage(),

              if (choosedOption)
                // Games Grid
                titleBox(),

              if (choosedOption)
                gamesGrid(),

            ],
          ),
        ),
    );
  }
}