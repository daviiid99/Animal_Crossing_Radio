import 'dart:io';

import 'package:animal_crossing_radio/LoginScreen/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/screen.dart';
import 'package:path_provider/path_provider.dart';

void main() async  {

  if (Directory("data/user/0/com.daviiid99.ac_radio/app_flutter/songs/gc").existsSync()
      && Directory("data/user/0/com.daviiid99.ac_radio/app_flutter/songs/ds").existsSync()
      && Directory("data/user/0/com.daviiid99.ac_radio/app_flutter/songs/wii").existsSync()
      && Directory("data/user/0/com.daviiid99.ac_radio/app_flutter/songs/3ds").existsSync()
      && Directory("data/user/0/com.daviiid99.ac_radio/app_flutter/songs/switch").existsSync()){
    runApp(Login());
  } else {
    runApp(Downloader());
  }
}


class Login extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
    );
  }
}

class Downloader extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: DownloadView(),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
    );
  }
}
