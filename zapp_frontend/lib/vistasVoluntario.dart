import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'perfilFacilitador.dart';
import 'administrar.dart';
import 'biblioteca.dart';
import 'crearTarea.dart';
import 'usuarios.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

PersistentTabController _controller = PersistentTabController(initialIndex: 0);
String titulo;
String nombre;
String fechaCumple;
List<String> usuarios = new List<String>();
List<String> codigos = new List<String>();

Future getJson(codigo) async {
  String url = 'http://zapp.pythonanywhere.com/facilitador/';
  url = url + codigo;
  print(url);
  http.Response response = await http.get(
    url,
    headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
    },
  );

  final jsonResponse = jsonDecode(response.body);
  nombre = jsonResponse['User']['username'];
  fechaCumple = jsonResponse['User']['fechaNacimiento'];
  if (fechaCumple == null) {
    fechaCumple = "Cumpleaños";
  }
}

Future getUsuarios() async {
  String url = 'http://zapp.pythonanywhere.com/socio/0';
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
  for (int i = 0; i < jsonResponse['User'].length; i++) {
    usuarios.add(jsonResponse['User'][i]['username']);
    codigos.add(jsonResponse['User'][i]['id'].toString());
  }
  for (int i = 0; i < usuarios.length; i++) {
    print(usuarios[i]);
    //print(codigos[i]);
  }
}

//Screens for each nav items.
// ignore: non_constant_identifier_names
List<Widget> _NavScreens() {
  getUsuarios();
  return [
    Administrar(usuarios: usuarios, codigos: codigos),
    Biblioteca(),
    Usuarios(usuariosList: usuarios),
    PerfilFacilitador(),
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(Icons.settings_rounded),
      title: ("Administrar"),
      activeColor: Colors.blue,
      inactiveColor: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.account_balance_rounded),
      title: ("Biblioteca"),
      activeColor: Colors.blue,
      inactiveColor: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.group),
      title: ("Usuarios"),
      activeColor: Colors.blue,
      inactiveColor: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.sentiment_satisfied_alt_rounded),
      title: ("Perfil"),
      activeColor: Colors.blue,
      inactiveColor: Colors.grey,
    ),
  ];
}

class VistasVoluntario extends StatefulWidget {
  VistasVoluntario();

  @override
  _VistasVoluntario createState() => _VistasVoluntario();
}

class _VistasVoluntario extends State<VistasVoluntario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Socio'),
        ),
        body: Center(
          child: PersistentTabView(
            controller: _controller,
            screens: _NavScreens(),
            items: _navBarsItems(),
            confineInSafeArea: true,
            backgroundColor: Colors.white,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            hideNavigationBarWhenKeyboardShows: true,
            decoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            popAllScreensOnTapOfSelectedTab: true,
            navBarStyle: NavBarStyle.style3,
          ),
        ));
  }
}
