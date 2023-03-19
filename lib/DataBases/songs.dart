import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

class Songs{
  @override
  Songs({
   required this.name,
   required this.uri,
   required this.logo,
   required this.title,
  });

  final String name;
  final String uri;
  final String logo;
  final String title;
  late Database db;

  static const songsTable = """
  CREATE TABLE IF NOT EXISTS songs(
  id INTEGER PRIMARY KEY,
  name TEXT,
  uri TEXT,
  logo TEXT,
  title TEXT);
  """;

  Map<String, dynamic> toMap(){
    return {
      "name" : name,
      "uri" : uri,
      "logo" : logo,
      "title" : title
    };
  }

  createTable() async {
    // A method to create a transaction to create the table
    db = await openDatabase("songs.db");
    db.transaction((txn)  async{
      await txn.execute(songsTable);
    });
  }

  void insertRowIntoTable(Songs song) async {
    db = await openDatabase("songs.db");
    db.insert(
    "songs",
    song.toMap());
  }

  Future<Map<String, dynamic>> retrieveSongs() async {

    Map<String, dynamic> joinSongsIntoMap(List<Map<String, dynamic>> songs, Map<String, dynamic> finalSongs){
      // This method receives a list of maps
      // Iterates every map
      for (Map<String, dynamic> song in songs){
          finalSongs[song["name"]] = [];
          finalSongs[song["name"]] = [song["uri"], song["logo"], song["title"]];
      }
      return finalSongs;
    }

    db = await openDatabase("songs.db");
    List<Map<String, dynamic>> songs = await db.query("songs");
    Map<String, dynamic> finalSongs = {};
    finalSongs = await joinSongsIntoMap(songs, finalSongs);

    return finalSongs;
  }



}