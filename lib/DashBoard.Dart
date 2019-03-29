import 'package:flutter/material.dart';
import 'package:flutter_practica/Conversor.Dart';
import 'package:flutter_practica/Lista.Dart';
import 'package:flutter_practica/Login.Dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoard extends StatelessWidget{


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
}

/*
// CREAMOS EL WIDGET COMPLETO Y DEFINIMOS LA CLASE DONDE ESTARAN SUS DATOS
class MiFormulario extends StatefulWidget{
  @override
  _MiFormularioState createState() => _MiFormularioState();
}
// CLASE CON LOS DATOS Y ELEMENTOS DEL WIDGET
class _MiFormularioState extends State<MiFormulario>{
  final miControlador = TextEditingController();
  double resultado;
  @override
  void dispose() {
    // TODO: implement dispose
    miControlador.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conversor de Temperatura"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: miControlador,
          keyboardType: TextInputType.number,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          resultado = double.parse(miControlador.text) * 1.8 + 32;
          return showDialog(
            context: context,
            builder: (context){
              return AlertDialog(content: Text("La temperatura en Fahrenheit es : $resultado"));
            },
          );
        },
        tooltip: "Presiona para convertir",
        child: Icon(Icons.text_fields),
      ),
    );
  }
}*/