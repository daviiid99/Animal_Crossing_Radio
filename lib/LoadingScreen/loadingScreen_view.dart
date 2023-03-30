import 'package:animal_crossing_radio/LoadingScreen/widgets/npcDialog.dart';
import 'package:animal_crossing_radio/LoadingScreen/widgets/nextDialogBtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

import '../Screens/screen.dart';

class LoadinScreenView extends StackedView<LoadingScreenModel> {
  @override
    Widget builder(
      BuildContext context,
      LoadingScreenModel viewModel,
      Widget? child){


  return Stack(
    children: [
      // Background Color
      BackgroundSplash(),

      // NavbarAnimation
     NavbarAnimation(),

      // Isabelle Dialog
      NpcDialog(message: viewModel.currentMessage, npc : viewModel.currentNpc),

      // Next Dialog Button
      NextDialogButton(viewModel: viewModel,),

      // Skip Button
      SkipButton(),
    ],
  );
  }

  LoadingScreenModel viewModelBuilder(BuildContext context) => LoadingScreenModel();

}