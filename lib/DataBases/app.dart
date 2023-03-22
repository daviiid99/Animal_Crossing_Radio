import '../Dependencies/dependencies.dart';


class App{
  App({
    required this.theme,
    required this.version,
    required this.version_date,
    required this.changelog,
});

  final String theme;
  final String version;
  final String version_date;
  final String changelog;

  static const appTable = """
  CREATE TABLE IF NOT EXISTS app(
  version TEXT PRIMARY KEY,
  theme TEXT,
  version_date TEXT,
  changelog TEXT,
  """;

  Map<String,dynamic> toMap(){
    return {
    "version" : version,
    "version_date" : version_date,
    "theme" :  theme,
    "changelog" : changelog,
  };
}

  createTable() async {
    // A method to add and create table in current transaction
    final Database db = await openDatabase("songs.db");
    db.transaction((txn) => txn.execute(appTable));
    db.close();
  }

  insertRowTable(App app) async {
    // A method to insert new version entries into app table
    final Database db = await openDatabase("songs.db");
    db.insert("app",
        app.toMap());
  }

  Future<Map<String, dynamic>> retrieveLatestVersion() async {
    // This method will compare and return only latest version
    Future<Map<String, dynamic>> getLatest(List<Map<String, dynamic>> versions) async {
      List<double> versionStr = [];
      List<String> versionDate = [];
      List<String> versionChangelog = [];
      List<String> versionTheme = [];
      int index = 0;

      // Add all available versions into a temp list
      for (Map<String, dynamic> version in versions){
       for (String ver in version["version"]){
         if (!versionStr.contains(ver)){
           versionStr.add(double.parse(ver));
         }
       }
       for (String verDate in version["version_date"]){
         versionDate.add(verDate);
       }

       for (String changelog in version["changelog"]){
         versionChangelog.add(changelog);
       }

       for (String theme in version["theme"]){
         versionTheme.add(theme);
       }

      }

      // Get max value // Most recent version
      var max = versionStr[0];
      for (double ver in versionStr){
        if (ver > max){
          max = ver;
          index = versionStr.indexOf(ver);
        }
      }

      // Return latest version with all atributes
      return {
        "${versionStr[index]}" :
            [version_date[index], versionChangelog[index], versionTheme[index]]
      };
    }

    final Database db = await openDatabase("songs.db");
    List<Map<String, dynamic>> versions = await db.query("app");
    Map<String,dynamic> latestVersion = await getLatest(versions);

    return latestVersion;
  }




}