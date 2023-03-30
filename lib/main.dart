import 'dart:io';

import 'package:animal_crossing_radio/LoginScreen/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/screen.dart';
import 'package:path_provider/path_provider.dart';

void main() async  {

  List<DownloadModel> pending = await FilesIntegrity.checkFiles();
  if (pending.isNotEmpty){
    runApp(Downloader(pending : pending));
  } else {
    runApp(Login());
  }
}


class Login extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: LoadinScreenView(),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
    );
  }
}

class Downloader extends StatelessWidget{
  @override
  const Downloader({
    required this.pending,
    super.key,
  });

  final List<DownloadModel> pending;

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: DownloadView(pending: pending,),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
    );
  }
}
