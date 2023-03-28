import 'package:flutter/material.dart';

class AssetGenerator extends StatelessWidget{
  @override
  const AssetGenerator({
    required this.isTree,
    required this.isPalmTree,
    super.key,
});

  final bool isTree;
  final bool isPalmTree;


  @override
  Widget build(BuildContext context){

    PathGenerator currentPath = PathGenerator(isSand: isPalmTree ? true :  false);
    TreeGenerator currentTree = TreeGenerator(isTree: isTree, isPalmTree: isPalmTree);

    return Stack(
      children: [
        // Sky Generator
        SkyGenerator(),
        // Path Generator
        currentPath,
        // Tree Generator
        currentTree,

      ],
    );
  }
}

class SkyGenerator extends StatelessWidget{
  @override
  const SkyGenerator({super.key,});

  @override
  Widget build(BuildContext context){

    String currentSky = "";
    Map<String,dynamic> backgrounds  = {
      "morning" : "assets/res/sky_day.jpeg",
      "afternoon" :  "assets/res/sky_day.jpeg",
      "evening" :  "assets/res/sky_day.jpeg",
    };

    generateSkyFromNow(){
      // This method reads current time and generates a background
      int currentHour = DateTime.now().hour;

      if (currentHour >= 6 && currentHour <= 16){
        currentSky =  backgrounds["morning"];
      } else if (currentHour >= 17 && currentHour <= 20){
        currentSky = backgrounds["afternoon"];
      } else {
        currentSky = backgrounds["evening"];
      }
      return currentSky;
    }

    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(generateSkyFromNow()),
          fit: BoxFit.fitHeight
        )
      ),
    );
  }
}

class TreeGenerator extends StatelessWidget{
  @override
  const TreeGenerator({
    required this.isTree,
    required this.isPalmTree,
    super.key,
});

  final bool isTree;
  final bool isPalmTree;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    String treeAsset = "";

    generateType() {
      // Petite method to determine which type of tree is based on logic
      if (isPalmTree) {
        return treeAsset = "assets/res/palm_tree_model.png";
      } else if (isTree) {
        return treeAsset = "assets/res/tree_model.png";
      } else {
        return treeAsset;
      }
    }

      return Container(
        width: double.maxFinite,
        height: 500,
        margin: EdgeInsets.only(
            top: height * 0.1, left: width * 0.1, right: width * 0.1),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(generateType()),
                fit: BoxFit.fill
            )
        ),
      );
    }
  }



class PathGenerator extends StatelessWidget{
  @override
  const PathGenerator({
    required this.isSand,
    super.key,
  });

  final bool isSand;

  @override
  Widget build(BuildContext context){

    final height = MediaQuery.of(context).size.height;

    return Container(
      width: double.maxFinite,
      height: 400,
      margin: EdgeInsets.only(top: height * 0.6),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(125),
          topRight: Radius.circular(125),
        ),
        image: DecorationImage(
          image: isSand ? const AssetImage("assets/res/sand_model.png") : const AssetImage("assets/res/grass_model.png"),
          fit: BoxFit.fill,
        )
      ),
    );
  }
}