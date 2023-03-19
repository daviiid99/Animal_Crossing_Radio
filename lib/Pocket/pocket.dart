import 'package:flutter/material.dart';
import '../Data/items.dart';
import '../Data/pockets.dart';
import '../DataBases/item.dart';
import '../DataBases/pocket.dart';

class Pocket extends StatefulWidget{
  @override
  Pocket({
    super.key,
    required this.userName,
    required this.userBells,
    required this.pockets,
  });

  final String userName;
  final int userBells;
  final Map<String,dynamic> pockets;

  @override
  PocketState createState() => PocketState(userName: userName, userBells : userBells, pocket: pockets);
}

class PocketState extends State<Pocket>{
  PocketState({
    required this.userName,
    required this.userBells,
    required this.pocket,
});

  final String userName;
  final int userBells;
  final Map<String,dynamic> pocket;

  @override
  void initState(){
    print(pocket);
    super.initState();
  }

  Container backPackBanner() {
    return Container(
      width: double.maxFinite,
      height: 250,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/res/backpack.png"),
          fit: BoxFit.fitHeight
        )
      ),
    );
  }

  ClipRRect bellsBox(){
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
        child : Container(
        color: Colors.white,
        width: 250,
        height: 100,
          child: Row(
            children: [
              const SizedBox(width: 25,),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child : Container(
                height: 80,
                width: 80,
                color: Colors.yellowAccent,
                child: Image.asset("assets/items/bolsa_grande.png"),
              ),
              ),
              Container(
                width: 150,
                height: 50,
                color: Colors.white,
                child: Row(
                  children: [
                    const Spacer(),
                    Text(userBells.toString(), style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                    const Spacer(),
                  ],
                )
              ),
              const SizedBox(width: 25,),

            ],
          ),

        )
    );

  }

  ClipRRect pocketLayout(){
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
        child : Container(
      color: Colors.white,
      width: double.maxFinite,
      height: 500,
      child: Column(
        children: [
          // First Row // 0-4
              const SizedBox(height: 25,),
              Row(
                children: [
                  const SizedBox(width: 25,),
                  InkWell(
                    onTap : (){},
                    child : ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child : Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey.withOpacity(0.3),
                        child: Stack(
                          children  : [
                            Column( children : [ Image.asset(pocket["0"][0])]),
                            if(pocket["0"][2] != "" && pocket["0"][2] != "1")
                            Column(children: [const SizedBox(height: 60,), Row(children: [const Spacer(),ClipRRect( borderRadius: BorderRadius.circular(30), child : Container(width : 30, height : 30, color: Colors.white, child: Text(pocket["0"][2], style: TextStyle(color: Colors.black, fontSize: 25,), textAlign: TextAlign.center,),))],)],)
                        ]
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 25,),
                  InkWell(
                    onTap : (){},
                    child : ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child : Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey.withOpacity(0.3),
                        child: Stack(
                            children  : [
                              Column( children : [ Image.asset(pocket["1"][0])]),
                              if(pocket["1"][2] != "" && pocket["1"][2] != "1")
                              Column(children: [const SizedBox(height: 60,), Row(children: [const Spacer(),ClipRRect( borderRadius: BorderRadius.circular(30), child : Container(width : 30, height : 30, color: Colors.white, child: Text(pocket["1"][2], style: TextStyle(color: Colors.black, fontSize: 25,), textAlign: TextAlign.center,),))],)],)
                            ]
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 25,),
                  InkWell(
                    onTap : (){},
                    child : ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child : Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey.withOpacity(0.3),
                        child: Stack(
                            children  : [
                              Column( children : [ Image.asset(pocket["2"][0])]),
                              if(pocket["2"][2] != "" && pocket["2"][2] != "1")
                              Column(children: [const SizedBox(height: 60,), Row(children: [const Spacer(),ClipRRect( borderRadius: BorderRadius.circular(30), child : Container(width : 30, height : 30, color: Colors.white, child: Text(pocket["2"][2], style: TextStyle(color: Colors.black, fontSize: 25,), textAlign: TextAlign.center,),))],)],)
                            ]
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25,),
                ],
              ),
              const SizedBox(height: 25,),
              Row(
                children: [
                  const SizedBox(width: 25,),
                  InkWell(
                    onTap : (){},
                    child : ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child : Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey.withOpacity(0.3),
                        child: Stack(
                            children  : [
                              Column( children : [ Image.asset(pocket["3"][0])]),
                              if(pocket["3"][2] != "" && pocket["3"][2] != "1")
                              Column(children: [const SizedBox(height: 60,), Row(children: [const Spacer(),ClipRRect( borderRadius: BorderRadius.circular(30), child : Container(width : 30, height : 30, color: Colors.white, child: Text(pocket["3"][2], style: TextStyle(color: Colors.black, fontSize: 25,), textAlign: TextAlign.center,),))],)],)
                            ]
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 25,),
                  InkWell(
                    onTap : (){},
                    child : ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child : Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey.withOpacity(0.3),
                        child: Stack(
                            children  : [
                              Column( children : [ Image.asset(pocket["4"][0])]),
                              if(pocket["4"][2] != "" && pocket["4"][2] != "1")
                              Column(children: [const SizedBox(height: 60,), Row(children: [const Spacer(),ClipRRect( borderRadius: BorderRadius.circular(30), child : Container(width : 30, height : 30, color: Colors.white, child: Text(pocket["4"][2], style: TextStyle(color: Colors.black, fontSize: 25,), textAlign: TextAlign.center,),))],)],)
                            ]
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 25,),
                  InkWell(
                    onTap : (){},
                    child : ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child : Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey.withOpacity(0.3),
                        child: Stack(
                            children  : [
                              Column( children : [ Image.asset(pocket["5"][0])]),
                              if(pocket["5"][2] != "" && pocket["5"][2] != "1")
                              Column(children: [const SizedBox(height: 60,), Row(children: [const Spacer(),ClipRRect( borderRadius: BorderRadius.circular(30), child : Container(width : 30, height : 30, color: Colors.white, child: Text(pocket["5"][2], style: TextStyle(color: Colors.black, fontSize: 25,), textAlign: TextAlign.center,),))],)],)
                            ]
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25,),
                ],
              ),
              const SizedBox(height: 25,),
              Row(
                children: [
                  const SizedBox(width: 25,),
                  InkWell(
                    onTap : (){},
                    child : ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child : Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey.withOpacity(0.3),
                        child: Stack(
                            children  : [
                              Column( children : [ Image.asset(pocket["6"][0])]),
                              if(pocket["6"][2] != "" && pocket["6"][2] != "1")
                              Column(children: [const SizedBox(height: 60,), Row(children: [const Spacer(),ClipRRect( borderRadius: BorderRadius.circular(30), child : Container(width : 30, height : 30, color: Colors.white, child: Text(pocket["6"][2], style: TextStyle(color: Colors.black, fontSize: 25,), textAlign: TextAlign.center,),))],)],)
                            ]
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 25,),
                  InkWell(
                    onTap : (){},
                    child : ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child : Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey.withOpacity(0.3),
                        child: Stack(
                            children  : [
                              Column( children : [ Image.asset(pocket["7"][0])]),
                              if(pocket["7"][2] != "" && pocket["7"][2] != "1")
                              Column(children: [const SizedBox(height: 60,), Row(children: [const Spacer(),ClipRRect( borderRadius: BorderRadius.circular(30), child : Container(width : 30, height : 30, color: Colors.white, child: Text(pocket["7"][2], style: TextStyle(color: Colors.black, fontSize: 25,), textAlign: TextAlign.center,),))],)],)
                            ]
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 25,),
                  InkWell(
                    onTap : (){},
                    child : ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child : Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey.withOpacity(0.3),
                        child: Stack(
                            children  : [
                              Column( children : [ Image.asset(pocket["8"][0])]),
                              if(pocket["8"][2] != "" && pocket["8"][2] != "1")
                              Column(children: [const SizedBox(height: 60,), Row(children: [const Spacer(),ClipRRect( borderRadius: BorderRadius.circular(30), child : Container(width : 30, height : 30, color: Colors.white, child: Text(pocket["8"][2], style: TextStyle(color: Colors.black, fontSize: 25,), textAlign: TextAlign.center,),))],)],)
                            ]
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25,),
                ],
              ),
              const SizedBox(height: 25,),
              Row(
                children: [
                  const SizedBox(width: 25,),
                  InkWell(
                    onTap : (){},
                    child : ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child : Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey.withOpacity(0.3),
                        child: Stack(
                            children  : [
                              Column( children : [ Image.asset(pocket["9"][0])]),
                              if(pocket["9"][2] != "" && pocket["9"][2] != "1")
                              Column(children: [const SizedBox(height: 60,), Row(children: [const Spacer(),ClipRRect( borderRadius: BorderRadius.circular(30), child : Container(width : 30, height : 30, color: Colors.white, child: Text(pocket["9"][2], style: TextStyle(color: Colors.black, fontSize: 25,), textAlign: TextAlign.center,),))],)],)
                            ]
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 25,),
                  InkWell(
                    onTap : (){},
                    child : ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child : Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey.withOpacity(0.3),
                        child: Stack(
                            children  : [
                              Column( children : [ Image.asset(pocket["10"][0])]),
                              if(pocket["10"][2] != "" && pocket["10"][2] != "1")
                              Column(children: [const SizedBox(height: 60,), Row(children: [const Spacer(),ClipRRect( borderRadius: BorderRadius.circular(30), child : Container(width : 30, height : 30, color: Colors.white, child: Text(pocket["10"][2], style: TextStyle(color: Colors.black, fontSize: 25,), textAlign: TextAlign.center,),))],)],)
                            ]
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 25,),
                  InkWell(
                    onTap : (){},
                    child : ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child : Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey.withOpacity(0.3),
                        child: Stack(
                            children  : [
                              Column( children : [ Image.asset(pocket["11"][0])]),
                              if(pocket["11"][2] != "" && pocket["11"][2] != "1")
                              Column(children: [const SizedBox(height: 60,), Row(children: [const Spacer(),ClipRRect( borderRadius: BorderRadius.circular(30), child : Container(width : 30, height : 30, color: Colors.white, child: Text(pocket["11"][2], style: TextStyle(color: Colors.black, fontSize: 25,), textAlign: TextAlign.center,),))],)],)
                            ]
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25,),
                ],
              ),
            ],
          ),
        ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.orangeAccent,
      ),
      body: Column(
        children: [
          // Banner
          backPackBanner(),
          // Bells
          Row(
            children: [
              const Spacer(),
              bellsBox(),
              const Spacer(),
                    ],
                  ),
          const SizedBox(height: 50,),
          // Pockets
          Expanded(
              child: ListView(
                children: [
                  pocketLayout(),
                ],
              ))
         ]
      ),
    );
  }
}