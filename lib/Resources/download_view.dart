import 'dart:io';
import 'package:animal_crossing_radio/Control/control.dart';
import 'package:animal_crossing_radio/Resources/download_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:download_assets/download_assets.dart';
import 'package:dio/dio.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:archive/archive_io.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class DownloadView extends StatefulWidget {
  @override
  DownloadViewState createState() => DownloadViewState();
}

class DownloadViewState extends State<DownloadView>{

  DownloadModel downloads = DownloadModel(fileName: "fileName", fileUrl: "fileUrl", filePath: "filePath");
  static Directory dataPath = Directory("path");

  getDataPath()  {
    setState(() async {
      dataPath = await getApplicationDocumentsDirectory();
      downloads.downloadStoreFile(context);
    });

  }

  @override
  void initState(){
    getDataPath();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;


    return Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
                children: [

                  if (DownloadModel.isDownloading)
                  // First Color
                    Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),

                  Container(
                    width: double.maxFinite,
                    height: height * 0.5,
                    color: Colors.blueAccent,
                  ),

                  Container(
                    padding: EdgeInsets.all(50),
                    margin: EdgeInsets.only(
                        top: height * 0.3, left: 50, right: 50),
                    width: double.maxFinite,
                    height: 300,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(40)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 100, width: 100,
                            child: CircularProgressIndicator(
                                color: Colors.blueAccent)),
                        SizedBox(height: 25,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Spacer(),
                            Text(DownloadModel.title, style: TextStyle(color: Colors.black,
                                fontSize: 20),),
                            Spacer(),
                          ],
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Spacer(),
                            Text("Por favor, espera",
                              style: TextStyle(color: Colors.black,
                                  fontSize: 15),),
                            Spacer(),
                          ],
                        ),

                        const SizedBox(height: 15,),

                        Row(
                          children: [
                            const Spacer(),
                            Text("${DownloadModel.currentEntry}/${DownloadModel.maxEntries}", style: TextStyle(color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25)),
                            const Spacer(),
                          ],
                        ),

                        const SizedBox(height: 15,),
                      ],
                    ),
                  )
                ]
            ),
          );
        }


}