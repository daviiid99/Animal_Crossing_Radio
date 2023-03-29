import 'dart:io';
import 'package:animal_crossing_radio/Data/songs.dart';
import 'package:animal_crossing_radio/DataBases/garden.dart';
import 'package:animal_crossing_radio/DataBases/songs.dart';
import 'package:animal_crossing_radio/Dependencies/dependencies.dart';
import 'package:stacked/stacked.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';

class GardenModel extends BaseViewModel implements Initialisable {

  List<Garden> gardens = [];
  List<Songs> songs = [];
  late Garden currentGarden;
  bool leftNavigationButtonVisible = false;
  bool rightNavigationButtonVisible = true;
  late String currentTheme;
  late Directory deviceDataDir;
  AudioPlayer player = AudioPlayer();

  @override
  void initialise() {
    addStaticGardensToDataBase(); // generate all assets
    setBackgroundMusic(); // get background sound
  }

  addStaticGardensToDataBase() async {
    // Try to get existing gardens, on exception generate everything
    try {
      gardens = await Garden.retrieveGardens();
      currentGarden = gardens[0];
      notifyListeners();
    }
    catch (e) {
      generateGardens();
    }
  }

  generateGardens() async {
    // This method will provide users gardens
    Garden gardenTree = Garden(
        name: "Pradera Arborada", isTree: 1, isPalmTree: 0, isFlowers: 0);
    Garden gardenCoast = Garden(
        name: "Costa Soleá", isTree: 0, isPalmTree: 1, isFlowers: 0);
    Garden gardenFlowers = Garden(
        name: "Jardín Tulipán", isTree: 0, isPalmTree: 0, isFlowers: 1);

    Garden.createTable();
    gardenTree.insertGardenIntoTable(gardenTree);
    gardenCoast.insertGardenIntoTable(gardenCoast);
    gardenFlowers.insertGardenIntoTable(gardenFlowers);

    gardens = await Garden.retrieveGardens();
    currentGarden = gardens[0];
    notifyListeners();
  }

  moveToNextGarden() {
    // If user clicks the next garden button
    // Load next garden asset
    if (gardens.indexOf(currentGarden) < gardens.length) {
      currentGarden = gardens[gardens.indexOf(currentGarden) + 1];
      leftNavigationButtonVisible = true;
      notifyListeners();
    } else {
      rightNavigationButtonVisible = false;
      notifyListeners();
    }
  }

  moveToPreviousGarden() {
    // Let user to return to previous garden if needed
    if (gardens.indexOf(currentGarden) > 0) {
      currentGarden = gardens[gardens.indexOf(currentGarden) - 1];
      notifyListeners();
    } else {
      leftNavigationButtonVisible = false;
      notifyListeners();
    }
  }

  getDeviceDataDirectory() async {
    deviceDataDir = await getApplicationDocumentsDirectory();
    notifyListeners();
  }

  getCurrentHourSong(int hour, String title, List<Songs> songs) async {
    for (Songs song in songs) {
      if (hour == 0) {
        if (song.name.contains("12AM") && song.title.contains("Wild World")) {
          currentTheme = "${deviceDataDir.path}/${song.uri.replaceAll("assets/", "")}";
        }
      }
      if (hour == 1) {
        if (song.name.contains("1AM") && song.title.contains("Wild World")) {
          currentTheme = "${deviceDataDir.path}/${song.uri.replaceAll("assets/", "")}";
        }
      }
      if (hour == 2) {
        if (song.name.contains("2AM") && song.title.contains("Wild World")) {
          currentTheme = "${deviceDataDir.path}/${song.uri.replaceAll("assets/", "")}";
        }
      }
      if (hour == 3) {
        if (song.name.contains("3AM") && song.title.contains("Wild World")) {
          currentTheme = "${deviceDataDir.path}/${song.uri.replaceAll("assets/", "")}";
        }
      }
      if (hour == 4) {
        if (song.name.contains("4AM") && song.title.contains("Wild World")) {
          currentTheme = "${deviceDataDir.path}/${song.uri.replaceAll("assets/", "")}";
        }
      }
      if (hour == 5) {
        if (song.name.contains("5AM") && song.title.contains("Wild World")) {
          currentTheme = "${deviceDataDir.path}/${song.uri.replaceAll("assets/", "")}";
        }
      }
      if (hour == 6) {
        if (song.name.contains("6AM") && song.title.contains("Wild World")) {
          currentTheme = "${deviceDataDir.path}/${song.uri.replaceAll("assets/", "")}";
        }
      }
      if (hour == 7) {
        if (song.name.contains("7AM") && song.title.contains("Wild World")) {
          currentTheme = "v/${song.uri.replaceAll("assets/", "")}";
        }
      }
      if (hour == 8) {
        if (song.name.contains("8AM") && song.title.contains("Wild World")) {
          currentTheme = "${deviceDataDir.path}/${song.uri.replaceAll("assets/", "")}";
        }
      }
      if (hour == 9) {
        if (song.name.contains("9AM") && song.title.contains("Wild World")) {
          currentTheme = "${deviceDataDir.path}/${song.uri.replaceAll("assets/", "")}";
        }
      }
      if (hour == 10) {
        if (song.name.contains("10AM") && song.title.contains("Wild World")) {
          currentTheme = "${deviceDataDir.path}/${song.uri.replaceAll("assets/", "")}";
        }
      }
      if (hour == 11) {
        if (song.name.contains("11AM") && song.title.contains("Wild World")) {
          currentTheme = "${deviceDataDir.path}/${song.uri.replaceAll("assets/", "")}";
        }
      }
      if (hour == 12) {
        if (song.name.contains("12PM") && song.title.contains("Wild World")) {
          currentTheme = "${deviceDataDir.path}/${song.uri.replaceAll("assets/", "")}";
        }
      }
      if (hour == 13) {
        if (song.name.contains("1PM") && song.title.contains("Wild World")) {
          currentTheme = "${deviceDataDir.path}/${song.uri.replaceAll("assets/", "")}";
        }
      }
      if (hour == 14) {
        if (song.name.contains("2PM") && song.title.contains("Wild World")) {
          currentTheme = "${deviceDataDir.path}/${song.uri.replaceAll("assets/", "")}";
        }
      }
      if (hour == 15) {
        if (song.name.contains("3PM") && song.title.contains("Wild World")) {
          currentTheme = "${deviceDataDir.path}/${song.uri.replaceAll("assets/", "")}";
        }
      }
      if (hour == 16) {
        if (song.name.contains("4PM") && song.title.contains("Wild World")) {
          currentTheme = "${deviceDataDir.path}/${song.uri.replaceAll("assets/", "")}";
        }
      }
      if (hour == 17) {
        if (song.name.contains("5PM") && song.title.contains("Wild World")) {
          currentTheme = "${deviceDataDir.path}/${song.uri.replaceAll("assets/", "")}";
        }
      }

      if (hour == 18) {
        if (song.name.contains("6PM") && song.title.contains("Wild World")) {
          currentTheme = "${deviceDataDir.path}/${song.uri.replaceAll("assets/", "")}";
        }
      }

      if (hour == 19) {
        if (song.name.contains("7PM") && song.title.contains("Wild World")) {
          currentTheme = "${deviceDataDir.path}/${song.uri.replaceAll("assets/", "")}";
        }
      }

      if (hour == 20) {
        if (song.name.contains("8PM") && song.title.contains("Wild World")) {
          currentTheme = "${deviceDataDir.path}/${song.uri.replaceAll("assets/", "")}";
        }
      }

      if (hour == 21) {
        if (song.name.contains("9PM") && song.title.contains("Wild World")) {
          currentTheme = "${deviceDataDir.path}/${song.uri.replaceAll("assets/", "")}";
        }
      }

      if (hour == 22) {
        if (song.name.contains("10PM") && song.title.contains("Wild World")) {
          currentTheme = "${deviceDataDir.path}/${song.uri.replaceAll("assets/", "")}";
        }
      }

      if (hour == 23) {
        if (song.name.contains("11PM") && song.title.contains("Wild World")) {
          currentTheme = "${deviceDataDir.path}/${song.uri.replaceAll("assets/", "")}";
        }
      }
    }
  }

    setBackgroundMusic() async {
      // This method will provide a track based on current time

      getDeviceDataDirectory();
      try {
        songs = await Songs.retrieveSongs();
      }
      catch (e){
        Song data = Song();
        data.insertSongs();
        songs = await Songs.retrieveSongs();
      }

      int time = DateTime
          .now()
          .hour;
      String title = "Wild World";
      getCurrentHourSong(time, title, songs);
      player.pause();
      player.play(DeviceFileSource(currentTheme));
    }
  }