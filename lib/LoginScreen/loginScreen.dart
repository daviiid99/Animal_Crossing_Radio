import 'package:flutter/material.dart';
import '../Dependencies/dependencies.dart';
import '../Screens/screen.dart';

class LoginScreen extends StatefulWidget{
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
          // Background Color // Container
          BackgroundWdg(),
          // Header Color // Container
          BannerBackground(),

          // Top Screen Banner
          SafeArea(child: BannerWdg()),

          // Middle Screen form // Container
          Row(
            children: [
              Expanded(
                child : ListView(
                    children  : [
                      const Spacer(),
                      FormWdg(),
                      const Spacer(),
                    ]
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}