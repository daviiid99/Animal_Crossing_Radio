import 'package:flutter/material.dart';

class BannerBackground extends StatelessWidget{
  const BannerBackground({super.key});

  @override
  Widget build(BuildContext context){

    final size = MediaQuery.of(context).size;

    return Container(
      width: double.maxFinite,
      height: size.height * 0.5,
      color: Colors.blueAccent,
    );
  }
}

class BackgroundStack  extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Stack(
      children: [
        // Background Color // Container
        BackgroundWdg(),
        // Header Color // Container
        BannerBackground(),
        // Middle Screen form // Container
      ],
    );
  }
}

class BackgroundWdg extends StatelessWidget{
  const BackgroundWdg({super.key});

  @override
  Widget build(BuildContext context){

    return Container(
      width: double.maxFinite,
      height: double.maxFinite ,
      color: Colors.black.withOpacity(0.9),
    );
  }
}