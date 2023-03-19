import 'package:animal_crossing_radio/Control/control.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../DataBases/users.dart';
import '../Home/home.dart';
import '../Welcome/welcome.dart';
import '../android/styles/styles.dart';
import '../android/strings/strings.dart';
import '../android/images.dart';

class TitleScreen extends StatefulWidget{
  @override
  TitleScreenState createState()=> TitleScreenState();
}

class TitleScreenState extends State<TitleScreen> with Control{

  List<String> buttonsName = [novedadesText, licenciasText, sobreText,];
  List<Color> buttonsColor = [newsButtonColor, licenseButtonColor, aboutButtonColor];

  Map<String, dynamic> users = {};
  User user = User(name: "name", picture: "picture", genre: "genre", date_of_birth: "date_of_birth", bells: 0, library: "library");

  getUsers() async {
    // Get all users from database
    try {
      setState(() async {
        users = await user.retrieveUser();
      });
    } catch (e){
      print(e);
    }
  }

  @override
  void initState(){
    enablefullScreenMode();
    getUsers();
    super.initState();
  }

  loadHomeScreen() {
    // automatically redirect user to home screen
    try{
      Home home = Home(userName: users.keys.first, userPicture: users[users.keys.first][0], userDate: users[users.keys.first][2], userGenre :  users[users.keys.first][1], userBells: users[users.keys.first][3],);
      Navigator.push(context, MaterialPageRoute(builder: (context) => home ));
    } catch (e){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Welcome()));
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
                      height :  325,
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