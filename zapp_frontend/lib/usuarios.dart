import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


class ListSearch extends StatefulWidget {
  ListSearchState createState() => ListSearchState();
}


class ListSearchState extends State<ListSearch> {

  TextEditingController _textController = TextEditingController();
  // String lista
  static List<String> mainDataList = [
          "Apple",
          "Apricot",
          "Banana",
          "Blackberry",
          "Coconut",
          "Date",
          "Fig",
          "Gooseberry",
          "Grapes",
          "Lemon",
          "Litchi",
          "Mango",
          "Orange",
          "Papaya",
          "Peach",
          "Pineapple",
          "Pomegranate",
          "Starfruit"
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
                  onTap: () => print(data),);
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}

class Usuarios extends StatelessWidget {
  Usuarios();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
                title: Text('Búsqueda usuarios')
            ),
            body: Center(
                child: ListSearch()
            )
        )
    );
  }

}

