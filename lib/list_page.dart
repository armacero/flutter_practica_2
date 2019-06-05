import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_practica/modelos/pelicula.dart';
import 'package:flutter_practica/detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}
List <Pelicula> lista;
class _ListPageState extends State<ListPage> {
  PageController _controller;


  _goToDetail(Pelicula character) {

    final page = DetailPage(character: character);
    Navigator.of(context).push(
      PageRouteBuilder<Null>(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return AnimatedBuilder(
                animation: animation,
                builder: (BuildContext context, Widget child) {
                  return Opacity(
                    opacity: animation.value,
                    child: page,
                  );
                });
          },
          transitionDuration: Duration(milliseconds: 400)),
    );
  }

  _pageListener() {
    setState(() {});
  }
  Future<String> getData() async {
    http.Response response = await http.get(
        Uri.encodeFull(
            "http://192.168.100.58:5000/ws/listar_peliculas")
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var rest = data["peliculas"] as List;
      lista = rest.map<Pelicula>((json) => Pelicula.fromJSON(json)).toList();
      print(lista);
    }
    setState(() {});
  }
  @override
  void initState() {
    getData();
    _controller = PageController(viewportFraction: 0.6);
    _controller.addListener(_pageListener);
    super.initState();

  }

  @override
  void dispose() {
    _controller.removeListener(_pageListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Peliculas"),
        backgroundColor: Colors.black54,
      ),
      body: PageView.builder(
          scrollDirection: Axis.vertical,
          controller: _controller,
          itemCount: lista.length,
          itemBuilder: (context, int index) {
            double currentPage = 0;
            try {
              currentPage = _controller.page;
            } catch (_) {}

            final resizeFactor =
            (1 - (((currentPage - index).abs() * 0.3).clamp(0.0, 1.0)));
            final currentCharacter = lista[index];
            return ListItem(
              character: currentCharacter,
              resizeFactor: resizeFactor,
              onTap: () => _goToDetail(currentCharacter),
            );
          }),
    );
  }
}

class ListItem extends StatelessWidget {
  final Pelicula character;
  final double resizeFactor;
  final VoidCallback onTap;

  const ListItem({
    Key key,
    @required this.character,
    @required this.resizeFactor,
    @required this.onTap,
  }) : super(key: key);

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
    return InkWell(
      onTap: onTap,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
            width: width * resizeFactor,
            height: height * resizeFactor,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: height / 4,
                  bottom: 0,
                  child: Hero(
                    tag: "background_${character.nombre}",
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  //Color(character.color),
                                  Colors.black,
                                ],
                                stops: [
                                  0.4,
                                  1.0,
                                ])),
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          margin: EdgeInsets.only(
                            left: 20,
                            bottom: 10,
                          ),
                          child: Text(

                            character.nombre,
                            style: TextStyle(
                              fontSize: 24 * resizeFactor,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Hero(
                    tag: "image_${character.nombre}",
                    child: Image(
                      image: NetworkImage("http://t0.gstatic.com/images?q=tbn:ANd9GcSvrR2wjVfAucVBIaE048zDXv2G3cHCmxetx27P8HHsI7wr3yoJ"),
                      width: width / 2,
                      height: height,

                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }






}


