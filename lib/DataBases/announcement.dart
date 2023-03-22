import '../Dependencies/dependencies.dart';

class AnnouncementDataBase{

  AnnouncementDataBase({
    required this.date,
});

  final String date;

  static const announcementsTable = """
  CREATE TABLE IF NOT EXISTS announcements(
  date TEXT PRIMARY KEY
  );
  """;

  Map<String, dynamic> toMap(){
    return {
      "date" : date,
    };
  }

  factory AnnouncementDataBase.fromMap(Map<String,dynamic> map){
    return AnnouncementDataBase(
      date : map["date"],
    );
  }

  createTable() async {
    // A simple method to create the announcements table
    final Database db = await openDatabase("songs.db");

    db.transaction((txn) => txn.execute(announcementsTable));

  }

  insertRowIntoTable(AnnouncementDataBase date) async {
    // A simple method to insert a date into announcements table
    final Database db = await openDatabase("songs.db");

    db.insert("announcements",
        date.toMap());
  }

  Future<List<AnnouncementDataBase>> retrieveDates() async {
    // A method to retrieve all existing dates in database

    List<AnnouncementDataBase> addDateToList(List<Map<String, dynamic>> rawDates) {
      List<AnnouncementDataBase> dates = [];
      AnnouncementDataBase currentAnnounce = AnnouncementDataBase(date: "date");

      for (Map<String, dynamic> date in rawDates) {
        currentAnnounce = AnnouncementDataBase.fromMap(date);
        if (!dates.contains(currentAnnounce)){
          dates.add(currentAnnounce);
        }
      }

      return dates;
    }

    final Database db = await openDatabase("songs.db");
    List<Map<String,dynamic>> rawDates = await db.query("announcements");
    List<AnnouncementDataBase> dates = await  addDateToList(rawDates);

    return dates;
  }

}