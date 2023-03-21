import '../Screens/screen.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Preview extends StatefulWidget{

  const Preview({
    super.key,
    required this.disc,
    required this.title,
    required this.album,
    required this.songs,
    required this.currentSong,
    required this.songsTitle,
});

  final String disc;
  final String title;
  final String album;
  final List<String> songs;
  final List<String> songsTitle;
  final int currentSong;

  @override
  PreviewState createState() => PreviewState(disc: disc, title: title, album: album, songs: songs, currentSong: currentSong, songsTitle : songsTitle);
}

class PreviewState extends State<Preview> with TickerProviderStateMixin, Control{
  PreviewState({
    required this.disc,
    required this.title,
    required this.album,
    required this.songs,
    required this.currentSong,
    required this.songsTitle,
  });

  final String disc;
  String title;
  final String album;
  final List<String> songs;
  final List<String> songsTitle;

  bool isPlaying = true;
  bool isControlVisible = true;
  int currentSong;
  bool isFav = false;
  bool isLooping = false;

  late Duration? currentSongDuration;
  Duration current = Duration();
  Duration total = Duration();
  String audioDuration = "";
  String audioPosition = "";
  String fixedDuration = "";
  String cumulativeControlVisibility = "";

  // Values used for disc rotation
  late AnimationController _controller;
  late Animation<double> _animation;
  final Tween<double> turnsTween = Tween<double>(
    begin: 0,
    end: 1,
  );

  AudioPlayer player = AudioPlayer();

  @override
  void initState(){
    discAnimation("play");
    playChoosedSong();
    values();
    super.initState();
  }

  void discAnimation(String state){
    // Enable or disable disc movement
    if (state == "play"){
      _controller=AnimationController(vsync:this,duration: const Duration(seconds: 30));
      _animation=CurvedAnimation(parent: _controller, curve: Curves.easeInCirc);
      _controller.repeat();
    } else if (state == "pause"){
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  formatAudioPosition(Duration d, String type){
    // This method receive a full duration
    // Will format it to human readable format
      // It's full duration of video
      int rawHours = Duration(milliseconds: d.inMilliseconds).inHours;
      int rawMinutes = Duration(milliseconds: d.inMilliseconds).inMinutes;
      int rawSeconds = Duration(milliseconds: d.inMilliseconds).inSeconds;

      int hours = rawHours;
      int minutes = rawMinutes - (rawHours * 60);
      int seconds = rawSeconds - (rawMinutes * 60 + rawHours * 60 * 60);

      if (type == "full"){
      setState(() async {
        audioDuration = "$minutes:$seconds";
        fixedDuration = "$minutes:${seconds - 1}";

      });
    } else {
        setState(() {
          audioPosition = "$minutes:$seconds";
          String digit = seconds.toString()[0];
          cumulativeControlVisibility = (seconds/int.parse(digit)).toString() ;
          hideAudioControl(audioPosition);
          if (!isLooping){
            skipToNextSong("auto");
          } else {
            skipToNextSong("loop");
          }
        });

        }
      }


  hideAudioControl(String audioPosition) async {
    // Automatically hide audio control after 10s
    if (cumulativeControlVisibility == "10.0" && isControlVisible) {
      setState(() {
        isControlVisible = false;
        cumulativeControlVisibility = "";
      });
      
    }
  }

  skipToNextSong(String type){
    if (type == "auto"){
      // We don't need user interaction
      // If a song reaches the end, next song in queue will start

      if (audioPosition == fixedDuration || audioPosition == audioDuration ){
        // Reached song full duration
          if (currentSong < songs.length - 1){
            setState(() {
              currentSong++;
              player.play(AssetSource(songs[currentSong].replaceAll("assets/", "")));
              title = songsTitle[currentSong];
            });
          } else {
            setState(() {
              currentSong = 0;
              player.play(AssetSource(songs[currentSong]));
            });
          }
      }
    } else if (type == "next"){
      if (currentSong < songs.length - 1){
        // There's still on queue
        setState(() {
          currentSong ++;
          player.play(AssetSource(songs[currentSong].replaceAll("assets/", "")));
          title = songsTitle[currentSong];
        });
      } else if (currentSong == songs.length - 1){
        // Resume playlist from start
        setState(() {
          currentSong = 0;
          player.play(AssetSource(songs[currentSong].replaceAll("assets/", "")));
          title = songsTitle[currentSong];
        });
      }
    } else if (type == "previous"){
      if (currentSong == 0){
        setState(() {
          currentSong = songs.length - 1;
          player.play(AssetSource(songs[currentSong].replaceAll("assets/", "")));
          title = songsTitle[currentSong];
        });
      } else if (currentSong > 0 ){
        setState(() {
          currentSong --;
          player.play(AssetSource(songs[currentSong].replaceAll("assets/", "")));
          title = songsTitle[currentSong];
        });
      }
    } else if (type == "loop"){
      if (audioPosition == audioDuration || audioPosition == fixedDuration){
        setState(() {
          killServices();
          player.play(AssetSource(songs[currentSong].replaceAll("assets/", "")));
        });
      }
    }
  }

  values(){
      player.onDurationChanged.listen((Duration d) {
        setState(()  {
          total = d;
          formatAudioPosition(total, "full");
        });
    });

      player.onPositionChanged.listen((Duration d) {
        setState(() {
          current = d;
          formatAudioPosition(current, "current");
        });
      });
  }

  playInLoop(){
    // Play current song in loop
    if (isLooping){
      // Stop playing in loop
      setState(() {
        isLooping = false;
      });
    } else {
      setState(() {
        isLooping = true;
      });
    }
  }

  SizedBox songDetails(){
    // Define components for current song
    // Disc preview, title, album
    return SizedBox(
      height: 500,
      child: Column(
        children: [
          // Album Image
          InkWell(
            onTap: (){
              setState(() {
                isControlVisible ? isControlVisible = false : isControlVisible = true;
              });
            },
              
            child : RotationTransition(
                turns: turnsTween.animate(_controller),
                child : Center(
                  child : Container(
              width: 250, height: 250,
              decoration : BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(disc)
                )
              ))))),
             const SizedBox(height: 70,),

          // Song title
          Text(title, style: const TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
          const SizedBox(height: 15,),

          // Album Title
          Text(album, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),),
          const SizedBox(height: 50,),

          // Loop & add to album icon
          Row(
            children: [
              const SizedBox(width: 30,),
              IconButton(
                  onPressed: (){
                    // A method to allow to play a song in loop
                    playInLoop();
                  },
                  icon: Icon(Icons.loop_rounded, color: isLooping? Colors.green : Colors.grey, size: 40,)),
              const Spacer(),
              IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.queue_rounded, color: Colors.blueAccent, size: 40, )),
              const SizedBox(width: 30,),
            ],
          ),

          const SizedBox(height: 50,),

          // Song current time
          Slider(
              activeColor: Colors.blueAccent,
              inactiveColor: Colors.grey,
              min: 0.0,
              max: total.inSeconds.toDouble() ,
              value: current.inSeconds.toDouble(),
              onChanged: (double value){
                if(current.inSeconds.toDouble() == total.inSeconds.toDouble()){
                  print("Song playback comes to an end!");
                }
                setState(() {
                  seekToPosition(value.toInt());
                  value = value;
                });
              }),

          Row(
            children: [
              const Spacer(),
              Center(
                child: Text("$audioPosition/$audioDuration", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 35), textAlign: TextAlign.center,),
              ),
              const Spacer(),
            ],
          )
        ],
      ),
    );
  }

  seekToPosition(int second){
    Duration newDuration = Duration(seconds : second);
    player.seek(newDuration);
  }

  playChoosedSong() {
    // On init the class will play the choosed song
    setState(() {
      var song = songs[currentSong];
      song = song.replaceAll("assets/", "");
      player.play(AssetSource(song));
    });
  }

  stopCurrentSongServices(){
    // This is used to prevent any error
    setState(() {
      player.stop();
    });
  }

  playResumeSong(){
    // Check if the song isPlaying or not

    if (isPlaying){
      // Set all values to false
      setState(() {
        isPlaying = false;
        discAnimation("pause");
        player.pause();
      });
    } else {
      setState(() {
        isPlaying = true;
        discAnimation("play");
        player.resume();
      });
    }
  }

  killServices(){
    // This is a method intended to kill current player softly
    // Since killing current player can lead to unexpected errors

    setState(() {
      // First, pause current service
      player.pause();
      // Then, kill the service
      player.stop();
      // Set playing value to true, since we stopped service earlier
      isPlaying = true;
    });
  }



  ClipRRect songControl(){
    // Define control of current song
    // Play, resume, previous song, next song
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
        child : Container(
          height: 90,
        color: Colors.blueAccent,
          child: Row(
            children: [
              //Previous song button
              const Spacer(),
              IconButton(
                  onPressed: () async {
                    await killServices();
                    if (!_controller.isAnimating){
                      discAnimation("play");
                    }
                    skipToNextSong("previous");
                  },
                  icon: const Icon(Icons.skip_previous_rounded, color: Colors.white, size: 45,),

              ),
              const Spacer(),

              // Play or Pause song button
              IconButton(
                  onPressed: (){
                    setState(() {
                      playResumeSong();
                    });
                  },
                icon: Icon( isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded , color: Colors.white, size: 45,),
                ),
              const Spacer(),

              // Next song button
              IconButton(
                onPressed: () async {
                  if (!_controller.isAnimating){
                    discAnimation("play");
                  }
                  await killServices();
                  skipToNextSong("next");
                },
                icon: const Icon(Icons.skip_next_rounded, color: Colors.white, size: 45,),
              ),
              const Spacer(),
            ],
      ),
        )
    );

  }

  Expanded soloPlay(){
    // A feature rich screen to control current song state
    return Expanded(
      child: ListView(
        children: [
          songDetails(),
        ],
      )
    );
  }

  manualChooseSong(int desiredSong){
    // User choosed a song from dialog
    killServices(); // NEEDED
    setState(() {
      player.play(AssetSource(songs[desiredSong].replaceAll("assets/", "")));
      title = songsTitle[desiredSong];
      currentSong = desiredSong;
    });
  }

  Row previewHeader(){
    // This shows a emergent dialog button and fav icon button
    return Row(
      children: [
        // Queue of songs
        IconButton(
            onPressed: (){
              showMoreSongs();
            },
            icon: Icon(Icons.expand_more_rounded, size: 40, color: Colors.black,)),
        const Spacer(),
        IconButton(
            onPressed: (){
              setState(() {
                if (isFav){
                  isFav = false;
                } else {
                  isFav = true;
                }
              });
            },
            icon: Icon(Icons.favorite, size: 40, color: isFav ?  Colors.red : Colors.grey,)),
      ],
    );
  }

   showMoreSongs() {
     // A widget to show next songs in the playlist
     return showDialog(
         context: context,
         builder: (BuildContext context) {
           return StatefulBuilder(
               builder: (context, setState) {
                 return AlertDialog(
                     scrollable: true,
                     backgroundColor: Colors.black,
                     content: Container(
                         width: double.maxFinite,
                         height: double.maxFinite,
                         child: Column(
                             children: [
                               const SizedBox(height: 25,),
                               Row(
                                 children: const [
                                   Spacer(),
                                   Text("En Reproducción",
                                     style: TextStyle(color: Colors.white,
                                         fontWeight: FontWeight.bold,
                                         fontSize: 30),
                                     textAlign: TextAlign.center,),
                                   Spacer(),
                                 ],
                               ),
                               const SizedBox(height: 25,),
                               SizedBox(
                                   width: double.maxFinite,
                                   height: double.maxFinite,
                                   child: Column(
                                       children: [
                                         Expanded(
                                             child: ListView.builder(
                                                 shrinkWrap: true,
                                                 itemCount: songsTitle.length,
                                                 itemBuilder: (context, index) {
                                                   return Column(
                                                     children: [
                                                       ClipRRect(
                                                         borderRadius: BorderRadius
                                                             .circular(
                                                             25),
                                                         child: InkWell(
                                                           onTap: () {
                                                             manualChooseSong(index);
                                                             Navigator.pop(context);
                                                             showMoreSongs();
                                                           },
                                                           child: Card(
                                                               shadowColor: Colors
                                                                   .grey,
                                                               color: currentSong ==
                                                                   index
                                                                   ? Colors
                                                                   .white
                                                                   : Colors
                                                                   .black,
                                                               child: ListTile(
                                                                 leading: Image
                                                                     .asset(
                                                                     disc),
                                                                 title: Row(
                                                                   children: [
                                                                     const Spacer(),
                                                                     Text(
                                                                       songsTitle[index],
                                                                       style: TextStyle(
                                                                           color: currentSong ==
                                                                               index
                                                                               ? Colors
                                                                               .black
                                                                               : Colors
                                                                               .white),
                                                                       textAlign: TextAlign
                                                                           .center,),
                                                                     const Spacer(),
                                                                   ],
                                                                 ),
                                                               )
                                                           ),
                                                         ),
                                                       ),
                                                     ],
                                                   );
                                                 }
                                             )
                                         ),
                                       ]
                                   )
                               )
                             ]
                         )
                     )
                 );
               }
             );
           }
           );
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
        backgroundColor: Colors.white,
        title : previewHeader(),
      ),
      body: Column(
        children: [
          soloPlay(),
          if (isControlVisible)
          Stack(
              children : [
                songControl(),
                const SizedBox(height: 20,),
              ]
          ),
        ]
      )
    ),
    );
  }
}