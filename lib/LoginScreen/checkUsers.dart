import 'package:flutter/material.dart';
import '../Screens/screen.dart';
import 'package:meta/meta.dart';

class CheckUsers{

  static Register register = Register(userName: "userName", userPassword: "userPassword", keepLogin: 0);

  static readDataBaseUsers() async {
    // Check if user is registered in database
    List<Register> users = [];

    try {
      users = await register.retrieveUsers();
    } catch (e){
      register.createTable();

    }

    return users.isNotEmpty ? true : false;
  }

  static verifyUser(String userName, String userPassword) async {
    // Verify entered userName and password
    bool isLoginPassed = false;
    bool userExists = false;
    String log = "";

    List<Register> users = [];
    users = await register.retrieveUsers();

    for (Register user in users) {
      if (user.userName == userName) {
        userExists = true;
        if (user.userPassword == userPassword) {
          // Verified!
          isLoginPassed = true;
          log = "success";
        } else {
          log = "bad_password";
          isLoginPassed = false;
        }
      }
    }

    if (!userExists) {
      log = "unknown_name";
    }

      return log;


  }

  static Future<List<User>> retrieveUsers() async {
    // Retrieve existing users in database
    List<User> users = [];

    try {
      users = await User.retrieveUser();
    } catch (e) {
      users = [];
    }
    return users;
  }

  static registerUser(String userName, String userPassword, int keepLogin) async {
    // Create an entry for given user and password
    Register newUser = Register(userName: userName, userPassword: userPassword, keepLogin: keepLogin);
    register.insertRowIntoTable(newUser);

    return true;

  }


}