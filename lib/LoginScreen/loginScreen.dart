import 'package:flutter/material.dart';
import '../Dependencies/dependencies.dart';
import '../Screens/screen.dart';

class LoginScreen extends StatefulWidget{
  @override
  LoginScreenState createState() => LoginScreenState(userAction : userAction);
  bool userAction = false;

}

class LoginScreenState extends State<LoginScreen> with Control{
  @override
  LoginScreenState({
   required this.userAction,
});

  bool existingUsers = false;
  bool userAction;
  bool isLogin = false;

  void preparations() async {
    setState(() async {
      existingUsers = await CheckUsers.readDataBaseUsers(); // Check current users if any
      if (existingUsers){
        // There's at least one entry in database
        setState(() {
          isLogin = true;
        });
      } else {
        setState(() {
          isLogin = false;
        });
      }
    });
  }

  @override
  void initState(){
    if(!userAction) preparations();
    super.initState();
  }


  @override
  Widget build(BuildContext context){

    FormWdg form = FormWdg(isLogin: isLogin);
    final size = MediaQuery.of(context).size;
    FooterWdg footer = FooterWdg(context: context, isLogin : isLogin);

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
          ListView(
                children: [
                  form,
                ],
              ),

          // Create account footer
          Container(
            width: double.maxFinite,
            height: 50,
            margin: EdgeInsets.only(top: size.height * 0.9, ),
            child : footer,
          ),
        ],
      ),
    );
  }
}