import 'dart:async';
import 'tarea.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

List<String> tareas = new List<String>();
List<String> codigos = new List<String>();

class TareaWidget extends StatelessWidget {
  TareaWidget({this.iconData, this.title, this.onPressed});

  /// icon data
  final IconData iconData;

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
                    height: MediaQuery.of(context).size.height * 0.075,
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
                    height: MediaQuery.of(context).size.height * 0.075,
                    child: ColoredBox(
                        color: Colors.lightBlue[50],
                        child: Center(child: Icon(iconData, size: 40.0)))),
              ])),
    );
  }
}

Future getTareas(codigo) async {
  String url = 'http://zapp.pythonanywhere.com/actividad/noentregadas/';
  url = url + codigo;
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
  if (jsonResponse.containsKey('Actividad')) {
    for (int i = 0; i < jsonResponse['Actividad'].length; i++) {
      tareas.add(jsonResponse['Actividad'][i]['nombre']);
      codigos.add(jsonResponse['Actividad'][i]['id'].toString());
      //print(jsonResponse['Actividad'][i]['id'].toString());
    }
  }
}

class Deberes extends StatefulWidget {
  Deberes({this.codigo});
  final String codigo;
  @override
  _Deberes createState() => _Deberes();
}

class _Deberes extends State<Deberes> {
  _Deberes();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 30.0);

  // var oneSec = const Duration(seconds: 1);
  //_Deberes.periodic(oneSec, getTareas(widget.codigo));

  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 500), () {
      setState(() {
        getTareas(widget.codigo);
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
                          Text('Deberes',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 50.0,
                                  fontWeight: FontWeight.bold)),
                          Icon(Icons.pending_actions_rounded, size: 50.0),
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
                            iconData: Icons.pending_actions_rounded,
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
// ignore: must_be_immutable

class Deberes extends StatelessWidget {
  Deberes({this.tareas});
  final List<String> tareas;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 30.0);

  @override
  Widget build(BuildContext context) {
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
                          Text('Deberes',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 50.0,
                                  fontWeight: FontWeight.bold)),
                          Icon(Icons.pending_actions_rounded, size: 50.0),
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
                            iconData: Icons.pending_actions_rounded,
                            title: tareas[i],
                            onPressed: () {
                              /*  Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Tarea(
                                      iconData: Icons.sports_bar_rounded,
                                      title: "Tarea " + i.toString(),
                                      description: "Descripion")));*/
                            },
                          )
                      ]))
                    ]))));
  }
}*/
