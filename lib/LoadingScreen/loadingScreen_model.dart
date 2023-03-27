import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import '../Screens/screen.dart';
import 'package:dio/dio.dart';
import 'dart:math';

class LoadingScreenModel extends BaseViewModel implements Initialisable {

  late String currentMessage;
  late String currentNpc;
  bool isPlaying = true;
  bool startLoop =  false;

  @override
  void initialise() async {
    updateEventsMessages();
    print("Hello I'm running on boot");
  }


    updateEventsMessages() async {
    // We'll try to implement a real time updater for Isabelle Messages

      List<Events> messages  = [];
      Random r = Random();
      int previousPos = 99;
      int pos = 0;

      try {
        messages = await Events.retrieveEventsFromDataBase();
      }
      catch (e) {
        EventsData().insertEvents();
        messages = await Events.retrieveEventsFromDataBase();
      }

      pos = r.nextInt(messages.length);

      while(pos == previousPos){
        pos = r.nextInt(messages.length);
      }

      previousPos = pos;
      currentMessage = messages[pos].message;
      currentNpc = messages[pos].npc;

      notifyListeners();
  }

}