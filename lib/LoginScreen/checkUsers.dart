import 'package:flutter/material.dart';
import '../Screens/screen.dart';
import 'package:meta/meta.dart';

class CheckUsers{

  static Register register = Register(userName: "userName", userPassword: "userPassword");

  static readDataBaseUsers() async {
    // Check if user is registered in database
    Map<String,dynamic> users = {};

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
    String log = "";

    Map<String,dynamic> users = {};
    users = await register.retrieveUsers();

    if(users.containsKey(userName)){
      if (users[userName] == userPassword){
        // Verified!
        isLoginPassed = true;
        log = "success";

      } else {
        log = "bad_password";
        isLoginPassed = false;
      }
    } else {
      log = "unknown_name";
    }
    return log;
  }

  static registerUser(String userName, String userPassword) async {
    // Create an entry for given user and password
    Register newUser = Register(userName: userName, userPassword: userPassword);
    register.insertRowIntoTable(newUser);

    return true;

  }


}