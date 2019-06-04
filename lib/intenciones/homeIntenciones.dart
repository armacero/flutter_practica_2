import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';

class HomeIntenciones extends StatefulWidget {
  HomePage createState()=> HomePage();
}
class HomePage extends State<HomeIntenciones>{

  //llamada
  static TextEditingController numero = TextEditingController();
  //SMS
  static TextEditingController smsNumero = TextEditingController();
  static TextEditingController smsBody = TextEditingController();
  //Email
  static TextEditingController correo = TextEditingController();
  static TextEditingController subject = TextEditingController();
  static TextEditingController emailBody = TextEditingController();
  //camera y galeria
  File image;
  File image2;
  //web
  static TextEditingController url = TextEditingController();







  @override
  Widget build(BuildContext context) {
    return new Scaffold(


     body:  DefaultTabController(
        length: 8,
        child: Scaffold(

          appBar: AppBar(
            backgroundColor: Colors.teal,
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.phone)),
                Tab(icon: Icon(Icons.sms)),
                Tab(icon: Icon(Icons.email)),
                Tab(icon: Icon(Icons.camera_alt)),
                Tab(icon: Icon(Icons.alternate_email)),
                Tab(icon: Icon(Icons.pageview)),
                Tab(icon: Icon(Icons.image)),
                Tab(icon: Icon(Icons.contact_mail)),
              ],
            ),
            title: Text('Intenciones'),
          ),
          body: TabBarView(

            children: [
              new Container(child: llamada),
              new Container(child: sms(context)),
              Container(child: email(context)),
              Container(child: camara(context)),
              Container(child: web),
              Container(child: llamada),
              Container(child: galeria(context)),
              Container(child: llamada),
            ],
          ),
        ),
      ),

    );

  }
  final llamada = new Scaffold(

    body: new Center(

      child: Column(

        children: <Widget>[
          new Text("Llamada Telefonica",style: TextStyle(fontSize: 40,fontStyle: FontStyle.italic), maxLines: 10,),
          new TextField(controller: numero,decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(24.0))), style: TextStyle(fontSize: 20),),
          new RaisedButton(onPressed: _openURL, child: new Text("Marcar")),],
          
          ),
    ),
  );
  final web = new Scaffold(

    body: new Center(

      child: Column(

        children: <Widget>[
          new Text("Abrir Pagina WEB",style: TextStyle(fontSize: 40,fontStyle: FontStyle.italic), maxLines: 10,),
          new TextField(controller: url,decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(24.0))), style: TextStyle(fontSize: 20),),
          new RaisedButton(onPressed: _openURL2, child: new Text("Navegar")),],

      ),
    ),
  );
  Widget sms(BuildContext context) => new Scaffold(

    body: new Center(

      child: Column(
        children: <Widget>[
          new Text("Enviar SMS",style: TextStyle(fontSize: 40,fontStyle: FontStyle.italic)),
          ListTile(leading: Text("Para:",style: TextStyle(fontSize: 20)),title: new TextField(controller: smsNumero,decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(24.0))), style: TextStyle(fontSize: 20),),),
          ListTile(leading: Text("Mensaje:",style: TextStyle(fontSize: 20)),title: new TextField(controller: smsBody,decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(24.0))), style: TextStyle(fontSize: 20),),),
          //new Row(children: <Widget>[Column(children: <Widget>[new Text("Para:")],) ,Column(children: <Widget>[new TextField(controller: smsNumero,decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(24.0))), style: TextStyle(fontSize: 20),)])],),
          //new Row(children: <Widget>[new Text("Mensaje:"),new TextField(controller: smsBody,decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(24.0))), style: TextStyle(fontSize: 20),)],),
          new RaisedButton(onPressed: _enviarSMS, child: new Text("Enviar"),colorBrightness: Brightness.light,),],

      ),
    ),
  );
  Widget email(BuildContext context) => new Scaffold(

    body: new Center(

      child: Column(
        children: <Widget>[
          new Text("Enviar EMAIL",style: TextStyle(fontSize: 40,fontStyle: FontStyle.italic)),
          ListTile(leading: Text("Para:",style: TextStyle(fontSize: 20)),title: new TextField(controller: correo,decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(24.0))), style: TextStyle(fontSize: 20),),),
          ListTile(leading: Text("Asunto:",style: TextStyle(fontSize: 20)),title: new TextField(controller: subject,decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(24.0))), style: TextStyle(fontSize: 20),),),
          ListTile(leading: Text("Mensaje:",style: TextStyle(fontSize: 20)),title: new TextField(controller: emailBody,decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(24.0))), style: TextStyle(fontSize: 20),),),

          new RaisedButton(onPressed: _enviarEmail, child: new Text("Enviar"),colorBrightness: Brightness.light,),],

      ),
    ),
  );
  Widget camara(BuildContext context) {
    return new Scaffold(

        body: new Container(
          child: new Center(
            child: image == null
                ? new Text('No hay imagen',style: TextStyle(fontSize: 40),)
                : new Image.file(image),
          ),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: picker,
          child: new Icon(Icons.camera_alt),
        ),

    );
  }
  Widget galeria(BuildContext context) {
    return new Scaffold(

      body: new Container(
        child: new Center(
          child: image2 == null
              ? new Text('No hay imagen',style: TextStyle(fontSize: 40),)
              : new Image.file(image2),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: picker2,
        child: new Icon(Icons.image),
      ),

    );
  }



  static _openURL ()
  {
    var num = "tel:"+numero.text;
      launch( num);
  }

  _enviarSMS()
  {
    var num = "sms:"+smsNumero.text+"?body="+smsBody.text;
      launch(num);
  }

  _enviarEmail()
  {
    var num = "mailto:"+correo.text+"?subject="+subject.text+"&body="+emailBody.text;
    launch(num);
  }
  picker() async {
    print('Picker is called');
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
// File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      image = img;
      setState(() {});
    }
  }
  picker2() async {
    print('Picker is called');
    //File img = await ImagePicker.pickImage(source: ImageSource.camera);
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      image2 = img;
      setState(() {});
    }
  }
  static _openURL2 ()
  {
    var num = "https://"+url.text;
    launch( num);
  }
}

