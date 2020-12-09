import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

List<String> mainDataList = new List<String>();

class ListSearch extends StatefulWidget {
  ListSearch({this.usuarios});
  final List<String> usuarios;

  ListSearchState createState() => ListSearchState(usuarios: usuarios);
}

/*void setUsers(List<String> usuarios) {
  for (int i = 0; i < usuarios.length; i++) {
    print(usuarios.elementAt(i));
    mainDataList.add(usuarios.elementAt(i));
  }
}*/

class ListSearchState extends State<ListSearch> {
  ListSearchState({this.usuarios});
  final List<String> usuarios;

  void setUsers() {
    for (int i = 0; i < usuarios.length; i++) {
      print(usuarios[i]);
      mainDataList.add(usuarios[i]);
    }
  }

  TextEditingController _textController = TextEditingController();

  List<String> newDataList = new List<String>();

  onItemChanged(String value) {
    setState(() {
      newDataList = mainDataList
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // setUsers();
    List<String> newDataList = List.from(widget.usuarios);

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

class Usuarios extends StatelessWidget {
  Usuarios({this.usuariosList});
  final List<String> usuariosList;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(title: Text('Búsqueda usuarios')),
            body: Center(child: ListSearch(usuarios: usuariosList))));
  }
}
