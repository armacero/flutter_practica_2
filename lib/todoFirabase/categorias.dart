import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_practica/DashBoard.Dart';
import 'package:flutter_practica/modelos/Genero.dart';
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

    return new Scaffold(
        appBar: AppBar(
          title: Text("Categorias Favoritas"),
          backgroundColor: Colors.teal,
        ),
        bottomNavigationBar: BottomAppBar(
            color: Colors.deepOrange,
            child: Row(
              children: <Widget>[

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
                      //sharedPreferences.commit();
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

        body: Column(children: <Widget>[new ListView.builder(
          itemCount: listag.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
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
        ),],)

    );
  }

  Future<String> getData() async {


    http.Response response = await http.get(
        Uri.encodeFull(
            sharedPreferences.getString("ip")+":5000/ws/listar_generos"),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var rest = data["generos"] as List;
      print(rest);
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
                "http://iid.googleapis.com/iid/v1/eRBYPldDhrE:APA91bHwANGzGmdDPNc8Ho8OwTRKPe6yHyFdmxItSYpEcqcPgjKQXjBctFfOYZ2ERLfmuUHcvFV2QcSuP-vDtrT4jjgtTNBCj-ZoAzDeDl8PgnZE5aCMUVAK0oYVCY7yoDubquZcwy2U/rel/topics/"+topico),
        headers: {"authorization": "key=AIzaSyCc3gP_zrU9l3UlHldBwGKcsZxJVAcnCMc",'Content-Type': 'application/json'});
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
            "http://iid.googleapis.com/iid/v1/eRBYPldDhrE:APA91bHwANGzGmdDPNc8Ho8OwTRKPe6yHyFdmxItSYpEcqcPgjKQXjBctFfOYZ2ERLfmuUHcvFV2QcSuP-vDtrT4jjgtTNBCj-ZoAzDeDl8PgnZE5aCMUVAK0oYVCY7yoDubquZcwy2U/rel/topics/"+topico),
        headers: {"authorization": "key=AIzaSyCc3gP_zrU9l3UlHldBwGKcsZxJVAcnCMc",'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      print("Correcto");
    }
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
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
