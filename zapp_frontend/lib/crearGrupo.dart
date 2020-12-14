import 'package:flutter/material.dart';
import 'myTextFormField.dart';
import 'package:flutter/services.dart';
import 'mandado.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

import 'package:searchable_dropdown/searchable_dropdown.dart';

class CrearGrupo extends StatefulWidget {
  CrearGrupo({
    this.usuarios,
    this.codigos,
  });
  final List<String> usuarios;
  final List<String> codigos;
  @override
  _MyAppState createState() =>
      _MyAppState(usuarios: usuarios, codigos: codigos);
}

class _MyAppState extends State<CrearGrupo> {
  List<String> usuarios;
  List<String> codigos;
  String nombre;
  final _formKey = GlobalKey<FormState>();
  _MyAppState({this.usuarios, this.codigos});
  bool asTabs = false;
  String selectedValue;
  String preselectedValue = "dolor sit";
  List<int> selectedItems = [];
  final List<DropdownMenuItem> items = [];

  static const String appTitle = "Search Choices demo";
  final String loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

  @override
  void initState() {
    for (int i = 0; i < codigos.length; i++) {
      items.add(DropdownMenuItem(
        child: Text(usuarios[i]),
        value: usuarios[i],
      ));
    }
    ;
    super.initState();
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Nuevo grupo creado'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(''),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Widget> widgets;
    const url = 'http://zapp.pythonanywhere.com/crearGrupo';
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

    final mandar = Material(
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            print("En el grupo");
            print(nombre);
            print(('entra'));
            for (int i = 0; i < selectedItems.length; i++) {
              print(usuarios[selectedItems[i]]);
              print(codigos[selectedItems[i]].toString());
              http.Response response = await http.post(
                url,
                body: jsonEncode(<String, dynamic>{
                  'nombre': nombre,
                  'idUsuario': codigos[selectedItems[i]].toString()
                }),
                headers: {
                  HttpHeaders.acceptHeader: 'application/json',
                  HttpHeaders.contentTypeHeader: 'application/json',
                },
              );
              final jsonResponse = jsonDecode(response.body);

              print(jsonResponse);
            }
            _showMyDialog();
          }
        },
        child: Text("Crear grupo",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    widgets = {
      "Socios a los que meter en el grupo:": SearchableDropdown.multiple(
        items: items,
        selectedItems: selectedItems,
        hint: "Selecciona agun socio",
        searchHint: "Selecciona algun socio",
        onChanged: (value) {
          setState(() {
            selectedItems = value;
          });
        },
        dialogBox: false,
        closeButton: (selectedItemsClose) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RaisedButton(
                  onPressed: () {
                    setState(() {
                      selectedItems.clear();
                      selectedItems.addAll(
                          Iterable<int>.generate(items.length).toList());
                    });
                  },
                  child: Text("Todos")),
              RaisedButton(
                  onPressed: () {
                    setState(() {
                      selectedItems.clear();
                    });
                  },
                  child: Text("Ninguno")),
            ],
          );
        },
        isExpanded: true,
        menuConstraints: BoxConstraints.tight(Size.fromHeight(350)),
      ),
    };

    return MaterialApp(
        home: Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        scrollDirection: Axis.vertical,
        child: SafeArea(
            child: Form(
          key: _formKey,
          child: Column(children: <Widget>[
            MyTextFormField(
              hintText: 'Nombre',
              text: 'Nombre del grupo:',
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Introduce un nombre para el gurpo';
                }
                return null;
              },
              onSaved: (String value) {
                nombre = value;
              },
            ),
            Container(
                child: Column(
              children: widgets
                  .map((k, v) {
                    return (MapEntry(
                        k,
                        Center(
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                                margin: EdgeInsets.all(20),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: <Widget>[
                                      Text("$k:"),
                                      v,
                                    ],
                                  ),
                                )))));
                  })
                  .values
                  .toList(),
            )),
            mandar
          ]
              /* children: widgets
                .map((k, v) {
                  return (MapEntry(
                      k,
                      Center(
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              margin: EdgeInsets.all(20),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: <Widget>[
                                    Text("$k:"),
                                    v,
                                  ],
                                ),
                              )))));
                })
                .values
                .toList(),*/
              ),
        )),
      ),
    ));
  }
}
