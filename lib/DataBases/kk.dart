import 'package:sqflite/sqflite.dart';
import 'package:async/async.dart';

class KK{
  KK({
    required this.songName,
    required this.songArt,
    required this.songPath,
});

  final String songName;
  final String songArt;
  final String songPath;

  static const kkTable = """
  CREATE TABLE kkSongs(
  songName TEXT PRIMARY KEY,
  songArt TEXT,
  songPath TEXT);
  """;

createTable() async {
  // Add and create kk table in current transaction
  final Database db = await openDatabase("songs.db");

  db.transaction((txn) => txn.execute(kkTable));
}

Map<String, dynamic> toMap(){
  return {
    "songName" :  songName,
    "songArt" : songArt,
    "songPath" : songPath
  };
}

insertSongIntoTable(KK song) async {
  // A simple method that receives a song and creates an entry for it
  final Database db = await openDatabase("songs.db");

  db.insert("kkSongs",
      song.toMap());
}

  Future<Map<String, dynamic>> retrieveTotaSongs() async {
  // A method that return every song from our K.K. :)

  Map<String, dynamic> addSongsToMap(List<Map<String, dynamic>> rawSongs){
    // This method receives the whole list of maps from the database
    // iterates every song and return a map with a more comprehensive format
    Map<String,dynamic> songs = {};

    for (Map<String,dynamic> song in rawSongs){
      if(!songs.containsKey(song["songName"])){
        songs[song["songName"]] =  [];
        songs[song["songName"]] =  [song["songArt"], song["songPath"]];
      }
    }

    return songs;
  }

  final Database db = await openDatabase("songs.db");
  List<Map<String,dynamic>> rawSongs = await db.query("kkSongs");
  Map<String,dynamic> songs = await addSongsToMap(rawSongs);

  return songs;
}

}