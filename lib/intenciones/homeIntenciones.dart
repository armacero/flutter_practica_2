import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeIntenciones extends StatelessWidget {
  TextEditingController numero = TextEditingController();
  TextEditingController smsNumero = TextEditingController();
  TextEditingController smsBody = TextEditingController();

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
              Container(child: llamada(context)),
              Container(child: sms(context)),
              Container(child: llamada(context)),
              Container(child: llamada(context)),
              Container(child: llamada(context)),
              Container(child: llamada(context)),
              Container(child: llamada(context)),
              Container(child: llamada(context)),
            ],
          ),
        ),
      ),

    );

  }
  Widget llamada(BuildContext context) => new Scaffold(

    body: new Center(

      child: Column(
        children: <Widget>[
          new Text("Llamada Telefonica",style: TextStyle(fontSize: 40,fontStyle: FontStyle.italic), maxLines: 10,),
          new TextField(controller: numero,decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(24.0))), style: TextStyle(fontSize: 20),),
          new RaisedButton(onPressed: _openURL, child: new Text("Marcar")),],
          
          ),
    ),
  );
  Widget sms(BuildContext context) => new Scaffold(

    body: new Center(

      child: Column(
        children: <Widget>[
          new Text("Enviar SMS",style: TextStyle(fontSize: 40,fontStyle: FontStyle.italic), maxLines: 10,),
          new Row(children: <Widget>[new Text("Para:"),new TextField(controller: numero,decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(24.0))), style: TextStyle(fontSize: 20),)],),
          new Row(children: <Widget>[new Text("Mensaje:"),new TextField(controller: numero,decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(24.0))), style: TextStyle(fontSize: 20),)],),
          new RaisedButton(onPressed: _enviarSMS, child: new Text("Marcar")),],

      ),
    ),
  );
  _openURL () async
  {
    var num = "tel:"+numero.text;
    if(await canLaunch(num)) {
      launch( num);
    }else
      {
        print("Esto no funca");
      }
  }

  _enviarSMS()async
  {
    var num = "sms:"+numero.text;
    if(await canLaunch(num)) {
      launch(num);
    }else
    {
      print("sms:+39 348 060 888?body=hello%20there");
    }

  }
}

