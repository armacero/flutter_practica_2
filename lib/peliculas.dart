import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_practica/DashBoard.Dart';
import 'package:flutter_practica/modelos/Genero.dart';
import 'package:flutter_practica/boletos_compra/funciones.dart';
import 'package:flutter_practica/main.dart';
import 'package:flutter_practica/modelos/pelicula.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sticky_headers/sticky_headers/widget.dart';


class Peliculas extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    //return ListaState();
    return ListaState();
  }
}

class ListaState extends State<Peliculas> {
//List<String> lista = new List<String>();
  List<Pelicula> lista=[];
  List<Genero> listag=[];
  var genp = "";

//List data;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Peliculas"),
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
                            new DashBoard()));
                  },
                ),
              ],
            ),
          ),
        ),
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: listag.length,
          itemBuilder: (BuildContext context, int inde) => new StickyHeader(
            header: new Row(children: <Widget>[
              Visibility(
                child: new Container(
                  height: 40.0,
                  child: new Text(
                    listag[inde].genero,
                    style: TextStyle(
                      color: Color(0xFF097933),
                      fontSize: 25.0,
                      fontFamily: "GoogleSans",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  padding: const EdgeInsets.all(8.0),
                ),
                visible: cate(listag[inde].idgenero),
              ),
            ]),
            content: new Column(
                children: lista
                    .map((val) => Column(
                  children: <Widget>[
                    Visibility(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          child: FittedBox(
                            child: Material(
                              color: Colors.white,
                              elevation: 14.0,
                              borderRadius:
                              BorderRadius.circular(24.0),
                              shadowColor: Color(0x002196F3),
                              child: InkWell(
                                splashColor:
                                Colors.teal.withAlpha(30),
                                onTap: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                          new Funciones()));
                                  SharedPreferences sharedPreferences;
                                  sharedPreferences =
                                  await SharedPreferences.getInstance()
                                  as SharedPreferences;
                                  sharedPreferences.setString("id", val.id_pelicula);
                                },
                                child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(

                                      alignment: Alignment.center,
                                      width: 150,
                                      height: 120,
                                      color: Colors.grey[350],
                                      /*decoration: new BoxDecoration(
                                        gradient: LinearGradient(colors: [const Color(0xFF915FB5), const Color(0xFFCA436B) ],
                                        begin: FractionalOffset.topLeft,
                                          end: FractionalOffset.bottomRight,
                                          stops: [0.0,1.0],
                                          tileMode: TileMode.clamp,
                                        )
                                      ),
                                      decoration: BoxDecoration(borderRadius: new BorderRadius.only(
                                          topLeft: const Radius.circular(40.0),
                                          topRight: const Radius.circular(40.0))),*/
                                      child: ClipRRect(
                                        borderRadius:
                                        new BorderRadius
                                            .circular(24.0),
                                        child: Image(
                                            fit: BoxFit.contain,
                                            alignment: Alignment.center,

                                            image: NetworkImage(
                                                val.imagen)),
                                      ),
                                    ),
                                    Container(
                                      width: 350,
                                      height: 120,
                                      color: Colors.grey[350],
                                      /*decoration: new BoxDecoration(
                                          gradient: LinearGradient(colors: [const Color(0xFF915FB5), const Color(0xFFCA436B) ],
                                            begin: FractionalOffset.topLeft,
                                            end: FractionalOffset.bottomRight,
                                            stops: [0.0,1.0],
                                            tileMode: TileMode.clamp,
                                          )
                                      ),*/

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            val.nombre,
                                            style: TextStyle(
                                              color: Colors.deepOrange,
                                              fontSize: 30.0,
                                              fontFamily:
                                              "GoogleSans",
                                              fontWeight:
                                              FontWeight.bold,
                                            ),
                                            textAlign:
                                            TextAlign.left,
                                          ),
                                          Text(
                                            "dur. " +
                                                val.duracion +
                                                " min",
                                            style: TextStyle(
                                              color:
                                              Color(0xFF7e8375),
                                              fontSize: 15.0,
                                              fontFamily:
                                              "GoogleSans",
                                              fontWeight:
                                              FontWeight.bold,
                                            ),
                                            textAlign:
                                            TextAlign.left,
                                          ),
                                          Text(
                                            "Clasificacion: " +
                                                val.id_clasificacion,
                                            style: TextStyle(
                                              color:
                                              Color(0xFF7e8375),
                                              fontSize: 15.0,
                                              fontFamily:
                                              "GoogleSans",
                                              fontWeight:
                                              FontWeight.bold,
                                            ),
                                            textAlign:
                                            TextAlign.left,
                                          ),
                                          Text(
                                            "Genero: " + val.id_genero,
                                            style: TextStyle(
                                              color:
                                              Color(0xFF7e8375),
                                              fontSize: 15.0,
                                              fontFamily:
                                              "GoogleSans",
                                              fontWeight:
                                              FontWeight.bold,
                                            ),
                                            textAlign:
                                            TextAlign.left,
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
                      ),
                      visible:
                      igual(listag[inde].idgenero, val.id_genero),
                    )
                  ],
                ))
                    .toList()),
          ),
        ),
      ),
    );
  }

  bool igual(String gen, String gep) {
    if (gen == gep) {
      return true;
    } else {
      return false;
    }
  }

  bool cate(String gen) {
    var gep;
    bool vi = false;
    for (int e = 0; e < lista.length; e++) {
      gep = lista[e].id_genero;
      if (gen == gep) {
        vi = true;
      }
    }
    return vi;
  }

  Future<String> getData() async {

    http.Response respons = await http.get(
        Uri.encodeFull(
            sharedPreferences.getString("ip")+":5000/ws/listar_generos"),
        headers: {"Accept": "application/json"});

    if (respons.statusCode == 200) {
      var dat = json.decode(respons.body);
      var rest1 = dat["generos"] as List;
      listag = rest1.map<Genero>((json) => Genero.fromJSON(json)).toList();
      http.Response response = await http.get(
          Uri.encodeFull(
              sharedPreferences.getString("ip")+":5000/ws/listar_peliculas"),
          headers: {"Accept": "application/json"});
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var rest2 = data["peliculas"] as List;
        lista = rest2.map<Pelicula>((json) => Pelicula.fromJSON(json)).toList();
      }
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
