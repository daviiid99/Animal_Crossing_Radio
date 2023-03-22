import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Screens/screen.dart';


class TitleScreen extends StatefulWidget{
   TitleScreen({
    required this.userNameLogin,
    super.key,
    this.usersData,
});

  final String userNameLogin;
  List<User>? usersData = [];

  @override
  TitleScreenState createState()=> TitleScreenState(userNameLogin: userNameLogin, usersData :  usersData);
}

class TitleScreenState extends State<TitleScreen> with Control{
   TitleScreenState({
    required this.userNameLogin,
     this.usersData,
});

  final String userNameLogin;
  List<User>? usersData = [];

  List<String> buttonsName = [novedadesText, licenciasText, sobreText,];
  List<Color> buttonsColor = [newsButtonColor, licenseButtonColor, aboutButtonColor];
  bool userMatches = false;
  String userName = "";
  String userPicture = "";
  String userDate = "";
  String userGenre = "";
  int userBells = 0;
  List<User> users = [];

   assignUserToLogin() async {
      // We need to compare every user with current login user
     // If no user matches current login, a new user will be created

       for(User user in usersData!){
         if (user.userID == userNameLogin){
           setState(() {
             userMatches = true;
             userName = user.name;
             userPicture = user.picture;
             userDate = user.dateOfBirth;
             userGenre = user.genre;
             userBells = user.bells;
           });
         }
       }

   }

  @override
  void initState(){
    enablefullScreenMode();
    assignUserToLogin();
    super.initState();
  }

  loadHomeScreen() {
    // automatically redirect user to home screen
    print(users);
    if (userMatches){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home(userName: userName, userPicture: userPicture, userDate: userDate, userGenre: userGenre, userBells: userBells)));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Welcome(userID: userNameLogin,)));
    }
  }

  Row navButton(){
    // A button for navigation bar
    return Row(
      children  : [
        const SizedBox(width: 50,),
        Expanded(
          child : ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child : TextButton(
              onPressed: (){
                loadHomeScreen();
              },
              style: TextButton.styleFrom(
                  backgroundColor: blueColor
              ),
              child: Column(
                  children  : [
                    const SizedBox(height: 15,),
                    Text(empezarText, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30,), textAlign: TextAlign.center,),
                    const SizedBox(height: 15,),
                  ]
              ),
            ),
          ),
        ),
        const SizedBox(width: 50,),
      ],
    );
  }

  Row helpMenuButtons(){
    // A menu to display information about some app in general
    return Row(
        children : [
          const Spacer(),
          ClipRRect(
          borderRadius: BorderRadius.circular(25),
            child : Container(
              width: 360,
              height: 300,
              color : titleScreenColor,
              child: ListView.builder(
                  itemCount: buttonsName.length,
                  itemBuilder: (context, index){
                    return Column(
                        children  : [
                          const SizedBox(height: 10,),
                          Row(
                            children  : [
                              const SizedBox(width : 10),
                              InkWell(
                                onTap : () => print("I'm alive!"),
                                child : ClipRRect(
                                  borderRadius : BorderRadius.circular(20),
                                  child : Container(
                                    width: 340,
                                    height: 80,
                                    color: buttonsColor[index],
                                    child: Row(
                                      children: [
                                        const Spacer(),
                                        Text(buttonsName[index], style: const TextStyle(color: fontDarkColor, fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                                        const Spacer(),
                                      ],
                                    ),
                                   ),
                                ),
                              ),
                              const SizedBox(width : 10),
                            ],
                          ),
                          const SizedBox(height: 5,),
                    ],
                    );
                  },
              )
            )
          ),
          const Spacer(),
        ],
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: blueColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: titleScreenColor,
        title: Row(
          children: [
            const SizedBox(width: 15,),
            Text(versionText, style: TextStyle(color: Colors.black, fontSize: versionSize, fontWeight: FontWeight.bold),),
            const Spacer(),
            Text(versionDateText, style: TextStyle(color: fontLightColor, fontWeight: FontWeight.bold, fontSize: versionDateSize),),
            const SizedBox(width: 15,),

        ],),
      ),
      body: Column(
        children: [
          // Logo
          Expanded(
              child: ListView(
                children: [
                  ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),),
                    child : Container(
                      width : double.maxFinite,
                      height :  260,
                      decoration: BoxDecoration(
                          color: titleScreenColor,
                        image: DecorationImage(
                          image: AssetImage(bannerImage),
                          fit: BoxFit.fitHeight,
                        )
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  helpMenuButtons(),
                  const SizedBox(height: 20,),
                ],
              )),
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(70),
                  topLeft: Radius.circular(70),
              ),
                child : Container(
                  height :  150,
                  width : double.maxFinite,
                  color : Colors.white,
                  child : Column(
                  children: [
                    const SizedBox(height: 40,),
                    navButton(),
                    const SizedBox(height: 25,),
                  ],
                 ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}