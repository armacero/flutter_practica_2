import 'package:flutter/material.dart';
import 'package:flutter_practica/DashBoard.Dart';
import 'package:flutter_practica/Login.Dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(
    MaterialApp(
      title: "Proyecto Flutter",
      home: SplashScreenIni(),
    ));

class SplashScreenIni extends StatefulWidget
{
@override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashScreenState();
  }

}

class SplashScreenState extends State<SplashScreenIni>
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SplashScreen(
      seconds: 10,
      navigateAfterSeconds: Login(),
      //navigateAfterSeconds: DashBoard(),
      title: Text("Mi Aplicacion :)",
       style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
       ),
      ),
      image:  Image.network("http://skillesports.com/nube/baners/baneritcelaya.png",width: 450, height: 450),
      gradientBackground: new LinearGradient(colors: [Colors.white, Colors.teal], begin: Alignment.center, end: Alignment.bottomCenter),
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      loaderColor: Colors.red,
    );
  }



}