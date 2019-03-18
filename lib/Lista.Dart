import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Lista extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    //return ListaState();
    return ListaState();
  }
}
class ListaState extends State<Lista>
{
  List<String> lista = new List<String>();
  List data;
 final bottomMenu = Container(

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
           onPressed: null,
         ),
         IconButton(
           icon: Icon(
             Icons.blur_on,
             color: Colors.white,
           ),
           onPressed: null,
         ),
         IconButton(
           icon: Icon(
             Icons.hotel,
             color: Colors.white,
           ),
           onPressed: null,
         ),
       ],
     ),
   ),
 );

 @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Ejemplo de lista"),
        ),
        bottomNavigationBar: bottomMenu,
        body: ListView.builder(
            itemCount: lista.length,
            itemBuilder: (BuildContext context, int index)
            {
              return Card(
                child: Container(
                  padding: EdgeInsets.all(35.0),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: new NetworkImage('http://i.pravatar.cc/300'),
                      ),
                      Text('Nombre de la pelicula ${index}'),
                    ],
                  ),
                ),
              );
            }
        ),
      ),
    );
  }

  Future<String> getData() async
  {
   String username = "intertecs";
   String password = "1nt3rt3c5";
   String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
   http.Response response = await http.get(
     Uri.encodeFull("http://ws.itcelaya.edu.mx:8080/intertecs/apirest/institucion/listado"),
     headers: {"authorization" : basicAuth}
   );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getData();
      for(int i=0; i<10; i++)
      {
        lista.add("Titulo de la pelicula ${i}");
      }
    });
  }


}
