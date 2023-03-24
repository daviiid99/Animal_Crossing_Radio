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

  hotReload(BuildContext context){
    // This is an internal way used for hot reload current widget
    // Useful to refresh widgets inside StatelessWidget class
    (context as Element).reassemble();
  }
}