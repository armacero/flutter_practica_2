import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;


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
  TextEditingController url = TextEditingController();
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
  var urlString = "https://google.com";
  //Video
  VideoPlayerController playerController;
  VoidCallback listener;
  //PDF
  String _version = 'Unknown';
  String assetPDFPath = "";
  String urlPDFPath = "";







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
              Container(child: llamada),
              Container(child: sms(context)),
              Container(child: email(context)),
              Container(child: camara(context)),
              Container(child: web(context)),
              Container(child: video(context)),
              Container(child: galeria(context)),
              Container(child: pdf(context)),
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
  Widget web(BuildContext context) =>  Scaffold(

    body: new Center(

      child: Column(

        children: <Widget>[
          new Text("Abrir Pagina WEB",style: TextStyle(fontSize: 40,fontStyle: FontStyle.italic), maxLines: 10,),
          new TextField(controller: url,decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(24.0))), style: TextStyle(fontSize: 20),),
          new RaisedButton(onPressed: _openURL2, child: new Text("Navegar")),],

      ),
    ),
    );
  Widget pdf(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter PDF Tutorial"),
        ),
        body: Center(
          child: Builder(
            builder: (context) =>
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.amber,
                      child: Text("Open from URL"),
                      onPressed: () {
                        if (urlPDFPath != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PdfViewPage(path: assetPDFPath)));
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      color: Colors.cyan,
                      child: Text("Open from Asset"),
                      onPressed: () {
                        if (assetPDFPath != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PdfViewPage(path: assetPDFPath)));
                        }
                      },
                    )
                  ],
                ),
          ),
        ),
      ),
    );
  }

  Widget video(BuildContext context) =>  Scaffold(

    body: Center(
        child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              child: (playerController != null
                  ? VideoPlayer(
                playerController,
              )
                  : Container()),
            ))),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        createVideo();
        playerController.play();
      },
      child: Icon(Icons.play_arrow),
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
  _openURL2 ()
  {
    var num = "https://"+url.text;
    launch( num,forceSafariVC: true, forceWebView: true);
  }

  _prueba()
  {
    var num = "https://play.google.com/store/apps/open?id=tv.twitch.android.app";
    launch( num);
  }


  @override
  void initState() {
    super.initState();
    listener = () {
      setState(() {});
    };
    getFileFromAsset("assets/mypdf.pdf").then((f) {
      setState(() {
        assetPDFPath = f.path;
        print(assetPDFPath);
      });
    });

    getFileFromUrl("http://www.pdf995.com/samples/pdf.pdf").then((f) {
      setState(() {
        urlPDFPath = f.path;
        print(urlPDFPath);
      });
    });

  }

  void createVideo() {
    if (playerController == null) {
      playerController = VideoPlayerController.asset(
          "videos/video.mp4")
        ..addListener(listener)
        ..setVolume(1.0)
        ..initialize()
        ..play();
    } else {
      if (playerController.value.isPlaying) {
        playerController.pause();
      } else {
        playerController.initialize();
        playerController.play();
      }
    }
  }



  Future<File> getFileFromAsset(String asset) async {
    try {
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/mypdf.pdf");

      File assetFile = await file.writeAsBytes(bytes);
      return assetFile;
    } catch (e) {
      throw Exception("Error opening asset file");
    }
  }

  Future<File> getFileFromUrl(String url) async {
    try {
      var data = await http.get(url);
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/mypdfonline.pdf");

      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }



}

class PdfViewPage extends StatefulWidget {
  final String path;

  const PdfViewPage({Key key, this.path}) : super(key: key);
  @override
  _PdfViewPageState createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController _pdfViewController;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            autoSpacing: true,
            enableSwipe: true,
            pageSnap: true,
            swipeHorizontal: true,
            nightMode: false,
            onError: (e) {
              print(e);
            },
            onRender: (_pages) {
              setState(() {
                _totalPages = _pages;
                pdfReady = true;
              });
            },
            onViewCreated: (PDFViewController vc) {
              _pdfViewController = vc;
            },
            onPageChanged: (int page, int total) {
              setState(() {});
            },
            onPageError: (page, e) {},
          ),
          !pdfReady
              ? Center(
            child: CircularProgressIndicator(),
          )
              : Offstage()
        ],
      ),

    );
  }
}
