import 'dart:io';
import 'package:animal_crossing_radio/Control/control.dart';
import 'package:animal_crossing_radio/LoadingScreen/loadingScreen_view.dart';
import 'package:animal_crossing_radio/LoginScreen/loginScreen.dart';
import 'package:animal_crossing_radio/Resources/download_view.dart';
import 'package:archive/archive_io.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';


class DownloadModel with Control {
  DownloadModel({
    required this.fileName,
    required this.fileUrl,
    required this.filePath,
});

  final String fileName;
  final String fileUrl;
  final String filePath;

  String progress =  "0%";
  static String currentProgress = "0%";
  static bool isDownloading = false;
  bool isCompleted = false;
  String get getDownloadState => progress;
  static String title = "Descargando Recursos";
  Directory path = Directory("path");
  static int maxEntries = 0;
  static int currentEntry = 0;
  int previousEntry = 0;
  static String get newProgress => currentProgress;
  static List<String> descargas = [""];

  static Map<String,dynamic> files = {

    "gc" : {
      "10AM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/gc/10AM.mp3", "songs/gc/10AM.mp3"],
      "11AM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/gc/11AM.mp3", "songs/gc/11AM.mp3"],
      "12PM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/gc/12PM.mp3", "songs/gc/12PM.mp3"],
      "1PM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/gc/1PM.mp3", "songs/gc/1PM.mp3"],
      "2PM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/gc/2PM.mp3", "songs/gc/2PM.mp3"],
      "3PM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/gc/3PM.mp3", "songs/gc/3PM.mp3"],
      "4PM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/gc/4PM.mp3", "songs/gc/4PM.mp3"],
      "5PM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/gc/5PM.mp3", "songs/gc/5PM.mp3"],
      "6PM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/gc/6PM.mp3", "songs/gc/6PM.mp3"],
      "7PM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/gc/7PM.mp3", "songs/gc/7PM.mp3"],
      "8PM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/gc/8PM.mp3", "songs/gc/8PM.mp3"],
      "9PM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/gc/9PM.mp3", "songs/gc/9PM.mp3"],
      "10PM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/gc/10PM.mp3", "songs/gc/10PM.mp3"],
      "11PM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/gc/11PM.mp3", "songs/gc/11PM.mp3"],
      "12AM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/gc/12AM.mp3", "songs/gc/12AM.mp3"],
      "1AM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/gc/1AM.mp3", "songs/gc/1AM.mp3"],
      "2AM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/gc/2AM.mp3", "songs/gc/2AM.mp3"],
      "3AM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/gc/3AM.mp3", "songs/gc/3AM.mp3"],
      "4AM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/gc/4AM.mp3", "songs/gc/4AM.mp3"],
      "5AM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/gc/5AM.mp3", "songs/gc/5AM.mp3"],
      "6AM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/gc/6AM.mp3", "songs/gc/6AM.mp3"],
      "7AM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/gc/7AM.mp3", "songs/gc/7AM.mp3"],
      "8AM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/gc/8AM.mp3", "songs/gc/8AM.mp3"],
      "9AM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/gc/9AM.mp3", "songs/gc/9AM.mp3"],
      "title_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/gc/title.mp3", "songs/gc/title.mp3"],
    },

    "ds" : {
      "10AM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/10AM.mp3", "songs/ds/10AM.mp3"],
      "11AM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/11AM.mp3", "songs/ds/11AM.mp3"],
      "12PM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/12PM.mp3", "songs/ds/12PM.mp3"],
      "1PM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/1PM.mp3", "songs/ds/1PM.mp3"],
      "2PM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/2PM.mp3", "songs/ds/2PM.mp3"],
      "3PM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/3PM.mp3", "songs/ds/3PM.mp3"],
      "4PM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/4PM.mp3", "songs/ds/4PM.mp3"],
      "5PM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/5PM.mp3", "songs/ds/5PM.mp3"],
      "6PM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/6PM.mp3", "songs/ds/6PM.mp3"],
      "7PM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/7PM.mp3", "songs/ds/7PM.mp3"],
      "8PM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/8PM.mp3", "songs/ds/8PM.mp3"],
      "9PM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/9PM.mp3", "songs/ds/9PM.mp3"],
      "10PM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/10PM.mp3", "songs/ds/10PM.mp3"],
      "11PM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/11PM.mp3", "songs/ds/11PM.mp3"],
      "12AM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/12AM.mp3", "songs/ds/12AM.mp3"],
      "1AM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/1AM.mp3", "songs/ds/1AM.mp3"],
      "2AM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/2AM.mp3", "songs/ds/2AM.mp3"],
      "3AM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/3AM.mp3", "songs/ds/3AM.mp3"],
      "4AM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/4AM.mp3", "songs/ds/4AM.mp3"],
      "5AM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/5AM.mp3", "songs/ds/5AM.mp3"],
      "6AM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/6AM.mp3", "songs/ds/6AM.mp3"],
      "7AM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/7AM.mp3", "songs/ds/7AM.mp3"],
      "8AM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/8AM.mp3", "songs/ds/8AM.mp3"],
      "9AM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/9AM.mp3", "songs/ds/9AM.mp3"],
      "title_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/title.mp3", "songs/ds/title.mp3"],
      "fireworks_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/fireworks.mp3", "songs/ds/fireworks.mp3"],
      "able_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/able.mp3", "songs/ds/able.mp3"],
      "house_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/house.mp3", "songs/ds/house.mp3"],
      "cranny_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/cranny.mp3", "songs/ds/cranny.mp3"],
      "office_day_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/office_day.mp3", "songs/ds/office_day.mp3"],
      "office_night_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/office_night.mp3", "songs/ds/office_night.mp3"],
      "taxi_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/ds/taxi.mp3", "songs/ds/taxi.mp3"],
    },

    "wii" : {
      "10AM_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/10AM.mp3", "songs/wii/10AM.mp3"],
      "11AM_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/11AM.mp3", "songs/wii/11AM.mp3"],
      "12PM_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/12PM.mp3", "songs/wii/12PM.mp3"],
      "1PM_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/1PM.mp3", "songs/wii/1PM.mp3"],
      "2PM_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/2PM.mp3", "songs/wii/2PM.mp3"],
      "3PM_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/3PM.mp3", "songs/wii/3PM.mp3"],
      "4PM_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/4PM.mp3", "songs/wii/4PM.mp3"],
      "5PM_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/5PM.mp3", "songs/wii/5PM.mp3"],
      "6PM_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/6PM.mp3", "songs/wii/6PM.mp3"],
      "7PM_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/7PM.mp3", "songs/wii/7PM.mp3"],
      "8PM_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/8PM.mp3", "songs/wii/8PM.mp3"],
      "9PM_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/9PM.mp3", "songs/wii/9PM.mp3"],
      "10PM_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/10PM.mp3", "songs/wii/10PM.mp3"],
      "11PM_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/11PM.mp3", "songs/wii/11PM.mp3"],
      "12AM_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/12AM.mp3", "songs/wii/12AM.mp3"],
      "1AM_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/1AM.mp3", "songs/wii/1AM.mp3"],
      "2AM_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/2AM.mp3", "songs/wii/2AM.mp3"],
      "3AM_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/3AM.mp3", "songs/wii/3AM.mp3"],
      "4AM_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/4AM.mp3", "songs/wii/4AM.mp3"],
      "5AM_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/5AM.mp3", "songs/wii/5AM.mp3"],
      "6AM_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/6AM.mp3", "songs/wii/6AM.mp3"],
      "7AM_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/7AM.mp3", "songs/wii/7AM.mp3"],
      "8AM_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/8AM.mp3", "songs/wii/8AM.mp3"],
      "9AM_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/9AM.mp3", "songs/wii/9AM.mp3"],
      "title_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/title.mp3", "songs/wii/title.mp3"],
      "bus_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/bus.mp3", "songs/wii/bus.mp3"],
      "cranny_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/cranny.mp3", "songs/wii/cranny.mp3"],
      "hiper_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/hiper.mp3", "songs/wii/hiper.mp3"],
      "home_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/home.mp3", "songs/wii/home.mp3"],
      "house_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/house.mp3", "songs/wii/house.mp3"],
      "nook_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/nook.mp3", "songs/wii/nook.mp3"],
      "nooks_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/nooks.mp3", "songs/wii/nooks.mp3"],
      "super_wii.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/wii/super.mp3", "songs/wii/super.mp3"],
    },

    "3ds" : {
      "10AM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/3ds/10AM.mp3", "songs/3ds/10AM.mp3"],
      "11AM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/3ds/11AM.mp3", "songs/3ds/11AM.mp3"],
      "12PM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/3ds/12PM.mp3", "songs/3ds/12PM.mp3"],
      "1PM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/3ds/1PM.mp3", "songs/3ds/1PM.mp3"],
      "2PM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/3ds/2PM.mp3", "songs/3ds/2PM.mp3"],
      "3PM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/3ds/3PM.mp3", "songs/3ds/3PM.mp3"],
      "4PM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/3ds/4PM.mp3", "songs/3ds/4PM.mp3"],
      "5PM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/3ds/5PM.mp3", "songs/3ds/5PM.mp3"],
      "6PM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/3ds/6PM.mp3", "songs/3ds/6PM.mp3"],
      "7PM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/3ds/7PM.mp3", "songs/3ds/7PM.mp3"],
      "8PM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/3ds/8PM.mp3", "songs/3ds/8PM.mp3"],
      "9PM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/3ds/9PM.mp3", "songs/3ds/9PM.mp3"],
      "10PM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/3ds/10PM.mp3", "songs/3ds/10PM.mp3"],
      "11PM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/3ds/11PM.mp3", "songs/3ds/11PM.mp3"],
      "12AM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/3ds/12AM.mp3", "songs/3ds/12AM.mp3"],
      "1AM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/3ds/1AM.mp3", "songs/3ds/1AM.mp3"],
      "2AM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/3ds/2AM.mp3", "songs/3ds/2AM.mp3"],
      "3AM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/3ds/3AM.mp3", "songs/3ds/3AM.mp3"],
      "4AM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/3ds/4AM.mp3", "songs/3ds/4AM.mp3"],
      "5AM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/3ds/5AM.mp3", "songs/3ds/5AM.mp3"],
      "6AM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/3ds/6AM.mp3", "songs/3ds/6AM.mp3"],
      "7AM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/3ds/7AM.mp3", "songs/3ds/7AM.mp3"],
      "8AM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/3ds/8AM.mp3", "songs/3ds/8AM.mp3"],
      "9AM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/3ds/9AM.mp3", "songs/3ds/9AM.mp3"],
      "title_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/3ds/title.mp3", "songs/3ds/title.mp3"],
    },

    "switch" : {
      "10AM_switch.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/switch/10AM.mp3", "songs/switch/10AM.mp3"],
      "11AM_switch.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/switch/11AM.mp3", "songs/switch/11AM.mp3"],
      "12PM_switch.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/switch/12PM.mp3", "songs/switch/12PM.mp3"],
      "1PM_switch.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/switch/1PM.mp3", "songs/switch/1PM.mp3"],
      "2PM_switch.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/switch/2PM.mp3", "songs/switch/2PM.mp3"],
      "3PM_switch.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/switch/3PM.mp3", "songs/switch/3PM.mp3"],
      "4PM_switch.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/switch/4PM.mp3", "songs/switch/4PM.mp3"],
      "5PM_switch.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/switch/5PM.mp3", "songs/switch/5PM.mp3"],
      "6PM_switch.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/switch/6PM.mp3", "songs/switch/6PM.mp3"],
      "7PM_switch.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/switch/7PM.mp3", "songs/switch/7PM.mp3"],
      "8PM_switch.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/switch/8PM.mp3", "songs/switch/8PM.mp3"],
      "9PM_switch.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/switch/9PM.mp3", "songs/switch/9PM.mp3"],
      "10PM_switch.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/switch/10PM.mp3", "songs/switch/10PM.mp3"],
      "11PM_switch.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/switch/11PM.mp3", "songs/switch/11PM.mp3"],
      "12AM_switch.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/switch/12AM.mp3", "songs/switch/12AM.mp3"],
      "1AM_switch.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/switch/1AM.mp3", "songs/switch/1AM.mp3"],
      "2AM_switch.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/switch/2AM.mp3", "songs/switch/2AM.mp3"],
      "3AM_switch.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/switch/3AM.mp3", "songs/switch/3AM.mp3"],
      "4AM_switch.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/switch/4AM.mp3", "songs/switch/4AM.mp3"],
      "5AM_switch.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/switch/5AM.mp3", "songs/switch/5AM.mp3"],
      "6AM_switch.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/switch/6AM.mp3", "songs/switch/6AM.mp3"],
      "7AM_switch.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/switch/7AM.mp3", "songs/switch/7AM.mp3"],
      "8AM_switch.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/switch/8AM.mp3", "songs/switch/8AM.mp3"],
      "9AM_switch.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/switch/9AM.mp3", "songs/switch/9AM.mp3"],
      "title_switch.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/switch/title.mp3", "songs/switch/title.mp3"],
    },

    "effects" : {
      "bought.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/effects/bought.mp3", "songs/bought/title.mp3"],
    },

    "stores" : {
      "isabelle.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/stores/isabelle.mp3", "songs/stores/isabelle.mp3"],
      "nook.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/stores/nook.mp3", "songs/stores/nook.mp3"],
    },

    "nintendo" : {
      "nintendo_1.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/nintendo/nintendo_1.mp3", "songs/nintendo/nintendo_1.mp3"],
      "nintendo_2.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/nintendo/nintendo_2.mp3", "songs/nintendo/nintendo_2.mp3"],
      "nintendo_3.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/nintendo/nintendo_3.mp3", "songs/nintendo/nintendo_3.mp3"],
      "nintendo_4.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/nintendo/nintendo_4.mp3", "songs/nintendo/nintendo_4.mp3"],
      "nintendo_5.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/nintendo/nintendo_5.mp3", "songs/nintendo/nintendo_5.mp3"],
    },

    "totakeke" : {
      // .PNG files
      "AGENTE_TOTAKEKE.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/AGENTE_TOTAKEKE.png", "songs/totakeke/art/AGENTE_TOTAKEKE.png"],
      "AL_VOLANTE.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/AL_VOLANTE.png", "songs/totakeke/art/AL_VOLANTE.png"],
      "ANTEAYER.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/ANTEAYER.png", "songs/totakeke/art/ANTEAYER.png"],
      "CANCION_MINIMALISTA.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/CANCION_MINIMALISTA.png", "songs/totakeke/art/CANCION_MINIMALISTA.png"],
      "CAPULLOS_EN_FLOR.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/CAPULLOS_EN_FLOR.png", "songs/totakeke/art/CAPULLOS_EN_FLOR.png"],
      "CIUDAD_ANIMAL.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/CIUDAD_ANIMAL.png", "songs/totakeke/art/CIUDAD_ANIMAL.png"],
      "COLINA_ARRIBA.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/COLINA_ARRIBA.png", "songs/totakeke/art/COLINA_ARRIBA.png"],
      "DESPEDIDA.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/DESPEDIDA.png", "songs/totakeke/art/DESPEDIDA.png"],
      "FELIZ_EN_TU_DIA.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/FELIZ_EN_TU_DIA.png", "songs/totakeke/art/FELIZ_EN_TU_DIA.png"],
      "FORESTAL_Y_TAL.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/FORESTAL_Y_TAL.png", "songs/totakeke/art/FORESTAL_Y_TAL.png"],
      "HASTA_EL_FINAL.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/HASTA_EL_FINAL.png", "songs/totakeke/art/HASTA_EL_FINAL.png"],
      "LLANERO_TOTA.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/LLANERO_TOTA.png", "songs/totakeke/art/LLANERO_TOTA.png"],
      "MIRAME_A_LOS_OJOS.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/MIRAME_A_LOS_OJOS.png", "songs/totakeke/art/MIRAME_A_LOS_OJOS.png"],
      "MISTER_TOTAKEKE.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/MISTER_TOTAKEKE.png", "songs/totakeke/art/MISTER_TOTAKEKE.png"],
      "MI_HOGAR.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/MI_HOGAR.png", "songs/totakeke/art/MI_HOGAR.png"],
      "MI_ISLA_MI_HOGAR.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/MI_ISLA_MI_HOGAR.png", "songs/totakeke/art/MI_ISLA_MI_HOGAR.png"],
      "NAPOLITANA.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/NAPOLITANA.png", "songs/totakeke/art/NAPOLITANA.png"],
      "NUEVO_HORIZONTE.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/NUEVO_HORIZONTE.png", "songs/totakeke/art/NUEVO_HORIZONTE.png"],
      "PASEITO.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/PASEITO.png", "songs/totakeke/art/PASEITO.png"],
      "PASTELITO_SECO.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/PASTELITO_SECO.png", "songs/totakeke/art/PASTELITO_SECO.png"],
      "REY_TOTA.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/REY_TOTA.png", "songs/totakeke/art/REY_TOTA.png"],
      "SOLO_YO.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/SOLO_YO.png", "songs/totakeke/art/SOLO_YO.png"],
      "SOPESANDO.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/SOPESANDO.png", "songs/totakeke/art/SOPESANDO.png"],
      "TE_QUIERO.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/TE_QUIERO.png", "songs/totakeke/art/TE_QUIERO.png"],
      "TOTA_2001.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/TOTA_2001.png", "songs/totakeke/art/TOTA_2001.png"],
      "TOTA_ALCAZABA.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/TOTA_ALCAZABA.png", "songs/totakeke/art/TOTA_ALCAZABA.png"],
      "TOTA_ALOHA.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/TOTA_ALOHA.png", "songs/totakeke/art/TOTA_ALOHA.png"],
      "TOTA_AMOR.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/TOTA_AMOR.png", "songs/totakeke/art/TOTA_AMOR.png"],
      "TOTA_AMORES.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/TOTA_AMORES.png", "songs/totakeke/art/TOTA_AMORES.png"],
      "TOTA_ANDINA.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/TOTA_ANDINA.png", "songs/totakeke/art/TOTA_ANDINA.png"],
      "TOTA_ARIA.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/TOTA_ARIA.png", "songs/totakeke/art/TOTA_ARIA.png"],
      "TOTA_BALADA.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/TOTA_BALADA.png", "songs/totakeke/art/TOTA_BALADA.png"],
      "TOTA_BANDA_SONORA.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/TOTA_BANDA_SONORA.png", "songs/totakeke/art/TOTA_BANDA_SONORA.png"],
      "TOTA_BAZAR.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/TOTA_BAZAR.png", "songs/totakeke/art/TOTA_BAZAR.png"],
      "TOTA_BLUES.png" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/art/TOTA_BLUES.png", "songs/totakeke/art/TOTA_BLUES.png"],
      // .MP3 Files
      "AGENTE_TOTAKEKE.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/AGENTE_TOTAKEKE.mp3", "songs/totakeke/music/AGENTE_TOTAKEKE.mp3"],
      "AL_VOLANTE.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/AL_VOLANTE.mp3", "songs/totakeke/music/AL_VOLANTE.mp3"],
      "ANTEAYER.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/ANTEAYER.mp3", "songs/totakeke/music/ANTEAYER.mp3"],
      "CANCION_MINIMALISTA.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/CANCION_MINIMALISTA.mp3", "songs/totakeke/music/CANCION_MINIMALISTA.mp3"],
      "CAPULLOS_EN_FLOR.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/CAPULLOS EN FLOR.mp3", "songs/totakeke/music/CAPULLOS_EN_FLOR.mp3"],
      "CIUDAD_ANIMAL.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/CIUDAD_ANIMAL.mp3", "songs/totakeke/music/CIUDAD_ANIMAL.mp3"],
      "COLINA_ARRIBA.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/COLINA_ARRIBA.mp3", "songs/totakeke/music/COLINA_ARRIBA.mp3"],
      "DESPEDIDA.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/DESPEDIDA.mp3", "songs/totakeke/music/DESPEDIDA.mp3"],
      "FELIZ_EN_TU_DIA.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/FELIZ_EN_TU_DIA.mp3", "songs/totakeke/music/FELIZ_EN_TU_DIA.mp3"],
      "FORESTAL_Y_TAL.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/FORESTAL_Y_TAL.mp3", "songs/totakeke/music/FORESTAL_Y_TAL.mp3"],
      "HASTA_EL_FINAL.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/HASTA_EL_FINAL.mp3", "songs/totakeke/music/HASTA_EL_FINAL.mp3"],
      "LLANERO_TOTA.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/LLANERO_TOTA.mp3", "songs/totakeke/music/LLANERO_TOTA.mp3"],
      "MIRAME_A_LOS_OJOS.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/MIRAME_A_LOS_OJOS.mp3", "songs/totakeke/music/MIRAME_A_LOS_OJOS.mp3"],
      "MISTER_TOTAKEKE.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/MISTER_TOTAKEKE.mp3", "songs/totakeke/music/MISTER_TOTAKEKE.mp3"],
      "MI_HOGAR.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/MI_HOGAR.mp3", "songs/totakeke/music/MI_HOGAR.mp3"],
      "MI_ISLA_MI_HOGAR.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/MI_ISLA_MI_HOGAR.mp3", "songs/totakeke/music/MI_ISLA_MI_HOGAR.mp3"],
      "NAPOLITANA.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/NAPOLITANA.mp3", "songs/totakeke/music/NAPOLITANA.mp3"],
      "NUEVO_HORIZONTE.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/NUEVO_HORIZONTE.mp3", "songs/totakeke/music/NUEVO_HORIZONTE.mp3"],
      "PASEITO.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/PASEITO.mp3", "songs/totakeke/music/PASEITO.mp3"],
      "PASTELITO_SECO.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/PASTELITO_SECO.mp3", "songs/totakeke/music/PASTELITO_SECO.mp3"],
      "REY_TOTA.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/REY_TOTA.mp3", "songs/totakeke/music/REY_TOTA.mp3"],
      "SOLO_YO.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/SOLO_YO.mp3", "songs/totakeke/music/SOLO_YO.mp3"],
      "SOPESANDO.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/SOPESANDO.mp3", "songs/totakeke/music/SOPESANDO.mp3"],
      "TE_QUIERO.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/TE_QUIERO.mp3", "songs/totakeke/music/TE_QUIERO.mp3"],
      "TOTA_2001.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/TOTA_2001.mp3", "songs/totakeke/music/TOTA_2001.mp3"],
      "TOTA_ALCAZABA.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/TOTA_ALCAZABA.mp3", "songs/totakeke/music/TOTA_ALCAZABA.mp3"],
      "TOTA_ALOHA.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/TOTA_ALOHA.mp3", "songs/totakeke/music/TOTA_ALOHA.mp3"],
      "TOTA_AMOR.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/TOTA_AMOR.mp3", "songs/totakeke/music/TOTA_AMOR.mp3"],
      "TOTA_AMORES.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/TOTA_AMORES.mp3", "songs/totakeke/music/TOTA_AMORES.mp3"],
      "TOTA_ANDINA.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/TOTA_ANDINA.mp3", "songs/totakeke/music/TOTA_ANDINA.mp3"],
      "TOTA_ARIA.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/TOTA_ARIA.mp3", "songs/totakeke/music/TOTA_ARIA.mp3"],
      "TOTA_BALADA.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/TOTA_BALADA.mp3", "songs/totakeke/music/TOTA_BALADA.mp3"],
      "TOTA_BANDA_SONORA.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/TOTA_BANDA_SONORA.mp3", "songs/totakeke/music/TOTA_BANDA_SONORA.mp3"],
      "TOTA_BAZAR.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/TOTA_BAZAR.mp3", "songs/totakeke/music/TOTA_BAZAR.mp3"],
      "TOTA_BLUES.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/raw/main/songs/totakeke/music/TOTA_BLUES.mp3", "songs/totakeke/music/TOTA_BLUES.mp3"],
    }

  };

   download(DownloadModel download, BuildContext context)  {

    Dio().download(
        download.fileUrl,
        download.filePath,
        onReceiveProgress: (received, total)  {
          currentProgress = ((received/total * 100).toStringAsFixed(0) + "%");
          if (progress != currentProgress ){
            progress = currentProgress;
            hotReload(context);
          }

          switch (currentProgress) {
            case "100%" :
              if (!descargas.contains(download.fileName)){
                if (descargas[0] ==  "") {
                  descargas[0] =  download.fileName;
                } else {
                  descargas.add(download.fileName);
                  currentEntry = descargas.length;
                  hotReload(context);
                  if (currentEntry == maxEntries){
                    title  = "Downloads Completed";
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    hotReload(context);
                  }
                }
              }
              break;
          }
        }
    );
  }

   downloadStoreFile(BuildContext context, List<DownloadModel> pending) async {
    // A method that read Map structure
    // Downloads every file
    // Stores file into a ApplicationDocumentsDirectory subdirectory

     totalEntries(){
       for (DownloadModel download in pending){
         maxEntries ++;
       }
     }

     downloadFile(BuildContext context)  async {
       for (DownloadModel currentDownload in pending){
         download(currentDownload, context);
       }
     }

     totalEntries();
     downloadFile(context);

  }
}