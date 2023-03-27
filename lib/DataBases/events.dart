import '../Dependencies/dependencies.dart';

class Events{

  Events({
    required this.message,
    required this.npc,
  });

  final String message;
  final String npc;

  static const eventsTable = """
    CREATE TABLE events(
    message TEXT PRIMARY KEY,
    npc TEXT);
  """;

  createTable() async {
    // A method to create a table
    final Database db = await openDatabase("songs.db");

    db.transaction((txn) => txn.execute(eventsTable));
  }

  Map<String,dynamic> toMap(){
    return{
      "message" :  message,
      "npc" : npc,
    };
  }

  factory Events.fromMap(Map<String,dynamic> map) => Events(
    message: map["message"],
    npc: map["npc"],
  );

  insertEventIntoTable(Events event) async {
    // A method to add events into table
    final Database db = await openDatabase("songs.db");

    db.insert("events",
        event.toMap());
  }

  static Future<List<Events>> retrieveEventsFromDataBase() async {
    // A method that request a list of events to database

    List<Events> addEventToList(List<Map<String,dynamic>> rawEvents){
      // Read every event from the list
      // Creates an instance of each map and adds it into a new list
      List<Events> events = [];

      for (Map<String,dynamic> event in rawEvents){
        Events currentEvent = Events.fromMap(event);
        events.add(currentEvent);
      }

      return events;
    }

    final Database db = await openDatabase("songs.db");
    List<Map<String,dynamic>> rawEvents = await db.query("events");

    List<Events> events = addEventToList(rawEvents);

    return events;
  }

}