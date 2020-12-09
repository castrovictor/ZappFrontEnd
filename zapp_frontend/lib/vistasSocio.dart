/// Flutter code sample for BottomNavigationBar

// This example shows a [BottomNavigationBar] as it is used within a [Scaffold]
// widget. The [BottomNavigationBar] has three [BottomNavigationBarItem]
// widgets and the [currentIndex] is set to index 0. The selected item is
// amber. The `_onItemTapped` function changes the selected item's index
// and displays a corresponding message in the center of the [Scaffold].
//
// ![A scaffold with a bottom navigation bar containing three bottom navigation
// bar items. The first one is selected.](https://flutter.github.io/assets-for-api-docs/assets/material/bottom_navigation_bar.png)

import 'package:flutter/material.dart';
import 'deberes.dart';
import 'archivador.dart';
import 'perfil.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

PersistentTabController _controller = PersistentTabController(initialIndex: 0);

String fechaCumple;
String nombre;
List<String> nombreActividades = new List<String>();
List<String> descripcionActividades = new List<String>();
List<String> nombreActividadesHechas = new List<String>();
List<String> descripcionActividadesHechas = new List<String>();

Future getJson(codigo) async {
  String url = 'http://zapp.pythonanywhere.com/socio/';
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
  if (nombre == null) {
    nombre = "Nombre";
  }
  if (fechaCumple == null) {
    fechaCumple = "Cumpleaños";
  }
}

Future getTareas(codigo) async {
  String url = 'http://zapp.pythonanywhere.com/actividad/noentregadas/';
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
  print(jsonResponse);
  if (jsonResponse.containsKey('Actividad')) {
    for (int i = 0; i < jsonResponse['Actividad'].length; i++) {
      nombreActividades.add(jsonResponse['Actividad'][i]['nombre']);
      descripcionActividades.add(jsonResponse['Actividad'][i]['descripcion']);
    }
  }
}

Future getTareasHechas(codigo) async {
  String url = 'http://zapp.pythonanywhere.com/actividad/revisadas/';
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
  print(jsonResponse);
  if (jsonResponse.containsKey('Actividad')) {
    for (int i = 0; i < jsonResponse['Actividad'].length; i++) {
      nombreActividadesHechas.add(jsonResponse['Actividad'][i]['nombre']);
      descripcionActividadesHechas
          .add(jsonResponse['Actividad'][i]['descripcion']);
    }
  }
}

//Screens for each nav items.
// ignore: non_constant_identifier_names
List<Widget> _NavScreens(String codigo) {
  getJson(codigo);
  getTareas(codigo);
  getTareasHechas(codigo);
  return [
    Deberes(tareas: nombreActividades),
    Archivador(tareas: nombreActividadesHechas),
    Perfil(userID: codigo, nombre: nombre, fechaNacimiento: fechaCumple),
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(Icons.pending_actions_rounded),
      title: ("Deberes"),
      activeColor: Colors.blue,
      inactiveColor: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.topic_rounded),
      title: ("Archivador"),
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

// ignore: must_be_immutable
class VistasSocio extends StatefulWidget {
  final String userID; // receives the value

  VistasSocio({Key key, this.userID}) : super(key: key);

  @override
  _VistasSocio createState() => _VistasSocio();
}

class _VistasSocio extends State<VistasSocio> {
  /*_VistasSocio(this.codigo);
  String codigo;*/

  @override
  Widget build(BuildContext context) {
    print(widget.userID);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Socio'),
        ),
        body: Center(
          child: PersistentTabView(
            controller: _controller,
            screens: _NavScreens(widget.userID),
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
