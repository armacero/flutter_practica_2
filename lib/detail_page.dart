import 'package:flutter/material.dart';
import 'package:flutter_practica/character.dart';
import 'package:flutter_practica/pelicula.dart';


class DetailPage extends StatefulWidget {
  final Pelicula character;

  const DetailPage({
    Key key,
    @required this.character,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: "background_${widget.character.nombre}",
          child: Container(
            //color: Color(widget.character.color),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            //backgroundColor: Color(widget.character.color),
            elevation: 0,
            title: Text(widget.character.nombre),

            leading: CloseButton(),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Hero(
                  tag: "image_${widget.character.nombre}",

                  child: Image(
                    image: NetworkImage("http://t0.gstatic.com/images?q=tbn:ANd9GcSvrR2wjVfAucVBIaE048zDXv2G3cHCmxetx27P8HHsI7wr3yoJ"),
                    height: MediaQuery.of(context).size.height / 2,
                  ),
                ),

                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, widget) => Transform.translate(
                    transformHitTests: false,
                    offset: Offset.lerp(
                        Offset(0.0, 200.0), Offset.zero, _controller.value),
                    child: widget,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      widget.character.nombre,

                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}