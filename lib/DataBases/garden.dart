import '../Dependencies/dependencies.dart';

class Garden{

  Garden({
    required this.name,
    required this.isTree,
    required this.isPalmTree,
    required this.isFlowers,
});

  final String name;
  final int isTree;
  final int isPalmTree;
  final int isFlowers;

  static const gardenTable =  """
    CREATE TABLE IF NOT EXISTS garden(
      name TEXT PRIMARY KEY,
      isTree INTEGER,
      isPalmTree INTEGER,
      isFlowers INTEGER);
  """;

  factory Garden.fromMap(Map<String, dynamic> map) => Garden(
      name: map["name"],
      isTree: map["isTree"],
      isPalmTree: map["isPalmTree"],
      isFlowers: map["isFlowers"]);

  Map<String,dynamic> toMap(){
    return{
      "name" : name,
      "isTree" :  isTree,
      "isPalmTree" :  isPalmTree,
      "isFlowers" : isFlowers,
    };
  }

  static createTable() async {
    // A simple method to access database and create garden's table
    final Database db = await openDatabase("songs.db");

    db.transaction((txn) => txn.execute(gardenTable));
  }

  insertGardenIntoTable(Garden garden) async {
    // This method inserts every garden into database
    final Database db = await openDatabase("songs.db");

    db.insert("garden",
        garden.toMap());
  }

  modifyGarden(Garden modifiedGarden) async {
    // This method is executed in case user needs to
    final Database db = await openDatabase("songs.db");

    db.update("garden",
        modifiedGarden.toMap());
  }

  static Future<List<Garden>> retrieveGardens() async {
    // This method asks to database for current saved gardens

    List<Garden> getGardens(List<Map<String,dynamic>> rawGardens) {
      // Return a list of gardens
      List<Garden> gardens = [];

      for(Map<String,dynamic> garden in rawGardens){
        Garden currentGarden = Garden.fromMap(garden);
        gardens.add(currentGarden);
      }

      return gardens;
    }


    final Database db = await openDatabase("songs.db");
    List<Map<String,dynamic>> rawGardens = await db.query("garden");
    List<Garden> gardens = getGardens(rawGardens);

    return gardens;
  }


}