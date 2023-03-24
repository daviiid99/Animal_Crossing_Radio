import '../Screens/screen.dart';

class Pockets{
  // If no pocket is available for current user, we need to create an empty pocket with no item inside

  PocketDatabase bolsillo = PocketDatabase(itemField: "itemField", itemPicture: "itemPicture", itemName: "itemName", itemAmount: "itemAmount", user: "user");

  Map<String,dynamic> emptyPocket(String userName) {
    return {
      // First Row // 1-3
      "0": ["assets/items/caña.png", "Caña", "1", userName],
      "1": ["assets/items/red.png", "Red", "1", userName],
      "2": ["assets/items/pala.png", "Pala", "1", userName],

      // Second Row // 4-6
      "3": ["", "", "", userName],
      "4": ["", "", "", userName],
      "5": ["", "", "", userName],

      // Third Row //7-9
      "6": ["", "", "", userName],
      "7": ["", "", "", userName],
      "8": ["", "", "", userName],

      // Four Row //10-12
      "9": ["", "", "", userName],
      "10": ["", "", "", userName],
      "11": ["", "", "", userName],
    };
  }

  createPocket(String userName) async {
    // A method to create an empty pocket for current user

    // First, create a pocket table
    bolsillo.createPocketTable();

    // Then, create all pocket entries
    Map<String,dynamic> pocket = await emptyPocket(userName);
    for (String field in pocket.keys){
      PocketDatabase pockets = PocketDatabase(itemField: field, itemPicture: pocket[field][0], itemName: pocket[field][1], itemAmount: pocket[field][2], user: pocket[field][3]);
      pockets.insertItemIntoPocket(pockets);
    }
  }
}