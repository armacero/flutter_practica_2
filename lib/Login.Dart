import 'dart:convert';
import 'dart:async';
import 'package:flutter_practica/DashBoard.Dart';
import 'package:flutter/material.dart';
import 'package:flutter_practica/categorias.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {

    return LoginState();
  }
}

class LoginState extends State<Login>
{
  final myUser = TextEditingController();
  final myPass = TextEditingController();
  String user="";
  String pass="";
  String mensaje="Recuedame";
  bool _isChecked=false;
  SharedPreferences sharedPreferences;




  @override
  Widget build(BuildContext context) {





    Future<String> getData() async {
       user = myUser.text;
       pass = myPass.text;
        if(_isChecked)
          {
            sharedPreferences = await SharedPreferences.getInstance();
            setState(() {
              sharedPreferences.setString("username", user);
              sharedPreferences.setString("password", pass);
              sharedPreferences.setString("usuario",user);
              sharedPreferences.commit();
            });

          }

//Uri.https(, unencodedPath)

      http.Response response = await http.get(
          Uri.encodeFull(sharedPreferences.getString("ip")+":5000/ws/login/${user}/${pass}"),
          headers: { "Accept": "application/json"}

      );



      //print(response.body);
      if(response.statusCode==200)
        {
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
      //List data = jsonDecode(response.body);
      //print(data);
      //print(data[0]["email"]);
      //if(data[1][])
    }

    //logo
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor:  Colors.white,
        radius: 100.0,
        child: Image.asset("images/login.png"),
      ),
    );

    //Caja de texto del Email
    final txtEmail = TextFormField(
      autofocus: true,
      keyboardType: TextInputType.emailAddress,
      decoration:  InputDecoration(
        hintText: 'Introduce el Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      controller: myUser,
    );

    final txtPwd = TextFormField(
      autofocus: true,
      //initialValue: 'some password',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Introduce el password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      controller: myPass,
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: getData,
        padding: EdgeInsets.all(12),
        color: Colors.teal,
        child: Text('Entrar', style: TextStyle(color: Colors.white)),
      ),
    );




    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 40.0),
            txtEmail,
            SizedBox(height: 30.0),
            txtPwd,
            SizedBox(height: 30.0),
            loginButton,
            CheckboxListTile(
              title: new Text("Guardar Session"),
              value: _isChecked,
              activeColor: Colors.cyan,
              secondary: const Icon(Icons.save),
              onChanged: (bool value){guardar(value);}

            )

          ],
        ),
      ),

    );

  }
  void guardar(bool value)
  {
    setState(() {
      _isChecked=value;
    });

  }
}