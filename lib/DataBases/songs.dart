import '../Dependencies/dependencies.dart';

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

  factory Songs.fromMap(Map<String,dynamic> map) => Songs(
    name: map["name"],
    uri: map["uri"],
    logo: map["logo"],
    title: map["title"],
  );

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

  static Future<List<Songs>> retrieveSongs() async {

    List<Songs> getSongs(List<Map<String, dynamic>> rawSongs){
      // This method receives a list of maps
      // Iterates every map
      List<Songs> songs = [];

      for (Map<String, dynamic> song in rawSongs){
          Songs currentSong = Songs.fromMap(song);
          songs.add(currentSong);
      }
      return songs;
    }

    final Database db = await openDatabase("songs.db");
    List<Map<String, dynamic>> rawSongs = await db.query("songs");
    List<Songs> songs = getSongs(rawSongs);

    return songs;
  }

}