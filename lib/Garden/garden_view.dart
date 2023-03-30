import 'package:animal_crossing_radio/Garden/widgets/animalClock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../Screens/screen.dart';

class GardenView extends StackedView<GardenModel> with Control{
  @override
  Widget builder(
      BuildContext context,
      GardenModel viewModel,
      Widget? child,
      ){

    NavigationMenu navBar = NavigationMenu(viewModel: viewModel);
    AssetGenerator asset = AssetGenerator(garden: viewModel.currentGarden);

    return WillPopScope(
      onWillPop: ()=> stopServices(viewModel.player, context),
        child: Stack(
          children: [
            // Background
             asset,

            // Menu
            AnimalClock(),

            // Bottom Menu
            ActionsContainer(),

            // Navigation Button
            navBar,
          ],
        ),
    );
  }

  @override
  GardenModel viewModelBuilder(BuildContext context) => GardenModel();
}

