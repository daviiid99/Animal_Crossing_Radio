import '../Dependencies/dependencies.dart';

class Library{
  Library({
    required this.name,
    required this.playlist,
});

  final String name;
  final String playlist;

  static const playlistTable =  """
  CREATE TABLE library(
    id INT PRIMARY KEY,
    name TEXT,
    playlist TEXT,
    user TEXT,
    FOREIGN KEY(user) REFERENCES users(name)
    );
  """;

  Map<String, dynamic> toMap(){
    return {
      "name" : name,
      "playlist" : playlist,
    };
  }

  createTable() async {
    // A method to create a library table
    final Database db = await openDatabase("songs.db");

    db.transaction((txn) => txn.execute("library"));
  }

  insertLibrary(Library library) async {
    // A method to insert entries into library table
    final Database db = await openDatabase("songs.db");

    db.insert(
        "library",
        library.toMap());
  }

  Future<Map<String, dynamic>> retrieveLibraryEntries() async {

    Future<Map<String, dynamic>> getLibraryEntries(List<Map<String, dynamic>> libraries) async {
      Map<String, dynamic> temp = {};

      for (Map<String, dynamic> library in libraries){
        for (String key in library.keys){
          if (!temp.containsKey(library["name"])) {
            temp[library["name"]] = [];
            temp[library["name"]] = [library["playlist"]];
          } else if (!temp[library["name"]].contains(library["playlist"])) {
            temp[library["name"]].add(library["playlist"]);
          }
        }
      }

      return temp;
    }

    // A method to return a map with all available libraries in database
    final Database db = await openDatabase("songs.db");
    List<Map<String, dynamic>> libraries = await db.query("library");
    Map<String, dynamic> library = await getLibraryEntries(libraries);

    return library;


  }

}