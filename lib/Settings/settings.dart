import 'package:flutter/material.dart';

class Settings extends StatefulWidget{
  @override
  const Settings({
   super.key,
});

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings>{

  final List<String> questionsTitle = ["¿Que es Animal Crossing Radio?", "¿Puedo usar esta app sin Wi-Fi?", "¿Porqué ocupa tanto esta aplicación?", "¿Es legal esta aplicación?"];

  @override
  void initState(){
    super.initState();
  }

  SizedBox settingsBanner() {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          Expanded(
            child : ListView(
              children: [
                InkWell(
                  onTap : (){},
                  child : Image.asset("assets/banner_settings.png")),
              ],
            )
          )
        ],
      ),
    );
  }

  Expanded frequentQuestions(){
    return Expanded(
      child: ListView.builder(
          itemCount: questionsTitle.length,
          itemBuilder: (context, index){
            return Column(
              children: [
                InkWell(
                  onTap: (){},
                  child : Card(
                  color: Colors.white,
                  child: Row(
                    children: [
                      ListTile(
                        leading : const Icon(Icons.question_mark_rounded, color: Colors.blueAccent, size: 15,),
                        title: Row(children: [Text(questionsTitle[index], style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)) ,const Spacer()],),
                      )
                    ],
                  ),
                )
                ),
              ],
            );
            },
      )
    );
  }

  Expanded socialLinks(){
    return Expanded(
              child: ListView(
                children  : [
                  Row(
                  children  : [
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        child : ClipRRect(
                          child : Card(
                        child: Image.asset("assets/disc/3ds.png"),
                      ),
                        ),
                      ),
                    ),

                    const Spacer(),

                    SizedBox(
                      height: 100,
                      width: 100,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        child : ClipRRect(
                          child : Card(
                            child: Image.asset("assets/disc/3ds.png"),
                          ),
                        ),
                      ),
                    ),

                    const Spacer(),

                    SizedBox(
                      height: 100,
                      width: 100,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        child : ClipRRect(
                          child : Card(
                            child: Image.asset("assets/disc/3ds.png"),
                          ),
                        ),
                      ),
                    ),

                    const Spacer(),

                    SizedBox(
                      height: 100,
                      width: 100,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        child : ClipRRect(
                          child : Card(
                            child: Image.asset("assets/disc/3ds.png"),
                          ),
                        ),
                      ),
                    ),

                    const Spacer(),

                    SizedBox(
                      height: 100,
                      width: 100,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        child : ClipRRect(
                          child : Card(
                            child: Image.asset("assets/disc/3ds.png"),
                          ),
                        ),
                      ),
                    ),

                    const Spacer(),
              ],
              ),
                ]
              )
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [

          // Banner
          settingsBanner(),
          const SizedBox(height: 20,),

          // Title
            Row(
              children: const [
                 Spacer(),
                 Text("Frequent Questions", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30), textAlign: TextAlign.center,),
                 Spacer(),
              ],
            ),

          const SizedBox(height: 40,),

          // Frequent Questions
          frequentQuestions(),

          // Social
          socialLinks(),

        ],
      ),
    );
  }
}