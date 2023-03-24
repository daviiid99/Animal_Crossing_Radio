import 'package:async/async.dart';
import '../Screens/screen.dart';


class Song{

  Songs database = Songs(name: "name", uri: "uri", logo: "logo", title: "title");

  Map<String, dynamic> songsData = {
    "GC" : {
      "Tema Principal" : ["assets/songs/gc/title.mp3", "assets/disc/gc.png", "Animal Crossing : Population Growing"],
      "12AM - Population Growing"  : ["assets/songs/gc/12AM.mp3", "assets/disc/gc.png", "Animal Crossing : Population Growing"],
      "1AM - Population Growing"   : ["assets/songs/gc/1AM.mp3", "assets/disc/gc.png", "Animal Crossing : Population Growing"],
      "2AM - Population Growing"   : ["assets/songs/gc/2AM.mp3", "assets/disc/gc.png", "Animal Crossing : Population Growing"],
      "3AM - Population Growing"   : ["assets/songs/gc/3AM.mp3", "assets/disc/gc.png", "Animal Crossing : Population Growing"],
      "4AM - Population Growing"   : ["assets/songs/gc/4AM.mp3", "assets/disc/gc.png", "Animal Crossing : Population Growing"],
      "5AM - Population Growing"   : ["assets/songs/gc/5AM.mp3", "assets/disc/gc.png", "Animal Crossing : Population Growing"],
      "6AM - Population Growing"   : ["assets/songs/gc/6AM.mp3", "assets/disc/gc.png", "Animal Crossing : Population Growing"],
      "7AM - Population Growing"   : ["assets/songs/gc/7AM.mp3", "assets/disc/gc.png", "Animal Crossing : Population Growing"],
      "8AM - Population Growing"   : ["assets/songs/gc/8AM.mp3", "assets/disc/gc.png", "Animal Crossing : Population Growing"],
      "9AM - Population Growing"   : ["assets/songs/gc/9AM.mp3", "assets/disc/gc.png", "Animal Crossing : Population Growing"],
      "10AM - Population Growing"  : ["assets/songs/gc/10AM.mp3", "assets/disc/gc.png", "Animal Crossing : Population Growing"],
      "11AM - Population Growing"  : ["assets/songs/gc/11AM.mp3", "assets/disc/gc.png", "Animal Crossing : Population Growing"],
      "12PM - Population Growing"  : ["assets/songs/gc/12PM.mp3", "assets/disc/gc.png", "Animal Crossing : Population Growing"],
      "1PM - Population Growing"   : ["assets/songs/gc/1PM.mp3", "assets/disc/gc.png", "Animal Crossing : Population Growing"],
      "2PM - Population Growing"   : ["assets/songs/gc/2PM.mp3", "assets/disc/gc.png", "Animal Crossing : Population Growing"],
      "3PM - Population Growing"   : ["assets/songs/gc/3PM.mp3", "assets/disc/gc.png", "Animal Crossing : Population Growing"],
      "4PM - Population Growing"   : ["assets/songs/gc/4PM.mp3", "assets/disc/gc.png", "Animal Crossing : Population Growing"],
      "5PM - Population Growing"   : ["assets/songs/gc/5PM.mp3", "assets/disc/gc.png", "Animal Crossing : Population Growing"],
      "6PM - Population Growing"   : ["assets/songs/gc/6PM.mp3", "assets/disc/gc.png", "Animal Crossing : Population Growing"],
      "7PM - Population Growing"   : ["assets/songs/gc/7PM.mp3", "assets/disc/gc.png", "Animal Crossing : Population Growing"],
      "8PM - Population Growing"   : ["assets/songs/gc/8PM.mp3", "assets/disc/gc.png", "Animal Crossing : Population Growing"],
      "9PM - Population Growing"   : ["assets/songs/gc/9PM.mp3", "assets/disc/gc.png", "Animal Crossing : Population Growing"],
      "10PM - Population Growing"  : ["assets/songs/gc/10PM.mp3", "assets/disc/gc.png", "Animal Crossing : Population Growing"],
      "11PM - Population Growing"  : ["assets/songs/gc/11PM.mp3", "assets/disc/gc.png", "Animal Crossing : Population Growing"]
    },

    "DS" : {
      "Tema Principal - Wild World" : ["assets/songs/ds/title.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
      "12AM - Wild World"  : ["assets/songs/ds/12AM.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
      "1AM - Wild World"   : ["assets/songs/ds/1AM.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
      "2AM - Wild World"   : ["assets/songs/ds/2AM.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
      "3AM - Wild World"   : ["assets/songs/ds/3AM.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
      "4AM - Wild World"   : ["assets/songs/ds/4AM.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
      "5AM - Wild World"   : ["assets/songs/ds/5AM.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
      "6AM - Wild World"   : ["assets/songs/ds/6AM.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
      "7AM - Wild World"   : ["assets/songs/ds/7AM.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
      "8AM - Wild World"   : ["assets/songs/ds/8AM.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
      "9AM - Wild World"   : ["assets/songs/ds/9AM.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
      "10AM - Wild World"  : ["assets/songs/ds/10AM.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
      "11AM - Wild World"  : ["assets/songs/ds/11AM.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
      "12PM - Wild World"  : ["assets/songs/ds/12PM.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
      "1PM - Wild World"   : ["assets/songs/ds/1PM.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
      "2PM - Wild World"   : ["assets/songs/ds/2PM.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
      "3PM - Wild World"   : ["assets/songs/ds/3PM.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
      "4PM - Wild World"   : ["assets/songs/ds/4PM.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
      "5PM - Wild World"   : ["assets/songs/ds/5PM.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
      "6PM - Wild World"   : ["assets/songs/ds/6PM.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
      "7PM - Wild World"   : ["assets/songs/ds/7PM.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
      "8PM - Wild World"   : ["assets/songs/ds/8PM.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
      "9PM - Wild World"   : ["assets/songs/ds/9PM.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
      "10PM - Wild World"  : ["assets/songs/ds/10PM.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
      "11PM - Wild World"  : ["assets/songs/ds/11PM.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
      "Fuegos Artificiales"  : ["assets/songs/ds/fireworks.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
      "Nuevo Hogar"  : ["assets/songs/ds/house.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
      "Almacen Nook"  : ["assets/songs/ds/cranny.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
      "Hermanas Manitas"  : ["assets/songs/ds/able.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
      "Ayuntamiento (Día)"  : ["assets/songs/ds/office_day.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
      "Ayuntamiento (Noche)"  : ["assets/songs/ds/office_night.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
      "Capitán (Taxi)"  : ["assets/songs/ds/taxi.mp3", "assets/disc/ds.png", "Animal Crossing : Wild World"],
    },

    "WII" : {
      "Tema Principal - City Folk"  : ["assets/songs/wii/title.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "En el Bus"  : ["assets/songs/wii/bus.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "Buscando Casa"  : ["assets/songs/wii/house.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "Empleado Nook"  : ["assets/songs/wii/nook.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "Nuevo Hogar"  : ["assets/songs/wii/home.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "Almacén Nook"  : ["assets/songs/wii/cranny.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "SuperNook"  : ["assets/songs/wii/super.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "HiperNook"  : ["assets/songs/wii/hiper.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "Nook's"  : ["assets/songs/wii/nooks.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "12AM - City Folk"  : ["assets/songs/wii/12AM.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "1AM - City Folk"   : ["assets/songs/wii/1AM.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "2AM - City Folk"   : ["assets/songs/wii/2AM.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "3AM - City Folk"   : ["assets/songs/wii/3AM.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "4AM - City Folk"   : ["assets/songs/wii/4AM.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "5AM - City Folk"   : ["assets/songs/wii/5AM.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "6AM - City Folk"   : ["assets/songs/wii/6AM.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "7AM - City Folk"   : ["assets/songs/wii/7AM.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "8AM - City Folk"   : ["assets/songs/wii/8AM.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "9AM - City Folk"   : ["assets/songs/wii/9AM.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "10AM - City Folk"  : ["assets/songs/wii/10AM.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "11AM - City Folk"  : ["assets/songs/wii/11AM.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "12PM - City Folk"  : ["assets/songs/wii/12PM.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "1PM - City Folk"   : ["assets/songs/wii/1PM.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "2PM - City Folk"   : ["assets/songs/wii/2PM.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "3PM - City Folk"   : ["assets/songs/wii/3PM.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "4PM - City Folk"   : ["assets/songs/wii/4PM.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "5PM - City Folk"   : ["assets/songs/wii/5PM.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "6PM - City Folk"   : ["assets/songs/wii/6PM.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "7PM - City Folk"   : ["assets/songs/wii/7PM.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "8PM - City Folk"   : ["assets/songs/wii/8PM.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "9PM - City Folk"   : ["assets/songs/wii/9PM.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "10PM - City Folk"  : ["assets/songs/wii/10PM.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
      "11PM - City Folk"  : ["assets/songs/wii/11PM.mp3", "assets/disc/wii.png", "Animal Crossing : Let's Go To The City"],
    },

    "3DS" : {
      "Tema Principal - New Leaf" : ["assets/songs/3ds/title.mp3", "assets/disc/3ds.png", "Animal Crossing : New Leaf"],
      "12AM - New Leaf" : ["assets/songs/3ds/12AM.mp3", "assets/disc/3ds.png", "Animal Crossing : New Leaf"],
      "1AM - New Leaf" : ["assets/songs/3ds/1AM.mp3", "assets/disc/3ds.png", "Animal Crossing : New Leaf"],
      "2AM - New Leaf" : ["assets/songs/3ds/2AM.mp3", "assets/disc/3ds.png", "Animal Crossing : New Leaf"],
      "3AM - New Leaf" : ["assets/songs/3ds/3AM.mp3", "assets/disc/3ds.png", "Animal Crossing : New Leaf"],
      "4AM - New Leaf" : ["assets/songs/3ds/4AM.mp3", "assets/disc/3ds.png", "Animal Crossing : New Leaf"],
      "5AM - New Leaf" : ["assets/songs/3ds/5AM.mp3", "assets/disc/3ds.png", "Animal Crossing : New Leaf"],
      "6AM - New Leaf" : ["assets/songs/3ds/6AM.mp3", "assets/disc/3ds.png", "Animal Crossing : New Leaf"],
      "7AM - New Leaf" : ["assets/songs/3ds/7AM.mp3", "assets/disc/3ds.png", "Animal Crossing : New Leaf"],
      "8AM - New Leaf" : ["assets/songs/3ds/8AM.mp3", "assets/disc/3ds.png", "Animal Crossing : New Leaf"],
      "9AM - New Leaf" : ["assets/songs/3ds/9AM.mp3", "assets/disc/3ds.png", "Animal Crossing : New Leaf"],
      "10AM - New Leaf" : ["assets/songs/3ds/10AM.mp3", "assets/disc/3ds.png", "Animal Crossing : New Leaf"],
      "11AM - New Leaf" : ["assets/songs/3ds/11AM.mp3", "assets/disc/3ds.png", "Animal Crossing : New Leaf"],
      "12PM - New Leaf" : ["assets/songs/3ds/12PM.mp3", "assets/disc/3ds.png", "Animal Crossing : New Leaf"],
      "1PM - New Leaf" : ["assets/songs/3ds/1PM.mp3", "assets/disc/3ds.png", "Animal Crossing : New Leaf"],
      "2PM - New Leaf" : ["assets/songs/3ds/2PM.mp3", "assets/disc/3ds.png", "Animal Crossing : New Leaf"],
      "3PM - New Leaf" : ["assets/songs/3ds/3PM.mp3", "assets/disc/3ds.png", "Animal Crossing : New Leaf"],
      "4PM - New Leaf" : ["assets/songs/3ds/4PM.mp3", "assets/disc/3ds.png", "Animal Crossing : New Leaf"],
      "5PM - New Leaf" : ["assets/songs/3ds/5PM.mp3", "assets/disc/3ds.png", "Animal Crossing : New Leaf"],
      "6PM - New Leaf" : ["assets/songs/3ds/6PM.mp3", "assets/disc/3ds.png", "Animal Crossing : New Leaf"],
      "7PM - New Leaf" : ["assets/songs/3ds/7PM.mp3", "assets/disc/3ds.png", "Animal Crossing : New Leaf"],
      "8PM - New Leaf" : ["assets/songs/3ds/8PM.mp3", "assets/disc/3ds.png", "Animal Crossing : New Leaf"],
      "9PM - New Leaf" : ["assets/songs/3ds/9PM.mp3", "assets/disc/3ds.png", "Animal Crossing : New Leaf"],
      "10PM - New Leaf" : ["assets/songs/3ds/10PM.mp3", "assets/disc/3ds.png", "Animal Crossing : New Leaf"],
      "11PM - New Leaf" : ["assets/songs/3ds/11PM.mp3", "assets/disc/3ds.png", "Animal Crossing : New Leaf"],
    },

    "SWITCH" : {
      "Tema Principal - New Horizons" : ["assets/songs/switch/title.mp3", "assets/disc/switch.png", "Animal Crossing : New Horizons"],
      "12AM - New Horizons" : ["assets/songs/switch/12AM.mp3", "assets/disc/switch.png", "Animal Crossing : New Horizons"],
      "1AM - New Horizons" : ["assets/songs/switch/1AM.mp3", "assets/disc/switch.png", "Animal Crossing : New Horizons"],
      "2AM - New Horizons" : ["assets/songs/switch/2AM.mp3", "assets/disc/switch.png", "Animal Crossing : New Horizons"],
      "3AM - New Horizons" : ["assets/songs/switch/3AM.mp3", "assets/disc/switch.png", "Animal Crossing : New Horizons"],
      "4AM - New Horizons" : ["assets/songs/switch/4AM.mp3", "assets/disc/switch.png", "Animal Crossing : New Horizons"],
      "5AM - New Horizons" : ["assets/songs/switch/5AM.mp3", "assets/disc/switch.png", "Animal Crossing : New Horizons"],
      "6AM - New Horizons" : ["assets/songs/switch/6AM.mp3", "assets/disc/switch.png", "Animal Crossing : New Horizons"],
      "7AM - New Horizons" : ["assets/songs/switch/7AM.mp3", "assets/disc/switch.png", "Animal Crossing : New Horizons"],
      "8AM - New Horizons" : ["assets/songs/switch/8AM.mp3", "assets/disc/switch.png", "Animal Crossing : New Horizons"],
      "9AM - New Horizons" : ["assets/songs/switch/9AM.mp3", "assets/disc/switch.png", "Animal Crossing : New Horizons"],
      "10AM - New Horizons" : ["assets/songs/switch/10AM.mp3", "assets/disc/switch.png", "Animal Crossing : New Horizons"],
      "11AM - New Horizons" : ["assets/songs/switch/11AM.mp3", "assets/disc/switch.png", "Animal Crossing : New Horizons"],
      "12PM - New Horizons" : ["assets/songs/switch/12PM.mp3", "assets/disc/switch.png", "Animal Crossing : New Horizons"],
      "1PM - New Horizons" : ["assets/songs/switch/1PM.mp3", "assets/disc/switch.png", "Animal Crossing : New Horizons"],
      "2PM - New Horizons" : ["assets/songs/switch/2PM.mp3", "assets/disc/switch.png", "Animal Crossing : New Horizons"],
      "3PM - New Horizons" : ["assets/songs/switch/3PM.mp3", "assets/disc/switch.png", "Animal Crossing : New Horizons"],
      "4PM - New Horizons" : ["assets/songs/switch/4PM.mp3", "assets/disc/switch.png", "Animal Crossing : New Horizons"],
      "5PM - New Horizons" : ["assets/songs/switch/5PM.mp3", "assets/disc/switch.png", "Animal Crossing : New Horizons"],
      "6PM - New Horizons" : ["assets/songs/switch/6PM.mp3", "assets/disc/switch.png", "Animal Crossing : New Horizons"],
      "7PM - New Horizons" : ["assets/songs/switch/7PM.mp3", "assets/disc/switch.png", "Animal Crossing : New Horizons"],
      "8PM - New Horizons" : ["assets/songs/switch/8PM.mp3", "assets/disc/switch.png", "Animal Crossing : New Horizons"],
      "9PM - New Horizons" : ["assets/songs/switch/9PM.mp3", "assets/disc/switch.png", "Animal Crossing : New Horizons"],
      "10PM - New Horizons" : ["assets/songs/switch/10PM.mp3", "assets/disc/switch.png", "Animal Crossing : New Horizons"],
      "11PM - New Horizons" : ["assets/songs/switch/11PM.mp3", "assets/disc/switch.png", "Animal Crossing : New Horizons"],
    },

  };

  insertSongs() async {
    // This method inserts every song from map into the database
    await database.createTable();

    for (String game in songsData.keys){
      for (String song in songsData[game].keys){
        Songs data = Songs(name: song, uri:songsData[game][song][0], logo: songsData[game][song][1], title: songsData[game][song][2]);
        database.insertRowIntoTable(data);
      }
    }
  }



}