import '../Dependencies/dependencies.dart';

class Register {
  Register({
    required this.userName,
    required this.userPassword,
    required this.keepLogin,
});

  final String userName;
  final String userPassword;
  final int keepLogin;

  static const registerTable = """
    CREATE TABLE IF NOT EXISTS register(
      userName TEXT PRIMARY KEY,
      userPassword TEXT,
      keepLogin INTEGER);
  """;

  Map<String,dynamic> toMap(){
    return {
      "userName" : userName,
      "userPassword" : userPassword,
      "keepLogin" : keepLogin
    };
  }

  void createTable() async {
    // A simple method to create a table of users
    final Database db = await openDatabase("songs.db");

    db.transaction((txn) => txn.execute(registerTable));
  }

  void insertRowIntoTable(Register user) async {
    // A simple method to insert new users into table
    final Database db = await openDatabase("songs.db");

    db.insert("register",
        user.toMap());
  }

  Future<Map<String,dynamic>> retrieveUsers() async {
    // A simple method to retrieve users from database

    Map<String,dynamic> getUsers(List<Map<String,dynamic>> rawUsers) {
      // Read the list of users and get a list of users
      Map<String,dynamic> users = {};

      for (Map<String,dynamic> user in rawUsers){
        if(!users.containsKey(user["userName"])){
          users[user["userName"]] =  [];
          users[user["userName"]] =  [user["userPassword"], user["keepLogin"]];
        }
      }

      return users;
    }

    final Database db = await openDatabase("songs.db");
    List<Map<String,dynamic>> rawUsers = await db.query("register");
    Map<String,dynamic> users = getUsers(rawUsers);

    return users;
  }
}