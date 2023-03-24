import '../DataBases/users.dart';
import '../Data/kk_songs.dart';
import '../Data/items.dart';
import '../Data/pockets.dart';

class Transaction{
  // This class will handle database creation on first boot
  // Will create the database and all tables.

  createTable(User user){
    // This should be executed in the following order
    createUsersTable(user);
    createTotakekeTable();
    createItemsTable();
    createPocketTable(user.name);
  }

  createUsersTable(User user){
    // Create users table && insert current user into table
    user.createUsersTable();
    user.insertUsers(user);
  }

  createTotakekeTable(){
    // Create totakeke table && insert all songs into table
    KkSongs songs = KkSongs();
    songs.addSongsToDatabase();
  }

  createItemsTable(){
    // Create items table && insert all items into database
    Items items = Items();
    items.addAllItemsToDataBase();
  }

  createPocketTable(String userName){
    // Create pocket table && insert empty values into current user pocket
    Pockets pockets = Pockets();
    pockets.createPocket(userName);
  }

}