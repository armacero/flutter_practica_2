import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_practica/DashBoard.Dart';
import 'package:flutter_practica/peliculas.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;


class Compra extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Compra> {
  SharedPreferences sharedPreferences;
  String asiento = "";
  String funcion="";
  String usuario="";
  String token="";
  List<Container> asien = new List();
  var lis = [
    "A1",
    "A2",
    "A3",
    "A4",
    "A5",
    "A6",
    "A7",
    "A8",
    "B1",
    "B2",
    "B3",
    "B4",
    "B5",
    "B6",
    "B7",
    "B8",
    "C1",
    "C2",
    "C3",
    "C4",
    "C5",
    "C6",
    "C7",
    "C8",
    "D1",
    "D2",
    "D3",
    "D4",
    "D5",
    "D6",
    "D7",
    "D8",
    "E1",
    "E2",
    "E3",
    "E4",
    "E5",
    "E6",
    "E7",
    "E8",
    "F1",
    "F2",
    "F3",
    "F4",
    "F5",
    "F6",
    "F7",
    "F8",
    "G1",
    "G2",
    "G3",
    "G4",
    "G5",
    "G6",
    "G7",
    "G8",
  ];

  @override
  Widget build(BuildContext context) {
    Future<String> getData() async {
      sharedPreferences = await SharedPreferences.getInstance();
      funcion = sharedPreferences.getString("funcion");
      usuario = sharedPreferences.getString("usuario");

      print("f:"+funcion);
      print("u:"+usuario);

//Uri.https(, unencodedPath)

      http.Response response = await http.post(
          Uri.encodeFull(sharedPreferences.getString("ip")+":5000/ws/insert_boleto/"+funcion+"/"+asiento+"/"+usuario),
          headers: {"Accept": "application/json"});


      if (response.statusCode == 200) {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Compra exitosa'),
              content: Text("El boleto se compro con exito!!"),
              actions: <Widget>[
                FlatButton(
                  child: Text('ACEPTAR'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => new DashBoard()));
                  },
                ),
              ],
            );
          },
        );

      }
      if (response.statusCode == 500) {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text("El boleto ya esta vendido!!"),
              actions: <Widget>[
                FlatButton(
                  child: Text('ACEPTAR'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }

    final grid = new GridView.builder(
      itemCount: lis.length,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
      itemBuilder: (BuildContext context, int index) {
        return new GestureDetector(
          child: new Card(
            elevation: 5.0,
            child: new Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage('images/characters/silla.png'),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.center,
              margin: new EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0),
              child: new Text(lis[index], style: TextStyle(color: Colors.white),),
            ),
          ),
          onTap: () {
            asiento = lis[index];
            print(asiento);
            deactivate();
            return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Compra'),
                  content: Text("Asiento seleccionado: " +
                      asiento +
                      "¿Desea continuar con la compra?"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Aceptar'),
                      onPressed: () {
                        Navigator.of(context).pop(getData());
                        //getData();
                      },
                    ),
                    FlatButton(
                      child: Text('Cancelar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              },
            );
          },
        );
      },
    );

    return Scaffold(
        appBar: AppBar(
          title: Text("Seleccionar asiento"),
          backgroundColor: Colors.teal,
        ),
        bottomNavigationBar: Container(
          height: 55.0,
          child: BottomAppBar(
            color: Color.fromRGBO(58, 66, 86, 1.0),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new DashBoard()));
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.reply_all,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new Peliculas()));
                  },
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,

        body: Container(

          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget>[
                Image.asset("images/characters/pantalla.jpg"),
                Flexible(
                        child: grid,
                      )]

            //children: <Widget>[Image.asset("images/characters/pantalla.jpg"),grid],
          ),

        )



        /*Row(
          children: <Widget>[
            Ink.image(image: AssetImage("images/characters/pantalla.jpg")),
            grid
          ],
        )*/



        );
  }
}
