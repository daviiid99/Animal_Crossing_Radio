import 'package:animal_crossing_radio/LoginScreen/loginScreen.dart';
import 'package:flutter/material.dart';
import '../../Screens/screen.dart';

class FooterWdg extends StatelessWidget with Control{
  FooterWdg({
   super.key,
   required this.context,
    required this.isLogin,
});

  BuildContext context;
  LoginScreen login = LoginScreen();
  bool isLogin;

  @override
  Widget build(BuildContext context){
    return Row(
      children: [
        const Spacer(),
        InkWell(
          onTap : (){
            // TO-DO
            if (isLogin){
              login.userAction = true;

            } else {
              login.userAction = false;
            }

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => login));

          },
          child : isLogin ? Text("Crear Nueva Cuenta", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center,) : Text("Iniciar Sesión", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
        ),
        const Spacer(),
      ],
    );
  }

}