import 'package:sqflite/sqflite.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';

class User {

  const User({
  required this.name,
  required this.picture,
  required this.genre,
  required this.date_of_birth,
  required this.bells,
  required this.library,
});

  final String name;
  final String picture;
  final String genre;
  final String date_of_birth;
  final int bells;
  final String library;


  static const usersTable =
  """ 
  CREATE TABLE users(
   id INTEGER PRIMARY KEY,
   name TEXT,
   picture TEXT,
   genre TEXT,
   date_of_birth TEXT,
   bells INTEGER,
   library TEXT);
  """;

  Map<String, dynamic> toMap() {
    return {
      "name" : name,
      "picture" : picture,
      "genre" : genre,
      "date_of_birth" : date_of_birth,
      "bells" :  bells,
      "library" : library,
    };
  }

  createUsersTable() async {
    // A method to create the desired table inside the database
    final Database db = await openDatabase("songs.db");

    db.transaction((txn) => txn.execute(usersTable));
  }

  insertUsers(User user) async {
    // A method to insert users inside the users table
    final Database db = await openDatabase("songs.db");

    db.insert(
    "users",
      user.toMap(),
    );
  }

  Future<Map<String, dynamic>> retrieveUser() async {
    // A method to read users from database
    // Add all available users into a Hash Map

    Future<Map<String, dynamic>> addUsers(List<Map<String, dynamic>> users) async {
      Map<String, dynamic> temp =  {};

      for (Map<String, dynamic> user in users){
        for (String key in user.keys){
          if (!temp.containsKey(user["name"])){
            temp[user["name"]] = [];
            temp[user["name"]] = [user["picture"], user["genre"], user["date_of_birth"], user["bells"], user["library"]];
          }
        }
      }
      return temp;
    }

    final Database db = await openDatabase("songs.db");
    List<Map<String, dynamic>> usersMaps = await db.query("users");
    Map<String, dynamic> users = {};
    users = await addUsers(usersMaps);

    return users;

  }


}