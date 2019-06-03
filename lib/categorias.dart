import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_practica/DashBoard.Dart';
import 'package:flutter_practica/Genero.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_database/firebase_database.dart';

class Categoria extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListState();
  }
}

class ListState extends State<Categoria> {

  var mymap = {};
  var title = '';
  var body = {};
  var mytoken = '';

  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  String token = "";
  List<Genero> listag=[];
  List<String> bol;
  bool x=false;

  SharedPreferences sharedPreferences;

  List<bool> inputs = new List<bool>();

  @override
  Widget build(BuildContext context) {
    var cate = "";
    var valbol = "";
    var cont = 0;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Categorias Favoritas"),
          backgroundColor: Colors.teal,
        ),
        bottomNavigationBar: Container(
          height: 55.0,
          child: BottomAppBar(
            color: Color.fromRGBO(58, 66, 86, 0),
            child: Row(
              children: <Widget>[
                Material(
                  color: Color.fromRGBO(1, 1, 1, 0),
                  elevation: 15,
                  child: InkWell(
                    child: Text(
                      "Guardar",
                      style: TextStyle(color: Color.fromRGBO(1, 1, 1, 0)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () async {
                      cate = "";
                      valbol="";
                      for (int i = 0; i < listag.length; i++) {
                        if (inputs[i] == true) {
                          cate = cate + " " + listag[i].genero;
                          valbol = valbol + "." + i.toString();
                          print(listag[i].genero);
                          insTopic(listag[i].genero);

                        } else {
                          cont++;
                          delTopic(listag[i].genero);
                        }
                      }

                      if (cont == listag.length) {
                        cate = "";
                        valbol="";
                      }
                      sharedPreferences = await SharedPreferences.getInstance();
                      sharedPreferences.setString("categorias", cate);
                      sharedPreferences.setString("catebool", valbol);
                      print("Seleccionado " + valbol);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                              new DashBoard()));

                    },
                    padding: EdgeInsets.all(4),
                    color: Color.fromRGBO(1, 1, 1, 0),
                    child:
                        Text('Guardar', style: TextStyle(color: Colors.white,fontSize: 18)),
                  ),
                ),
                Material(
                  color: Color.fromRGBO(1, 1, 1, 0),
                  elevation: 15,
                  child: InkWell(
                    child: Text("Guardar",
                        style: TextStyle(color: Color.fromRGBO(1, 1, 1, 0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new DashBoard()));
                    },
                    padding: EdgeInsets.all(3),
                    color: Color.fromRGBO(1, 1, 1, 0),
                    child:
                        Text('Omitir', style: TextStyle(color: Colors.white,fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: new ListView.builder(
          itemCount: listag.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              child: new Container(
                padding: new EdgeInsets.all(10.0),
                child: new Column(
                  children: <Widget>[
                    new CheckboxListTile(
                        activeColor: Colors.teal,
                        value: inputs[index],
                        title: new Text(listag[index].genero),
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (bool val) {
                          ItemChange(val, index);
                        }),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<String> getData() async {
    SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();

    http.Response response = await http.get(
        Uri.encodeFull(
            sharedPreferences.getString("ip")+":5000/ws/listar_generos"),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var rest = data["generos"] as List;
      listag = rest.map<Genero>((json) => Genero.fromJSON(json)).toList();
    }
    setState(() {
      bol = sharedPreferences.getString("catebool").split(".");
      for (int i = 0; i < listag.length; i++) {
        x = false;
        for(int j = 1; j < bol.length; j ++){
            if(i.toString()==bol[j]){
              x = true;
            }else{

            }
        }
        inputs.add(x);
      }
    });
  }

  Future<String> insTopic(String topico) async {
    sharedPreferences = await SharedPreferences.getInstance();

    http.Response response = await http.post(
        Uri.encodeFull(
              "http://iid.googleapis.com/iid/v1/cLH8Lttn-VU:APA91bGkBYVlv4Hy6Bh-6ILMOD-G0V6BlPuOMEREAeXpN-fi0PVnhACBNJp78gWbTmtnNY4gRqbhD4i-bVYz5hJtdL7ANfjoY8kZ3ruPgZBfVLxf3MisuyYPCnYAlxD5YmpfSaAG7ewL/rel/topics/"+topico),
        headers: {"authorization": "key=AIzaSyCT3q3rvaA-7hvEn0m0yIWOv3DvoveNDB4",'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      print("Correcto");
    }
    setState(() {

    });
  }

  Future<String> delTopic(String topico) async {
    sharedPreferences = await SharedPreferences.getInstance();

    http.Response response = await http.delete(
        Uri.encodeFull(
            "http://iid.googleapis.com/iid/v1/cLH8Lttn-VU:APA91bGkBYVlv4Hy6Bh-6ILMOD-G0V6BlPuOMEREAeXpN-fi0PVnhACBNJp78gWbTmtnNY4gRqbhD4i-bVYz5hJtdL7ANfjoY8kZ3ruPgZBfVLxf3MisuyYPCnYAlxD5YmpfSaAG7ewL/rel/topics/"+topico),
        headers: {"authorization": "key=AIzaSyCT3q3rvaA-7hvEn0m0yIWOv3DvoveNDB4",'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      print("Correcto");
    }
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    var android = new AndroidInitializationSettings("mipmap/ic_launcher");
    var ios = new IOSInitializationSettings();
    var plataform = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(plataform);

    firebaseMessaging.configure(onLaunch: (Map<String, dynamic> msg) {
      print("onLaunch called ${(msg)}");
    }, onResume: (Map<String, dynamic> msg) {
      print("onResume called ${(msg)}");
    }, onMessage: (Map<String, dynamic> msg) {
      print("onMessage called ${(msg)}");
      mymap = msg;
      showNotification(msg);
    });

    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings setting) {
      print("onIosSettingRegistered");
    });
    firebaseMessaging.getToken().then((token) {
      update(token);
    });

    getData();
  }

  showNotification(Map<String, dynamic> msg) async {
    var android = new AndroidNotificationDetails(
        "1", "channelName", "channelDescription");
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);

    //key and value
    msg.forEach((k, v) {
      title = k;
      body = v;
      setState(() {});
    });

    await flutterLocalNotificationsPlugin.show(
        0, "${body.keys}", "${body.values}", platform);
  }

  //fcm-token firebase cloud messagin
  update(String token) {
    print(token);
    DatabaseReference databaseReference = new FirebaseDatabase().reference();
    databaseReference.child('fcm-token/$token').set({"token": token});
    mytoken = token;
    setState(() {});
  }

  void ItemChange(bool val, int index) {
    setState(() {
      inputs[index] = val;
    });
  }
}
