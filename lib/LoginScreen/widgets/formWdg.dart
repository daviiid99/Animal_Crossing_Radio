import 'package:animal_crossing_radio/Control/control.dart';
import 'package:flutter/material.dart';
import '../../Screens/screen.dart';

class FormWdg extends StatelessWidget{

  const FormWdg({
    super.key,
    required this.isLogin,
});

  final bool isLogin;

  @override
  Widget build(BuildContext context){

    FormBanner banner = FormBanner(isLogin: isLogin);
    FormNavBarButton button = FormNavBarButton(isLogin: isLogin, mainContext: context,);
    FormFields fields = FormFields(mainContext: context,);

    final size = MediaQuery.of(context).size;
    return Container(
      width: 400,
      height: 400,
      margin: EdgeInsets.only(top: size.height *  0.3, left: 20, right: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.5,
            blurRadius: 7,
            offset: Offset(0,3),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          // Banner
          Column(
          children : [
            // Banner
            const SizedBox(height: 20,),
            banner,
            const SizedBox(height: 40,),

            // Fields
            FormFields(mainContext: context,),
            const SizedBox(height: 20,),

            // Button
            button,
            const SizedBox(height: 20,),

            ],
          ),
        ],
      ),
    );
  }
}

class FormBanner extends StatelessWidget{

  const FormBanner({
   super.key,
    required this.isLogin,
});

  final bool isLogin;

  @override
  Widget build(BuildContext context){
    return Row(
      children: [
        const Spacer(),
         DefaultTextStyle(
          style: TextStyle(color: Colors.grey, fontSize: 35, fontWeight: FontWeight.bold),
          child : isLogin ? Text("Iniciar Sesión",) : Text("Crear Cuenta")),
        const Spacer(),
      ],
    );
  }
}

class FormFields extends StatelessWidget with Control{

  FormFields({
    super.key,
    required this.mainContext,
});

  final BuildContext mainContext;
  static TextEditingController name = TextEditingController(text: "");
  static TextEditingController password = TextEditingController(text: "");
  static String nameErrorMessage = "";
  static String passwordErrorMessage = "";

  @override
  hotReload(BuildContext context) {
    // TODO: implement hotReload
    return super.hotReload(context);
  }

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Row(
          children: [
            // Name Text Field
            const SizedBox(width: 15,),
            SizedBox(
              width: 360,
              height: 100,
              child: TextField(
                controller: name,
                textAlign: TextAlign.left,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  errorText: nameErrorMessage  ,
                  errorStyle: TextStyle(color: Colors.red),
                  alignLabelWithHint: true,
                  icon: Icon(Icons.face_rounded, color: Colors.blue,),
                  hintText: "Introduce un nombre",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ) ,
            ),
            const SizedBox(width: 15,)
          ],
        ),

        Row(
          children: [
            // Password Text Field
            const SizedBox(width: 15,),
            SizedBox(
              width: 360,
              height: 100,
              child: TextField(
                controller: password,
                textAlign: TextAlign.left,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  errorText: passwordErrorMessage,
                  hintText: "Introduce una contraseña",
                  alignLabelWithHint: true,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                  icon: Icon(Icons.lock_rounded, color: Colors.blue,)
                ),
              ),
            ),
            const SizedBox(width: 15,),
          ],
        )

      ],
    );
  }
}

class FormNavBarButton extends StatelessWidget with Control{

  FormNavBarButton({
    super.key,
    required this.isLogin,
    required this.mainContext,
});

  final bool isLogin;
  bool success = false;
  String log = "";
  final BuildContext mainContext;

  @override
  Widget build(BuildContext context){

    FormFields instance = FormFields(mainContext: context);

    return Row(
      children: [
        const SizedBox(width: 95,),
        SizedBox(
          width: 200,
          height: 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
              child : TextButton(
              onPressed : () async {

                if (FormFields.name.text.toString().isEmpty){
                  FormFields.nameErrorMessage = "El campo nombre es obligatorio";
                  instance.hotReload(mainContext);

                }

                if (FormFields.password.text.toString().isEmpty){
                  FormFields.passwordErrorMessage = "El campo contraseña es obligatorio";
                  instance.hotReload(mainContext);
                }

                if (isLogin){
                  log = await CheckUsers.verifyUser(FormFields.name.text.toString(), FormFields.password.text.toString());
                  if (log == "success"){
                    FormFields.nameErrorMessage = "";
                    FormFields.passwordErrorMessage = "";
                    instance.hotReload(mainContext);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TitleScreen()));
                  }

                  else if (log == "unknown_name") {
                    if (FormFields.name.text.toString().isEmpty){
                      FormFields.nameErrorMessage = "El campo nombre es obligatorio";
                    } else {
                      FormFields.nameErrorMessage = "Este usuario no existe";
                      if (FormFields.password.text.toString().isEmpty){
                        FormFields.passwordErrorMessage = "El campo contraseña es obligatorio";
                      } else {
                        FormFields.passwordErrorMessage = "";
                      }
                      instance.hotReload(mainContext);
                    }

                  } else if (log == "bad_password"){
                    if (FormFields.password.text.toString().isEmpty){
                      FormFields.passwordErrorMessage =  "El campo contraseña es obligatorio";
                    } else {
                      FormFields.passwordErrorMessage =  "El campo contraseña no coincide";
                    }
                    FormFields.nameErrorMessage = "";
                    instance.hotReload(mainContext);
                  }
                } else {
                  if(FormFields.password.text.toString().isNotEmpty && FormFields.name.text.toString().isNotEmpty)
                  success = await CheckUsers.registerUser(FormFields.name.text.toString(), FormFields.password.text.toString());
                  if (success){
                    FormFields.nameErrorMessage = "";
                    FormFields.passwordErrorMessage = "";
                    instance.hotReload(mainContext);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TitleScreen()));

                  }
              }
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              child: isLogin ? Text("Comprobar", style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.center,) : Text("Registrar", style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.center,),
           ),
          ),
        ),
        const SizedBox(width: 95,),
      ],
    );
  }
}