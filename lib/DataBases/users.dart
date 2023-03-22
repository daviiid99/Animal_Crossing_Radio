import '../Dependencies/dependencies.dart';

class User {

  const User({
  required this.name,
  required this.picture,
  required this.genre,
  required this.dateOfBirth,
  required this.bells,
  required this.library,
  required this.userID,
});

  final String name;
  final String picture;
  final String genre;
  final String dateOfBirth;
  final int bells;
  final String library;
  final String userID;


  static const usersTable =
  """ 
  CREATE TABLE users(
   id INTEGER PRIMARY KEY,
   name TEXT,
   picture TEXT,
   genre TEXT,
   date_of_birth TEXT,
   bells INTEGER,
   library TEXT,
   userID TEXT,
   FOREIGN KEY(userID) REFERENCES Register(userName));
  """;

  Map<String, dynamic> toMap() {
    return {
      "name" : name,
      "picture" : picture,
      "genre" : genre,
      "date_of_birth" : dateOfBirth,
      "bells" :  bells,
      "library" : library,
      "userID" : userID,
    };
  }

  factory User.fromMap(Map<String,dynamic> map) => User (
    name: map["name"],
    picture: map["picture"],
    genre: map["genre"],
    dateOfBirth: map["date_of_birth"],
    bells: map["bells"],
    library: map["library"],
    userID: map["userID"],
  );

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

  static Future<List<User>> retrieveUser() async {
    // A method to read users from database
    // Add all available users into a Hash Map

    List<User> addUsers(List<Map<String, dynamic>> rawUsers) {
      List<User> users = [];

      for (Map<String,dynamic> user in rawUsers){
        User currentUser = User.fromMap(user);
        users.add(currentUser);
      }

      return users;
    }

    final Database db = await openDatabase("songs.db");
    List<Map<String, dynamic>> usersMaps = await db.query("users");
    List<User> users = addUsers(usersMaps);

    return users;

  }


}