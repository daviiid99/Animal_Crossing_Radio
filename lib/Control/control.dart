import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class Control {

  enablefullScreenMode(){
    return SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: []);
  }

  Future<bool> stopServices(AudioPlayer player, BuildContext context) async {
    player.pause();
    player.stop();
    Navigator.pop(context);
    return true;
  }
}