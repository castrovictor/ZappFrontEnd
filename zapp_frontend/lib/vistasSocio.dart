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

/// This is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Deberes';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: VistasSocio(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class VistasSocio extends StatefulWidget {
  VistasSocio({Key key}) : super(key: key);

  @override
  _VistasSocio createState() => _VistasSocio();
}

/// This is the private State class that goes with MyStatefulWidget.
class _VistasSocio extends State<VistasSocio> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Deberes',
      style: optionStyle,
    ),
    Text(
      'Archivador',
      style: optionStyle,
    ),
    Text(
      'Perfil',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vistas Socio'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.pending_actions_rounded),
            label: 'Deberes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.topic_rounded),
            label: 'Archivador',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sentiment_satisfied_alt_rounded),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
