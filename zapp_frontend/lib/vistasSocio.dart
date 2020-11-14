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

PersistentTabController _controller = PersistentTabController(initialIndex: 0);

//Screens for each nav items.
// ignore: non_constant_identifier_names
List<Widget> _NavScreens() {
  return [
    Deberes(),
    Archivador(),
    Perfil(),
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

class VistasSocio extends StatefulWidget {
  VistasSocio({Key key}) : super(key: key);

  @override
  _VistasSocio createState() => _VistasSocio();
}

class _VistasSocio extends State<VistasSocio> {
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
