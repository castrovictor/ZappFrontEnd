import 'dart:async';
import 'tareaFacilitador.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

List<String> tareas = new List<String>();
List<String> usuarios = new List<String>();
List<String> codigos = new List<String>();

class TareaWidget extends StatelessWidget {
  TareaWidget({this.usuario, this.title, this.onPressed});

  /// icon data
  final String usuario;

  /// Title to show
  final String title;

  /// Airport to show
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: ColoredBox(
                        color: Colors.lightBlue[50],
                        child: Center(
                          child: Text(title,
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)),
                        ))),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: ColoredBox(
                        color: Colors.lightBlue[50],
                        child: Center(
                          child: Text(usuario,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 20.0,
                              )),
                          //fontWeight: FontWeight.bold)),
                        ))),
              ])),
    );
  }
}

Future getTareas(
    List<String> usuariosList, List<String> codigosUsuarios) async {
  String url = 'http://zapp.pythonanywhere.com/actividad/0';
  //print(url);
  http.Response response = await http.get(
    url,
    headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
    },
  );

  final jsonResponse = jsonDecode(response.body);
  tareas.clear();
  codigos.clear();
  String codAux;
  if (jsonResponse.containsKey('Actividad')) {
    for (int i = 0; i < jsonResponse['Actividad'].length; i++) {
      tareas.add(jsonResponse['Actividad'][i]['nombre']);
      codigos.add(jsonResponse['Actividad'][i]['id'].toString());
      codAux = jsonResponse['Actividad'][i]['idUsuario'].toString();
      usuarios.add(usuariosList[codigosUsuarios.indexOf(codAux)]);
      //usuarios.add(jsonResponse['Actividad'][i]['idUsuario'].toString());
    }
  }
}

// ignore: must_be_immutable
class Biblioteca extends StatefulWidget {
  Biblioteca({this.usuariosList, this.codigosUsuarios});
  List<String> usuariosList;
  List<String> codigosUsuarios;

  @override
  _Deberes createState() => _Deberes();
}

class _Deberes extends State<Biblioteca> {
  _Deberes();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 30.0);

  // var oneSec = const Duration(seconds: 1);
  //_Deberes.periodic(oneSec, getTareas(widget.codigo));

  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 500), () {
      setState(() {
        getTareas(widget.usuariosList, widget.codigosUsuarios);
      });
    });
    //var oneSec = const Duration(seconds: 1);
    /*Timer.periodic(Duration(seconds: 10), (timer) {
      setState(() {
        getTareas(widget.codigo);
      });
    });*/
    return Scaffold(
        /* appBar: AppBar(
          title: Text('Sub Page'),
          backgroundColor: Colors.redAccent,
        ),*/
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Biblioteca',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 50.0,
                                  fontWeight: FontWeight.bold)),
                          Icon(Icons.account_balance_rounded, size: 50.0),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.02,
                        //child: const ColoredBox(color: Colors.amber),
                      ),
                      Expanded(
                          child: ListView(children: [
                        for (int i = 0; i < tareas.length; i++)
                          TareaWidget(
                            usuario: usuarios[i],
                            title: tareas[i],
                            onPressed: () async {
                              String url =
                                  'http://zapp.pythonanywhere.com/actividad/';
                              url = url + codigos[i];
                              //print(url);
                              http.Response response = await http.get(
                                url,
                                headers: {
                                  HttpHeaders.acceptHeader: 'application/json',
                                  HttpHeaders.contentTypeHeader:
                                      'application/json',
                                },
                              );

                              final jsonResponse = jsonDecode(response.body);
                              print(jsonResponse);

                              String nombre =
                                  jsonResponse['Actividad']['nombre'];
                              String descripcion =
                                  jsonResponse['Actividad']['descripcion'];
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Tarea(
                                      iconData: Icons.pending_actions_rounded,
                                      title: nombre,
                                      description: descripcion)));
                            },
                          )
                      ]))
                    ]))));
  }
}

/*
class ListSearch extends StatefulWidget {
  ListSearchState createState() => ListSearchState();
}

class ListSearchState extends State<ListSearch> {
  TextEditingController _textController = TextEditingController();
  // String lista
  static List<String> mainDataList = [
    "Tarea1",
    "Tarea2",
    "Tarea3",
    "Tarea",
    "Tarea5",
    "Tarea6",
  ];

  // Copy Main List into New List.
  List<String> newDataList = List.from(mainDataList);

  onItemChanged(String value) {
    setState(() {
      newDataList = mainDataList
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Búsqueda...',
              ),
              onChanged: onItemChanged,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(12.0),
              children: newDataList.map((data) {
                return ListTile(
                  title: Text(data),
                  onTap: () => print(data),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}

class Biblioteca extends StatelessWidget {
  Biblioteca();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String nombre;
  String descripcion;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final crear = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();

            //const url = 'https://pythoneverywhere/alta_socio';
            //await http.post(url,
            //    body: jsonEncode(<String, String>{
            //      'nombre': model.nombre,
            //    }));
            print(nombre);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyApp()));
          }
        },
        child: Text("Crear",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return MaterialApp(
        home: Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              title: Text('Búsqueda tareas'),
            ),
            body: Center(
                child: new SingleChildScrollView(
                    child: new Column(children: [
              Text(
                'Biblioteca',
                style: TextStyle(
                  fontFamily: 'SourceSansPro',
                  fontSize: 40,
                  letterSpacing: 2.5,
                ),
              ),
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/biblio.jpg'),
              ),

              //  ListSearch(),
            ])))
            //backgroundColor: Colors.blue[300],
            ));
  }
}

  body: Center(
              child: Column(
              children: <Widget>[
                ListSearch(),
                  Form(
                    key: _formKey,

                    child: new SingleChildScrollView(

                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            Text(
                              'Biblioteca',
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 40,
                                letterSpacing: 2.5,
                              ),
                            ),
                            CircleAvatar(
                              radius: 80,
                              backgroundImage: AssetImage('assets/biblio.jpg'),
                            ),


                          ]),
                        )),
              ]),
            )
 */
