import 'package:sqflite/sqflite.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';

class AnnouncementDataBase{

  AnnouncementDataBase({
    required this.date,
});

  final String date;

  static const announcementsTable = """
  CREATE TABLE announcements(
  date TEXT PRIMARY KEY
  );
  """;

  Map<String, dynamic> toMap(){
    return {
      "date" : date,
    };
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

  Future<List<String>> retrieveDates() async {
    // A method to retrieve all existing dates in database

    List<String> addDateToList(List<Map<String, dynamic>> rawDates) {
      List<String> dates = [];

      for (Map<String, dynamic> date in rawDates) {
        if (!dates.contains(date[date.keys.first])) {
          dates.add(date[date.keys.first]);
        }
      }

      return dates;
    }

    final Database db = await openDatabase("songs.db");
    List<Map<String,dynamic>> rawDates = await db.query("announcements");
    List<String> dates = await  addDateToList(rawDates);

    return dates;
  }

}