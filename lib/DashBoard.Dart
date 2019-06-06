import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_practica/Conversor.Dart';
import 'package:flutter_practica/practicaSQFLITE/Lista.Dart';
import 'package:flutter_practica/Login.Dart';
import 'package:flutter_practica/boletos_compra/boletos.dart';
import 'package:flutter_practica/todoFirabase/categorias.dart';
import 'package:flutter_practica/detail_page.dart';
import 'package:flutter_practica/practicaSQFLITE/homescreen.dart';
import 'package:flutter_practica/intenciones/homeIntenciones.dart';
import 'package:flutter_practica/practicaSQFLITE/list.dart';
import 'package:flutter_practica/boletos_compra/listPeli.dart';
import 'package:flutter_practica/list_page.dart';
import 'package:flutter_practica/main.dart';
import 'package:flutter_practica/modelos/pelicula.dart';
import 'package:flutter_practica/peliculas.dart';
import 'package:flutter_practica/practicaSQFLITE/practicasql.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class DashBoard extends StatelessWidget{
  final List<Pelicula> lista=[];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Dashboard",
      home: MenuLateral(),
    );
  }
}


class MenuLateral extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MenuLateralState();
  }
}

class MenuLateralState extends State<MenuLateral>{
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height * 0.4;
    double width = MediaQuery
        .of(context)
        .size
        .width * 0.85;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard Cine"),
        backgroundColor: Colors.teal,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.teal
              ),
              accountName: Text("Armando !!!!"),
              accountEmail: Text("13030594@itcelaya.edu.mx"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: new NetworkImage('http://i.pravatar.cc/300'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.airplay),
              title: Text("Peliculas"),
              trailing: Icon(Icons.account_box),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context)=>new Lista())

                );
                //Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_box),
              title: Text("Acerca de"),
              trailing: Icon(Icons.account_box),
              onTap: (){
                // Cerramos el drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.track_changes),
              title: Text("Conversor"),
              trailing: Icon(Icons.album),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Conversor() ));
                // Cerramos el drawer
                //Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text("lista de Peliculas"),

              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Peliculas() ));
                // Cerramos el drawer
                //Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.confirmation_number),
              title: Text("Boletos comprados"),

              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Boletos() ));
                // Cerramos el drawer
                //Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text("Categorias Favoritas "),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => new Categoria()));
                //Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.data_usage),
              title: Text("Practica SQFLITE"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => new Practica()));
                //Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.data_usage),
              title: Text("Intenciones"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => new HomeIntenciones()));
                //Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Cerrar session"),
              trailing: Icon(Icons.account_circle),
              onTap: (){
                salirSession();
                //Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      //contenido
     // body: Text("CINE"),

      body: ListView.builder(
          itemCount: lista==null?0:lista.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: new BoxDecoration(
                    gradient: LinearGradient(colors: [const Color(0xFF915FB5), const Color(0xFFCA436B) ],
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      stops: [0.0,1.0],
                      tileMode: TileMode.clamp,
                    )
                ),
                child: FittedBox(
                  child: Material(
                    color: Colors.white,
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(24.0),
                    shadowColor: Color(0x002196F3),
                    child: InkWell(
                      splashColor: Colors.teal.withAlpha(30),
                      onTap: null,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 150,

                            child: ClipRRect(
                              borderRadius: new BorderRadius.circular(30.0),
                              child: Image(
                                  fit: BoxFit.contain,
                                  alignment: Alignment.topLeft,
                                  image: NetworkImage(lista[index].imagen),
                                width: 200,
                                height: 300,),
                            ),
                          ),
                          Container(

                            width: 400,
                            height: 150,
                            child: Column(
                              
                              children: <Widget>[
                                Text(
                                  lista[index].nombre,
                                  style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 30.0,
                                    fontFamily: "GoogleSans",
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "duracion: " + lista[index].duracion + " min",
                                  style: TextStyle(
                                    color: Color(0xFF7e8375),
                                    fontSize: 15.0,
                                    fontFamily: "GoogleSans",
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "Clasificacion: " +
                                      lista[index].id_clasificacion,
                                  style: TextStyle(
                                    color: Color(0xFF7e8375),
                                    fontSize: 15.0,
                                    fontFamily: "GoogleSans",
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "Genero: " + lista[index].id_genero,
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
            );
          }),

  /*    Container(
        alignment: Alignment.center,
        constraints: BoxConstraints.expand(height: 50),
        child: Text(
          "Categorias",
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),

      ),
*/
    );
  }

  void salirSession() async {
    SharedPreferences sharedPreferences;

    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {

      sharedPreferences.setString("username", "");
      sharedPreferences.setString("password", "");
      sharedPreferences.commit();

    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context)=>new Login())

    );

  }

  Future<String> getData() async {
    //lista = new List();
    http.Response response = await http.get(
        Uri.encodeFull(
            sharedPreferences.getString("ip")+":5000/ws/listar_estrenos"),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
        var rest = data["estrenos"] as List;
      lista = rest.map<Pelicula>((json) => Pelicula.fromJSON(json)).toList();
    }
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getData();
  }


}

