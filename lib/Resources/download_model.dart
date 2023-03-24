import 'dart:io';
import 'package:animal_crossing_radio/Control/control.dart';
import 'package:animal_crossing_radio/Resources/download_view.dart';
import 'package:archive/archive_io.dart';
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
  List<String> descargas = [];

  static Map<String,dynamic> files = {

    "gc" : {
      "10AM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/gc/10AM.mp3", "songs/gc/10AM.mp3"],
      "11AM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/gc/11AM.mp3", "songs/gc/11AM.mp3"],
      "12PM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/gc/12PM.mp3", "songs/gc/12PM.mp3"],
      "1PM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/gc/1PM.mp3", "songs/gc/1PM.mp3"],
      "2PM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/gc/2PM.mp3", "songs/gc/2PM.mp3"],
      "3PM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/gc/3PM.mp3", "songs/gc/3PM.mp3"],
      "4PM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/gc/4PM.mp3", "songs/gc/4PM.mp3"],
      "5PM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/gc/5PM.mp3", "songs/gc/5PM.mp3"],
      "6PM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/gc/6PM.mp3", "songs/gc/6PM.mp3"],
      "7PM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/gc/7PM.mp3", "songs/gc/7PM.mp3"],
      "8PM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/gc/8PM.mp3", "songs/gc/8PM.mp3"],
      "9PM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/gc/9PM.mp3", "songs/gc/9PM.mp3"],
      "10PM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/gc/10PM.mp3", "songs/gc/10PM.mp3"],
      "11PM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/gc/11PM.mp3", "songs/gc/11PM.mp3"],
      "12AM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/gc/12AM.mp3", "songs/gc/12AM.mp3"],
      "1AM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/gc/1AM.mp3", "songs/gc/1AM.mp3"],
      "2AM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/gc/2AM.mp3", "songs/gc/2AM.mp3"],
      "3AM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/gc/3AM.mp3", "songs/gc/3AM.mp3"],
      "4AM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/gc/4AM.mp3", "songs/gc/4AM.mp3"],
      "5AM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/gc/5AM.mp3", "songs/gc/5AM.mp3"],
      "6AM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/gc/6AM.mp3", "songs/gc/6AM.mp3"],
      "7AM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/gc/7AM.mp3", "songs/gc/7AM.mp3"],
      "8AM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/gc/8AM.mp3", "songs/gc/8AM.mp3"],
      "9AM_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/gc/9AM.mp3", "songs/gc/9AM.mp3"],
      "title_gc.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/gc/title.mp3", "songs/gc/title.mp3"],
    },

    "ds" : {
      "10AM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/ds/10AM.mp3", "songs/ds/10AM.mp3"],
      "11AM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/ds/11AM.mp3", "songs/ds/11AM.mp3"],
      "12PM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/ds/12PM.mp3", "songs/ds/12PM.mp3"],
      "1PM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/ds/1PM.mp3", "songs/ds/1PM.mp3"],
      "2PM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/ds/2PM.mp3", "songs/ds/2PM.mp3"],
      "3PM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/ds/3PM.mp3", "songs/ds/3PM.mp3"],
      "4PM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/ds/4PM.mp3", "songs/ds/4PM.mp3"],
      "5PM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/ds/5PM.mp3", "songs/ds/5PM.mp3"],
      "6PM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/ds/6PM.mp3", "songs/ds/6PM.mp3"],
      "7PM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/ds/7PM.mp3", "songs/ds/7PM.mp3"],
      "8PM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/ds/8PM.mp3", "songs/ds/8PM.mp3"],
      "9PM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/ds/9PM.mp3", "songs/ds/9PM.mp3"],
      "10PM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/ds/10PM.mp3", "songs/ds/10PM.mp3"],
      "11PM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/ds/11PM.mp3", "songs/ds/11PM.mp3"],
      "12AM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/ds/12AM.mp3", "songs/ds/12AM.mp3"],
      "1AM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/ds/1AM.mp3", "songs/ds/1AM.mp3"],
      "2AM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/ds/2AM.mp3", "songs/ds/2AM.mp3"],
      "3AM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/ds/3AM.mp3", "songs/ds/3AM.mp3"],
      "4AM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/ds/4AM.mp3", "songs/ds/4AM.mp3"],
      "5AM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/ds/5AM.mp3", "songs/ds/5AM.mp3"],
      "6AM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/ds/6AM.mp3", "songs/ds/6AM.mp3"],
      "7AM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/ds/7AM.mp3", "songs/ds/7AM.mp3"],
      "8AM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/ds/8AM.mp3", "songs/ds/8AM.mp3"],
      "9AM_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/ds/9AM.mp3", "songs/ds/9AM.mp3"],
      "title_ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/ds/title.mp3", "songs/ds/title.mp3"],
    },

    "3ds" : {
      "10AM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/3ds/10AM.mp3", "songs/3ds/10AM.mp3"],
      "11AM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/3ds/11AM.mp3", "songs/3ds/11AM.mp3"],
      "12PM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/3ds/12PM.mp3", "songs/3ds/12PM.mp3"],
      "1PM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/3ds/1PM.mp3", "songs/3ds/1PM.mp3"],
      "2PM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/3ds/2PM.mp3", "songs/3ds/2PM.mp3"],
      "3PM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/3ds/3PM.mp3", "songs/3ds/3PM.mp3"],
      "4PM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/3ds/4PM.mp3", "songs/3ds/4PM.mp3"],
      "5PM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/3ds/5PM.mp3", "songs/3ds/5PM.mp3"],
      "6PM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/3ds/6PM.mp3", "songs/3ds/6PM.mp3"],
      "7PM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/3ds/7PM.mp3", "songs/3ds/7PM.mp3"],
      "8PM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/3ds/8PM.mp3", "songs/3ds/8PM.mp3"],
      "9PM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/3ds/9PM.mp3", "songs/3ds/9PM.mp3"],
      "10PM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/3ds/10PM.mp3", "songs/3ds/10PM.mp3"],
      "11PM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/3ds/11PM.mp3", "songs/3ds/11PM.mp3"],
      "12AM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/3ds/12AM.mp3", "songs/3ds/12AM.mp3"],
      "1AM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/3ds/1AM.mp3", "songs/3ds/1AM.mp3"],
      "2AM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/3ds/2AM.mp3", "songs/3ds/2AM.mp3"],
      "3AM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/3ds/3AM.mp3", "songs/3ds/3AM.mp3"],
      "4AM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/3ds/4AM.mp3", "songs/3ds/4AM.mp3"],
      "5AM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/3ds/5AM.mp3", "songs/3ds/5AM.mp3"],
      "6AM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/3ds/6AM.mp3", "songs/3ds/6AM.mp3"],
      "7AM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/3ds/7AM.mp3", "songs/3ds/7AM.mp3"],
      "8AM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/3ds/8AM.mp3", "songs/3ds/8AM.mp3"],
      "9AM_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/3ds/9AM.mp3", "songs/3ds/9AM.mp3"],
      "title_3ds.mp3" : ["https://github.com/daviiid99/Animal_Crossing_Radio/blob/main/songs/3ds/title.mp3", "songs/3ds/title.mp3"],
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
                descargas.add(download.fileName);
                currentEntry = descargas.length;
                print(descargas);
                hotReload(context);
              }
              break;
          }
        }
    );
  }

   downloadStoreFile(BuildContext context) async {
    // A method that read Map structure
    // Downloads every file
    // Stores file into a ApplicationDocumentsDirectory subdirectory

     downloadFile(BuildContext context)  async {

       files.forEach((key, value) async  {
         DownloadModel currentDownload = DownloadModel(fileName: key, fileUrl: files[key][0], filePath: "${DownloadViewState.dataPath.path}/${files[key][1]}");
         download(currentDownload, context);
       });
     }

     maxEntries = files.keys.length;
     downloadFile(context);

  }
}