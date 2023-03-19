import '../DataBases/item.dart';

class Items{

  Item database = Item(itemName: "itemName", itemPicture: "itemPicture", itemBuyPrice: 0, itemSalePrice: 0);

  final Map<String,dynamic> items = {
    "Arcilla" :  ["assets/items/arcilla.png", 0, 500],
    "Avispero" :  ["assets/items/avispero.png", 0, 500],
    "30.000 bayas" :  ["assets/items/bolsa_grande.png", 0, 0],
    "10.000 bayas" : ["assets/items/bolsa_mediana.png", 0, 0],
    "1.000 bayas" : ["assets/items/bolsa.png", 0, 0],
    "Caña" : ["assets/items/caña.png", 0, 0],
    "Cereza" : ["assets/items/cereza.png", 500, 500],
    "Escarabajo Elefante" : ["assets/items/escarabajo_elefante.png", 0, 3000],
    "Escarabajo Hercules" : ["assets/items/escarabajo_hercules.png", 0, 5000],
    "Hacha de piedra" : ["assets/items/hacha_piedra.png", 500, 200],
    "Hacha" : ["assets/items/hacha.png", 1000, 700],
    "Madera flexible" : ["assets/items/madera_flexible.png", 0, 300],
    "Madera normal" :  ["assets/items/madera_normal.png", 0, 300],
    "Madera rígida" :  ["assets/items/madera_rigida.png", 0, 300],
    "Manzana" : ["assets/items/manzana.png", 500, 500],
    "Melocotón" :  ["assets/items/melocoton.png", 500,500],
    "500 bayas" : ["assets/items/moneda.png", 0,0],
    "Naranja" : ["assets/items/naranja.png", 500, 500],
    "Oro" : ["assets/items/oro.png", 0, 3000],
    "Pala" : ["assets/items/pala.png", 0, 0],
    "Pepita de hierro" : ["assets/items/pepita_hierro.png", 0, 1000],
    "Pera" : ["assets/items/pera.png", 500, 500],
    "Piedra" : ["assets/items/piedra.png", 0, 300],
    "Rama" : ["assets/items/rama.png", 0, 100],
    "Red" : ["assets/items/red.png", 0, 0],
    "Regadera" : ["assets/items/regadera.png", 0, 0],
    "Tirachinas" : ["assets/items/tirachinas.png", 0, 0],
  };

  addAllItemsToDataBase() async {
    // A simple method to create items table and add all items to database

    // First, create the items table
    database.createItemsTable();

    // Then, insert all items inside
    for (String currentItem in items.keys){
      Item item = Item(itemName: currentItem, itemPicture: items[currentItem][0], itemBuyPrice: items[currentItem][1], itemSalePrice: items[currentItem][2]);
      item.insertIntoTable(item);
    }
  }
}