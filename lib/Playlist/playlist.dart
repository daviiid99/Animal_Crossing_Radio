import 'package:flutter/material.dart';
import '../Dependencies/dependencies.dart';
import '../Screens/screen.dart';

class Playlist extends StatefulWidget{
  @override
   const Playlist({
    required this.game,
    required this.disc,
    super.key,
});

  final String game;
  final String disc;

  @override
  PlaylistState createState() => PlaylistState(game : this.game, disc : this.disc);
}

class PlaylistState extends State<Playlist>{
  @override
  PlaylistState({
   required this.game,
    required this.disc,
});

  final String game;
  final String disc;
  late String banner;
  var player = AudioPlayer();
  Map<String, dynamic> songs = {};
  List<String> logos = ["assets/logo/ac_gamecube.png", "assets/logo/ac_ds.png", "assets/logo/ac_wii.png", "assets/logo/ac_3ds.png", "assets/logo/ac_switch.png"];
  List<String> songsTitle = [];
  List<String> songsPath  = [];
  int availableSongs =  0;

  @override
  void initState(){
    print("platform ${game}");
    getCurrentDiscSongs();
    getCurrentDisc();
    super.initState();
  }

  getPlayListSongs() async {
    // Add songs title, path into lists
    setState(() {
      for (String title in songs.keys){
        if (!songsTitle.contains(title)){
          songsTitle.add(title);
          songsPath.add(songs[title][0]);
        }
      }
    });
    print(songsTitle);
  }

  getCurrentDisc() async {
    if (game.contains("Population")){
      setState(() {
        banner = logos[0];
      });
    } else if (game.contains("Wild")){
      setState(() {
        banner = logos[1];
      });
    } else if (game.contains("City")){
      setState(() {
        banner = logos[2];
      });
    } else if (game.contains("Leaf")){
      setState(() {
        banner = logos[3];
      });
    } else if (game.contains("Horizons")){
      setState(() {
        banner = logos[4];
      });
    }
  }

  getCurrentDiscSongs() async {

    Map<String, dynamic>  chooseCurrentDiscSongs(Map<String, dynamic> temp){
      // Once we've all existing songs
      // We just want current disc songs to be added

      if (game.contains("Population")){
        for (String song in temp.keys){
          if (temp[song][2].contains("Population")){
            songs[song] = [];
            songs[song] = [temp[song][0], temp[song][1], temp[song][2]];
          }
        }
      } else if (game.contains("Wild")){
        for (String song in temp.keys){
          if (temp[song][2].contains("Wild")){
            songs[song] = [];
            songs[song] = [temp[song][0], temp[song][1], temp[song][2]];
          }
        }
      } else if (game.contains("City")){
        for (String song in temp.keys){
          if (temp[song][2].contains("City")){
            songs[song] = [];
            songs[song] = [temp[song][0], temp[song][1], temp[song][2]];
          }
        }
      }  else if (game.contains("Leaf")){
        for (String song in temp.keys){
          if (temp[song][2].contains("Leaf")){
            songs[song] = [];
            songs[song] = [temp[song][0], temp[song][1], temp[song][2]];
          }
        }
      } else if (game.contains("Horizons")){
        for (String song in temp.keys){
          if (temp[song][2].contains("Horizons")){
            songs[song] = [];
            songs[song] = [temp[song][0], temp[song][1], temp[song][2]];
          }
        }
      }
      return songs;
    }

    // User choosed a disc to play a song
    // We'll fetch only the songs of current disc
    Map<String, dynamic> temp = {};
    Songs database = Songs(name: "name", uri: "uri", logo: "logo", title: "title");

    temp = await database.retrieveSongs(); // Catch all songs
    setState(() {
      songs = chooseCurrentDiscSongs(temp);
      getPlayListSongs();
    });

  }

  Expanded listOfSongs(){
    return Expanded(
      child: ListView.builder(
          itemCount: songsTitle.length,
          itemBuilder: (context, index){
            return InkWell(
                  onTap : (){},
                  child : ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child : InkWell(
                      onTap : (){
                        Preview songPreview = Preview(disc: disc, title: songsTitle[index], album: "Animal Crossing : $game", songs: songsPath, currentSong: index, songsTitle: songsTitle,);
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => songPreview));
                       },
                      child : SizedBox(
                        width: 300,
                        height: 100,
                        child : Card(
                          shadowColor: Colors.grey,
                          color: Colors.white,
                          child: Center(
                            child : ListTile(
                              leading: Image.asset(disc),
                              title: Row(children: [Text(songsTitle[index], style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)), const Spacer(),],),
                              subtitle: Text("Animal Crossing : $game", style: const TextStyle(color: Colors.black)),
                            )
                          ),
                        )
                      ),
                    )
                  )
                );
            },
      )
    );
  }

  Column gameBanner(){
    return Column(
      children: [
         Row(
                children : [
                  const Spacer(),
                  Image.asset(banner, height: 100, width: 100,),
                  const Spacer(),
                  Text(game, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),),
                  const Spacer(),
                ]
            ),

          Row(
              children: [
                const Spacer(),
                Text("${songsTitle.length} cancion(es)", style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                const Spacer(),
              ],
            ),

          ],
        );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Banner
            gameBanner(),
            const SizedBox(height: 25,),

          // Playlist
          listOfSongs(),
        ],
      ),
    );
  }
}