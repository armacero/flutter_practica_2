import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_practica/modelos/Funcion.dart';
import 'package:flutter_practica/boletos_compra/compra.dart';
import 'package:flutter_practica/DashBoard.Dart';
import 'package:flutter_practica/peliculas.dart';

class Funciones extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    //return ListaState();
    return ListaState();
  }
}

class ListaState extends State<Funciones> {
//List<String> lista = new List<String>();
  List<Funcion> lista=[];

//List data;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Funciones"),
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
                    Navigator.push(
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
        body: ListView.builder(
            itemCount: lista.length,
            itemBuilder: (BuildContext context, int index) {


              return

                    _buildItem(lista[index].nompelicula,"Sala: "+lista[index].sala+"   Hora: "+lista[index].hora,context,lista[index].idfuncion);





                /*Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  child: FittedBox(
                    child: Material(
                      color: Colors.white,
                      elevation: 14.0,
                      borderRadius: BorderRadius.circular(24.0),
                      shadowColor: Color(0x002196F3),
                      child: InkWell(
                        splashColor: Colors.teal.withAlpha(30),
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                  new Compra()));
                          SharedPreferences sharedPreferences;
                          sharedPreferences =
                          await SharedPreferences.getInstance()
                          as SharedPreferences;
                          sharedPreferences.setString("funcion", lista[index].idfuncion);
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    lista[index].nompelicula,
                                    style: TextStyle(
                                      color: Color(0xFF097933),
                                      fontSize: 30.0,
                                      fontFamily: "GoogleSans",
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    "Sala: " + lista[index].sala,
                                    style: TextStyle(
                                      color: Color(0xFF7e8375),
                                      fontSize: 15.0,
                                      fontFamily: "GoogleSans",
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    lista[index].hora,
                                    style: TextStyle(
                                      color: Color(0xFF7e8375),
                                      fontSize: 15.0,
                                      fontFamily: "GoogleSans",
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );*/
              /*return Card(
                child: Container(
                  padding: EdgeInsets.only(
                      top: 40.0, left: 10.0, right: 10.0, bottom: 10.0),
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            lista[index].nompelicula,
                            style: TextStyle(
                              color: Color(0xFF097933),
                              fontSize: 30.0,
                              fontFamily: "GoogleSans",
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text("Sala: "+lista[index].sala,
                            style: TextStyle(
                              color: Color(0xFF7e8375),
                              fontSize: 15.0,
                              fontFamily: "GoogleSans",
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(lista[index].hora,
                            style: TextStyle(
                              color: Color(0xFF7e8375),
                              fontSize: 15.0,
                              fontFamily: "GoogleSans",
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      //Text('Nombre de la pelicula ${index}'),
                    ],
                  ),
                ),
              );*/
            }),
      ),
    );


  }

  Future<String> getData() async {
    SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences.getString("id");
    http.Response response = await http.get(
        Uri.encodeFull(
            sharedPreferences.getString("ip")+":5000/ws/listar_funciones/" +
                id),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var rest = data["funciones"] as List;
      lista = rest.map<Funcion>((json) => Funcion.fromJSON(json)).toList();
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
}
Widget _buildItem(String textTitle, String subtitulo , BuildContext context, String funcion) {

  return new ListTile(

    title: new Text(textTitle),

    subtitle: new Text(subtitulo),

    leading: new Icon(Icons.map),

    onTap: () async {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
              new Compra()));
      SharedPreferences sharedPreferences;
      sharedPreferences =
      await SharedPreferences.getInstance()
      as SharedPreferences;
      sharedPreferences.setString("funcion", funcion);
    },

  );

}
