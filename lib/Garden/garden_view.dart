import 'package:animal_crossing_radio/Garden/widgets/animalClock.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../Screens/screen.dart';

class GardenView extends StackedView<GardenModel>{
  @override
  Widget builder(
      BuildContext context,
      GardenModel viewModel,
      Widget? child,
      ){

    return Stack(
      children: [
        // Background
        const AssetGenerator(isTree: true, isPalmTree: false),

        // Menu
        AnimalClock(),

      ],
    );
  }

  @override
  GardenModel viewModelBuilder(BuildContext context) => GardenModel();
}

