import '../Dependencies/dependencies.dart';

class PlaylistDataBase{
  const PlaylistDataBase({
    required this.name,
    required this.song,
});

  final String name;
  final String song;

  static const playlistTable = """
  CREATE TABLE playlist(
  id INTEGER PRIMARY KEY,
  song TEXT);
  """;

  createPlaylistTable() async {
    // A method to create playlist table once
    final Database db = await openDatabase("playlist");
    db.transaction((txn) => txn.execute("playlist"));
  }

  Map<String, dynamic> toMap(){
    return {
      "name" : name,
      "song" : song,
    };
  }

  insertPlaylistValues(PlaylistDataBase playlist) async {
    // A method to add values into a playlist
    final Database db = await openDatabase("playlist");

    db.insert(
      "playlist",
        playlist.toMap());
  }

  retrievePlaylistEntries() async {
    // A method to retrieve a list a map of every playlist
    // Including all songs in each playlist

    Future<Map<String, dynamic>> addSongsToPlaylists(List<Map<String, dynamic>> playlists) async {
      // This method iterate every playlist
      // Add all songs into an array for each
      Map<String, dynamic> temp = {};

      for (Map<String, dynamic> playlist in playlists){
        if(!temp.containsKey(playlist["name"])){
          temp[playlist["name"]] = [];
          temp[playlist["name"]] = [playlist["song"]];
        } else if (!temp[playlist["name"]].contains(playlist["songs"])){
          temp[playlist["name"]].add(playlist["songs"]);
        }
      }
      return temp;
    }

    final Database db = await openDatabase("playlist");
    List<Map<String, dynamic>> playlists = await db.query("playlist");
    Map<String, dynamic> playlist = await addSongsToPlaylists(playlists);
  }






}