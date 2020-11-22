import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'perfilFacilitador.dart';
import 'administrar.dart';
import 'biblioteca.dart';
import 'crearTarea.dart';
import 'usuarios.dart';

PersistentTabController _controller = PersistentTabController(initialIndex: 0);
String titulo;

//Screens for each nav items.
// ignore: non_constant_identifier_names
List<Widget> _NavScreens() {
  return [
    Administrar(),
    Biblioteca(),
    Usuarios(),
    Perfil(),
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
  VistasVoluntario({Key key}) : super(key: key);

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
