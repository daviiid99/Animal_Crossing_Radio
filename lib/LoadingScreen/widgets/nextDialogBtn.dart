import 'package:flutter/material.dart';
import '../../Screens/screen.dart';

class NextDialogButton extends StatelessWidget{

  NextDialogButton({
    required this.viewModel,
});

  final LoadingScreenModel viewModel;
  bool buttonPressed = false;

  @override
  Widget build(BuildContext context){

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(top: height * 0.45, left: width * 0.7, right: width  * 0.2  ),
      width: 50,
      height: 50,
      child: IconButton(
        onPressed : (){
         viewModel.updateEventsMessages();
        },
        icon: Icon(Icons.navigate_next_rounded, color: Colors.white, size: 50 ,),
      ),
    );
  }
}