import 'dart:async';
import 'tarea.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'crearGrupo.dart';

List<String> users = new List<String>();

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

Future getUsuarios(List<String> usuarios, String nombreGrupo) async {
  String url = 'http://zapp.pythonanywhere.com/grupos/';
  url = url + nombreGrupo;
  print(url);
  http.Response response = await http.get(
    url,
    headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
    },
  );

  final jsonResponse = jsonDecode(response.body);
  print(jsonResponse);
  users.clear();
  for (int i = 0; i < jsonResponse['usuarios'].length; i++) {
    print(usuarios[jsonResponse['usuarios'][i]]);
    users.add(usuarios[jsonResponse['usuarios'][i]]);
  }
  /*for (int i = 0; i < grupos.length; i++) {
    print(grupos[i]);
    //print(codigos[i]);
  }*/
}

class Grupo extends StatefulWidget {
  Grupo({this.usuarios, this.codigos, this.nombreGrupo});
  final List<String> usuarios;
  final List<String> codigos;
  final String nombreGrupo;
  @override
  _Grupos createState() => _Grupos();
}

class _Grupos extends State<Grupo> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 30.0);

  // var oneSec = const Duration(seconds: 1);
  //_Deberes.periodic(oneSec, getTareas(widget.codigo));

  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 500), () {
      setState(() {
        getUsuarios(widget.usuarios, widget.nombreGrupo);
      });
    });
    //var oneSec = const Duration(seconds: 1);
    /*Timer.periodic(Duration(seconds: 10), (timer) {
      setState(() {
        getTareas(widget.codigo);
      });
    });*/

    final crearGrupo = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          print(widget.codigos);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CrearGrupo(
                      usuarios: widget.usuarios, codigos: widget.codigos)));
        },
        child: Text("Crear nuevo grupo",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

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
                          Text('Grupos',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 50.0,
                                  fontWeight: FontWeight.bold)),
                          Icon(Icons.group, size: 50.0),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.02,
                        //child: const ColoredBox(color: Colors.amber),
                      ),
                      // crearGrupo,
                      Expanded(
                          child: ListView(children: [
                        for (int i = 0; i < users.length; i++)
                          TareaWidget(
                            iconData: Icons.person,
                            title: users[i],
                            onPressed: () async {},
                          )
                      ]))
                    ]))));
  }
}

/*
import 'package:flutter/material.dart';
import 'crearGrupo.dart';
import 'altaFacilitador.dart';
import 'altaSocio.dart';

// ignore: must_be_immutable
class Grupos extends StatefulWidget {
  Grupos({
    this.usuarios,
    this.codigos,
  });
  final List<String> usuarios;
  final List<String> codigos;

  @override
  _Grupos createState() => _Grupos();
}

class _Grupos extends State<Grupos> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final crearTarea = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          print(widget.codigos);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CrearGrupo(
                      usuarios: widget.usuarios, codigos: widget.codigos)));
        },
        child: Text("Crear nuevo grupo",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                crearTarea,
                SizedBox(height: 45.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/
