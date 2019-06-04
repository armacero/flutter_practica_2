import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_practica/DashBoard.Dart';
import 'package:flutter_practica/Login.Dart';
import 'package:flutter_practica/categorias.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
bool checkValue=true;
SharedPreferences sharedPreferences;




class SplashScreenState extends State<SplashScreenIni>
{

  @override
  void initState() {
    Verificar();
    super.initState();

  }

  Verificar() async
  {
    sharedPreferences = await SharedPreferences.getInstance();
    var ip='http://192.168.43.14';
    sharedPreferences.setString("ip",ip);
    sharedPreferences.commit();
    if(sharedPreferences.getString("username")=="")
      {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context)=>new Login())

        );

      }
      else
        {
          getCredential();
        }

  }
  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final user = sharedPreferences.getString("username");
    sharedPreferences.setString("usuario",user);
    final pass = sharedPreferences.getString("password");
    sharedPreferences.commit();
    http.Response response = await http.get(
        Uri.encodeFull(sharedPreferences.getString("ip")+":5000/ws/login/${user}/${pass}"),
        headers: { "Accept": "application/json"}
    );

    print(response.body);
   if(response.statusCode==200)
    {
     // DashBoard();
    if(sharedPreferences.getString("categorias")=="") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => new Categoria())

      );
    }else
    {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => new DashBoard())

      );
    }
    }
  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SplashScreen(
      seconds: 10,
      //navigateAfterSeconds: Verificar(),
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