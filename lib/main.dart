import 'package:animal_crossing_radio/LoginScreen/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/screen.dart';

void main() {
  runApp(mainApp());
}


class mainApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
          home: GardenView(),
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
    );
  }
}
