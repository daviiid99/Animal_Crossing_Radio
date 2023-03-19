import 'package:flutter/material.dart';

class Profile extends StatefulWidget{
  @override
  const Profile({
    required this.userName,
    required this.userProfile,
    required this.userDate,
    required this.userGenre,
    super.key
});

  final String userName;
  final String userProfile;
  final String userDate;
  final String userGenre;

  @override
  ProfileState createState() => ProfileState(userName: userName, userProfile: userProfile, userDate: userDate, userGenre: userGenre);
}

class ProfileState extends State<Profile> with TickerProviderStateMixin{
  @override
  ProfileState({
    required this.userName,
    required this.userProfile,
    required this.userDate,
    required this.userGenre,
});

  String userName;
  String userProfile;
  String userDate;
  String userGenre;
  List<String> options = ["Ver Pasaporte", "Mis Datos", "Sobre la App"];

  // Values used for disc rotation
  late AnimationController _controller;
  late Animation<double> _animation;
  final Tween<double> turnsTween = Tween<double>(
    begin: 0,
    end: 1,
  );

  @override
  void initState(){
    animateBackground();
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  animateBackground(){
    _controller=AnimationController(vsync:this,duration: const Duration(seconds: 30));
    _animation=CurvedAnimation(parent: _controller, curve: Curves.easeInCirc);
    _controller.repeat();
  }

  Container userOptions(){
    return Container(
          width : double.maxFinite,
          height : 300,
          child : ListView.builder(
            itemCount: options.length,
            itemBuilder: (context, index){
              return SizedBox(
                  height : 100,
                  child : ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                    child : InkWell(
                    onTap : (){
                      // TO-DO
                    },
                      child : Card(
                      color: Colors.white.withOpacity(0.8),
                      shadowColor: Colors.blueAccent.shade700,
                        child: Row(
                          children: [
                            // Icon
                            const SizedBox(width: 10,),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child : Container(
                              width: 70,
                              height: 70,
                              color: Colors.white.withOpacity(0.5),
                              child :  Image.asset("assets/logo/ac_switch.png"),

                            ),
                            ),
                            const SizedBox(width: 10,),

                            const SizedBox(width: 20,),
                            Text(options[index], style: TextStyle(color: Colors.black, fontSize: 35, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                            const SizedBox(width: 20,),
                          ],
                        ),
                    )
                  ),
                  ),
              );
            }
        ),
    );
  }

  Container profileBanner(){
    return Container(
        width: 250,
        height : 275,
        decoration : BoxDecoration(
          color: Colors.transparent,
          image : DecorationImage(
            image : AssetImage(userProfile)
    )
    ),
    );
  }

  ClipRRect backgroundBanner() {
    // This widget shows current user profile icon
    // Inside a beautiful blue sky background :)

    return ClipRRect(
    borderRadius: BorderRadius.circular(300),
        child : RotationTransition(
        turns: turnsTween.animate(_controller),
        child : Center(
          child : Container(
          width: 300,
          height: 300,
          decoration:  BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background/day_circle.png", ),
              fit: BoxFit.fitHeight
            )
          ),
        ),
        ),
        ),
    );

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child : ListView(
              children: [
                Stack(
                  children: [
                    Center(
                      child:backgroundBanner(),
                    ),
                    // Profile
                    Center(
                      child : Column(
                          children  : [
                            const SizedBox(height: 15,),
                            profileBanner(),
                          ]
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25,),

                // User Name
                Container(
                  color: Colors.blueAccent,
                  height: 75,
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      const Spacer(),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child : Container(
                          color: Colors.white.withOpacity(0.6),
                          height : 50,
                          child : Row(
                              children  : [
                                const SizedBox(width: 25,),
                                Text(userName, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 40), textAlign: TextAlign.center,),
                                const SizedBox(width: 25,),
                              ]
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),

                const SizedBox(height: 25,),

                userOptions(),
              ],
            )
          )
          // Banner
        ],
      ),
    );
  }
}