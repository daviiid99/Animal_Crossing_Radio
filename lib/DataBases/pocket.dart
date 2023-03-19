import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class PocketDatabase {
  PocketDatabase({
    required this.itemField,
    required this.itemPicture,
    required this.itemName,
    required this.itemAmount,
    required this.user,
});

  final String itemField;
  final String itemPicture;
  final String itemName;
  final String itemAmount;
  final String user;

  static const pocketTable = """
  CREATE TABLE pocket(
  itemField TEXT PRIMARY KEY,
  itemPicture TEXT,
  itemName TEXT,
  itemAmount TEXT,
  user TEXT,
  FOREIGN KEY(user) REFERENCES users(name)
  );
  """;

  Map<String,dynamic> toMap(){
    return{
      "itemField" : itemField,
      "itemPicture" : itemPicture,
      "itemName" : itemName,
      "itemAmount" : itemAmount,
      "user" :  user,
    };
  }

  createPocketTable() async {
    // A method to create pocket table
    final Database db = await openDatabase("songs.db");

    db.transaction((txn) => txn.execute(pocketTable));
  }

  insertItemIntoPocket(PocketDatabase field) async {
    // Insert an item into the pocket
    final Database db = await openDatabase("songs.db");

    db.insert("pocket",
        field.toMap());
  }

  Future<Map<String,dynamic>> retrievePocketFields(String userName) async {
    // Return all item fields in current user pocket

    Map<String,dynamic> addFieldToPocketMap(List<Map<String,dynamic>> rawPocket, String userName){
      Map<String,dynamic> pocket = {
      };

      for (Map<String,dynamic> field in rawPocket){
        if(!pocket.containsKey(field["itemField"]) && field["user"] == userName){
            pocket[field["itemField"]] = [field["itemPicture"], field["itemName"], field["itemAmount"], field["user"]];
          }
      }

      return pocket;

    }

    final Database db = await openDatabase("songs.db");
    List<Map<String,dynamic>> rawPocket = await db.query("pocket");
    Map<String,dynamic> pocket = await addFieldToPocketMap(rawPocket, userName);

    return pocket;
  }

}