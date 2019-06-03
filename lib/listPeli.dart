import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_practica/Genero.dart';
import 'package:flutter_practica/main.dart';
import 'package:flutter_practica/pelicula.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_practica/DashBoard.Dart';
import 'package:sticky_headers/sticky_headers.dart';

class ListPeli extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    //return ListaState();
    return ListaState();
  }
}

class ListaState extends State<ListPeli> {
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
                                  onTap: null,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 200,
                                        height: 220,
                                        child: ClipRRect(
                                          borderRadius:
                                          new BorderRadius
                                              .circular(24.0),
                                          child: Image(
                                              fit: BoxFit.contain,
                                              alignment: Alignment
                                                  .topLeft,
                                              image: NetworkImage(
                                                  val.imagen)),
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              val.nombre,
                                              style: TextStyle(
                                                color: Color(
                                                    0xFF097933),
                                                fontSize: 30.0,
                                                fontFamily:
                                                "GoogleSans",
                                                fontWeight:
                                                FontWeight
                                                    .bold,
                                              ),
                                              textAlign:
                                              TextAlign.left,
                                            ),
                                            Text(
                                              "dur. " +
                                                  val.duracion +
                                                  " min",
                                              style: TextStyle(
                                                color: Color(
                                                    0xFF7e8375),
                                                fontSize: 15.0,
                                                fontFamily:
                                                "GoogleSans",
                                                fontWeight:
                                                FontWeight
                                                    .bold,
                                              ),
                                              textAlign:
                                              TextAlign.left,
                                            ),
                                            Text(
                                              "Clasificacion: " +
                                                  val.id_clasificacion,
                                              style: TextStyle(
                                                color: Color(
                                                    0xFF7e8375),
                                                fontSize: 15.0,
                                                fontFamily:
                                                "GoogleSans",
                                                fontWeight:
                                                FontWeight
                                                    .bold,
                                              ),
                                              textAlign:
                                              TextAlign.left,
                                            ),
                                            Text(
                                              "Genero: " +
                                                  val.id_genero,
                                              style: TextStyle(
                                                color: Color(
                                                    0xFF7e8375),
                                                fontSize: 15.0,
                                                fontFamily:
                                                "GoogleSans",
                                                fontWeight:
                                                FontWeight
                                                    .bold,
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
                        visible: igual(
                            listag[inde].idgenero, val.id_genero),
                      )
                    ],
                  ))
                      .toList()),
            ),
          )

        //        }),
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
    http.Response response = await http.get(
      Uri.encodeFull(
          sharedPreferences.getString("ip")+":5000/ws/listar_peliculas"),
    headers: {"Accept": "application/json"});
      print(respons.statusCode);
    if (respons.statusCode == 200) {

      var dat = jsonDecode(respons.body);
      var data = jsonDecode(response.body);
      var rest1 = dat["generos"] as List;
      var rest2 = data["peliculas"] as List;
      //print(dat);
      //print(data);

      listag = rest1.map<Genero>((json) => Genero.fromJSON(json)).toList();
      print(listag);
      if (response.statusCode == 200) {

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
