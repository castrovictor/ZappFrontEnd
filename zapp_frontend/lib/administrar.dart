import 'package:flutter/material.dart';
import 'crearTarea.dart';
import 'altaFacilitador.dart';
import 'altaSocio.dart';
import 'grupos.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

List<String> grupos;

// ignore: must_be_immutable
class Administrar extends StatelessWidget {
  Administrar({this.usuarios, this.codigos});
  final List<String> codigos;
  final List<String> usuarios;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  Future getGrupos() async {
    String url = 'http://zapp.pythonanywhere.com/grupos/';
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
    print(usuarios.length);
    grupos.clear();
    for (int i = 0; i < jsonResponse['grupos'].length; i++) {
      grupos.add(jsonResponse['grupos'][i]);
    }
    for (int i = 0; i < grupos.length; i++) {
      print(grupos[i]);
      //print(codigos[i]);
    }
  }

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
          print(codigos.length);
          getGrupos();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CrearTarea(usuarios: usuarios, codigos: codigos)));
        },
        child: Text("Crear Tarea",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final anadirPictograma = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Grupos(
                      usuarios: usuarios, codigos: codigos, grupos: grupos)));
        },
        child: Text("Grupos",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final altaSocio = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AltaSocio()));
        },
        child: Text("Dar alta a un Socio",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final altaVoluntario = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AltaFacilitador()));
        },
        child: Text("Dar alta a un Facilitador",
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
                altaSocio,
                SizedBox(height: 45.0),
                altaVoluntario,
                SizedBox(height: 45.0),
                anadirPictograma,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
