import 'package:flutter/material.dart';

class Conversor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retrieve Text Input',
      home: MyCustomForm(),
    );
  }
}

// Define un widget de formulario personalizado
class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define la clase State correspondiente. Esta clase contendrá los datos relacionados con
// nuestro formulario.
class _MyCustomFormState extends State<MyCustomForm> {
  // Crea un controlador de texto. Lo usaremos para recuperar el valor actual
  // del TextField!
  final myController = TextEditingController();
  //final Widget floatingActionButton;
  double grados,CF,FC, fire;

  @override
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversor de grados'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: TextField(
          autofocus: true,
          //textAlign: TextAlign.center,
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w300, fontSize: 28),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.fiber_manual_record),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            //fillColor: Colors.indigoAccent,
            hintText: 'Ingrese los grados',

          ),
          controller: myController,
        ),
      ),
      // Aqui van los botones--------------------------------------

        floatingActionButton:Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              heroTag: null,
              child: Icon(Icons.rotate_left,color: Colors.white,),
              onPressed: () {
               grados = double.parse(myController.text);
                // ignore: non_constant_identifier_names
               CF = (grados * (9/5))+32;
                return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('RESULTADO'),
                      //contentTextStyle: TextStyle(fontSize: 28),
                      content: Text("Grados Celsius  --> Fahrenheit: \n"+CF.toString()+" Fahrenheit"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('ACEPTAR'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            FloatingActionButton(
              heroTag: null,
              child: Icon(Icons.rotate_right,color: Colors.white,),
              onPressed: () {
             fire = double.parse(myController.text);
                FC = (fire - 32)*(5/9);
                return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('RESULTADO'),
                      content: Text("Grados Fahrenheit --> Celsius: \n"+FC.toString()+" Celsius"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('ACEPTAR'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        )

    );
  }
}

