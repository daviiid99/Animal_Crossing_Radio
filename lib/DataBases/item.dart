import '../Dependencies/dependencies.dart';

class Item{
  Item({
    required this.itemName,
    required this.itemPicture,
    required this.itemBuyPrice,
    required this.itemSalePrice,
});

  final String itemName;
  final String itemPicture;
  final int itemBuyPrice;
  final int itemSalePrice;

  static const itemsTable = """
  CREATE TABLE IF NOT EXISTS items(
  itemName TEXT PRIMARY KEY,
  itemPicture TEXT,
  itemBuyPrice INTEGER,
  itemSalePrice INTEGER);
  """;

  Map<String,dynamic> toMap(){
    return {
      "itemName" :  itemName,
      "itemPicture" :  itemPicture,
      "itemBuyPrice" : itemBuyPrice,
      "itemSalePrice" : itemSalePrice,
    };
  }

  createItemsTable() async{
    // A simple method to create the items table
    final Database db = await openDatabase("songs.db");

    db.transaction((txn) => txn.execute(itemsTable));
  }

  insertIntoTable(Item item) async {
    // A simple method to insert an item entry to database
    final Database db = await openDatabase("songs.db");

    db.insert("items",
        item.toMap());
  }

  Future<Map<String,dynamic>> retrieveItemsToMap() async {
    // Request all available items in database

    Future<Map<String,dynamic>> addItemToMap(List<Map<String,dynamic>> rawItems) async {
      Map<String, dynamic> items = {};

      for (Map<String, dynamic> item in rawItems) {
        if(!items.containsKey(item["itemName"])){
          items[item["itemName"]] = [];
          items[item["itemName"]] = [item["itemPicture"], item["itemBuyPrice"], item["itemSalePrice"]];
        }
      }

      return items;
    }

    final Database db = await openDatabase("songs.db");
    List<Map<String,dynamic>> rawItems = await db.query("items");
    Map<String,dynamic> items = await addItemToMap(rawItems);

    return items;

  }

}