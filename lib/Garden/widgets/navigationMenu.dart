import 'package:animal_crossing_radio/Garden/garden_model.dart';
import 'package:flutter/material.dart';

class NavigationMenu extends StatelessWidget{
  const NavigationMenu({
    required this.viewModel,
    super.key,
});

  final GardenModel viewModel;

  @override
  Widget build(BuildContext context){

    final height = MediaQuery.of(context).size.height ;
    final width = MediaQuery.of(context).size.width ;

    return Container(
      height: height * 0.1,
      margin: EdgeInsets.only(top: height * 0.9, left: 5, right: 5, bottom: 5),
      child: Row(
        children: [
          // Horizontal menu with two buttons
          const Spacer(),
          if (viewModel.leftNavigationButtonVisible)
          IconButton(
              onPressed: (){
                print("previous");
                viewModel.moveToPreviousGarden();
              },
              icon: const Icon(Icons.keyboard_arrow_left_rounded, color: Colors.white, size: 70,)),
          const Spacer(),
          if (viewModel.rightNavigationButtonVisible)
          IconButton(
              onPressed: (){
                print("next");
                viewModel.moveToNextGarden();
              },
              icon: const Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white, size: 70,)),
          const Spacer(),
        ],
      ),

    );
  }
}