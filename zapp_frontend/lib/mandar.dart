import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'mandado.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'biblioteca.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:http_parser/http_parser.dart';

import 'package:searchable_dropdown/searchable_dropdown.dart';

List<String> grupos = new List<String>();

class MyApp extends StatefulWidget {
  MyApp(
      {this.nombre,
      this.descripcion,
      this.usuarios,
      this.codigos,
      this.imagen,
      this.video,
      this.file,
      this.grupos});
  final String nombre;
  final String descripcion;
  final List<String> usuarios;
  final List<String> codigos;
  final String imagen;
  final String video;
  final String file;
  final List<String> grupos;
  //final List<String> grupos;
  @override
  _MyAppState createState() =>
      _MyAppState(usuarios: usuarios, codigos: codigos, grupos: grupos);
}

class _MyAppState extends State<MyApp> {
  List<String> usuarios;
  List<String> codigos;
  List<String> grupos;
  _MyAppState({this.usuarios, this.codigos, this.grupos});
  bool asTabs = false;
  String selectedValue;
  String preselectedValue = "";
  List<int> selectedItems = [];
  final List<DropdownMenuItem> items = [];
  String selectedValue2;
  String preselectedValue2 = "";
  List<int> selectedItems2 = [];
  final List<DropdownMenuItem> items2 = [];

  static const String appTitle = "Search Choices demo";
  final String loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

  /*Future getGrupos() async {
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
    grupos.clear();
    for (int i = 0; i < jsonResponse['grupos'].length; i++) {
      grupos.add(jsonResponse['grupos'][i]);
    }
    for (int i = 0; i < grupos.length; i++) {
      print(grupos[i]);
      //print(codigos[i]);
    }
  }*/

  @override
  void initState() {
    print("hay " + grupos.length.toString());
    for (int i = 0; i < codigos.length; i++) {
      items.add(DropdownMenuItem(
        child: Text(usuarios[i]),
        value: usuarios[i],
      ));
    }
    for (int j = 0; j < grupos.length; j++) {
      print(j);
      items2.add(DropdownMenuItem(
        child: Text(grupos[j]),
        value: grupos[j],
      ));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Widget> widgets;
    const url = 'http://zapp.pythonanywhere.com/crearActividad/';
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

    Future<void> _showMyDialog(String nombre) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Nueva tarea creada'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Nombre de tarea: ' + nombre),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }

    final mandar = Material(
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          print(widget.nombre);
          print(widget.descripcion);
          print(widget.imagen);
          var response;
          for (int i = 0; i < selectedItems2.length; i++) {
            String url = 'http://zapp.pythonanywhere.com/grupos/';
            url = url + grupos[selectedItems2[i]];
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
            for (int i = 0; i < jsonResponse['usuarios'].length; i++) {
              print("añado a " + usuarios[jsonResponse['usuarios'][i]]);
              if (!selectedItems.contains(jsonResponse['usuarios'][i])) {
                print("usuario nuevo, se añade");
                selectedItems.add(jsonResponse['usuarios'][i]);
              }
            }
          }

          for (int i = 0; i < selectedItems.length; i++) {
            print("se envia a");
            print(codigos[selectedItems[i]].toString());
            print(widget.nombre);
            var uri =
                Uri.parse('http://zapp.pythonanywhere.com/crearActividad/');

            if (widget.imagen == 'no' &&
                widget.imagen == 'no' &&
                widget.file == 'no') {
              var request = http.MultipartRequest('PUT', uri)
                ..fields['nombre'] = widget.nombre
                ..fields['descripcion'] = widget.descripcion
                ..fields['idUsuario'] = codigos[selectedItems[i]]
                ..fields['idProfesional'] = "1"
                ..fields['categoria'] = "1";
              /*  ..files.add(await http.MultipartFile.fromPath(
                    'imagen', widget.imagen,
                    contentType: MediaType('application', 'udefined')))
                ..files.add(await http.MultipartFile.fromPath(
                    'video', widget.video.path,
                    contentType: MediaType('application', 'undefined')))
                ..files.add(await http.MultipartFile.fromPath(
                    'pdf', widget.file.path,
                    contentType: MediaType('application', 'undefined')));*/
              response = await request.send();
              if (response.statusCode == 200) print('Uploaded!');
            }
            if (widget.imagen != 'no' &&
                widget.video == 'no' &&
                widget.file == 'no') {
              var request = http.MultipartRequest('PUT', uri)
                ..fields['nombre'] = widget.nombre
                ..fields['descripcion'] = widget.descripcion
                ..fields['idUsuario'] = codigos[selectedItems[i]]
                ..fields['idProfesional'] = "1"
                ..fields['categoria'] = "1"
                ..files.add(await http.MultipartFile.fromPath(
                    'imagen', widget.imagen,
                    contentType: MediaType('application', 'udefined')));
              /*  ..files.add(await http.MultipartFile.fromPath(
                    'video', widget.video.path,
                    contentType: MediaType('application', 'undefined')))
                ..files.add(await http.MultipartFile.fromPath(
                    'pdf', widget.file.path,
                    contentType: MediaType('application', 'undefined')));*/
              response = await request.send();
              if (response.statusCode == 200) print('Uploaded!');
            }

            if (widget.imagen != 'no' &&
                widget.video != 'no' &&
                widget.file == 'no') {
              var request = http.MultipartRequest('PUT', uri)
                ..fields['nombre'] = widget.nombre
                ..fields['descripcion'] = widget.descripcion
                ..fields['idUsuario'] = codigos[selectedItems[i]]
                ..fields['idProfesional'] = "1"
                ..fields['categoria'] = "1"
                ..files.add(await http.MultipartFile.fromPath(
                    'imagen', widget.imagen,
                    contentType: MediaType('application', 'udefined')))
                ..files.add(await http.MultipartFile.fromPath(
                    'video', widget.video,
                    contentType: MediaType('application', 'undefined')));
              /*  ..files.add(await http.MultipartFile.fromPath(
                    'pdf', widget.file.path,
                    contentType: MediaType('application', 'undefined')));*/
              response = await request.send();
              if (response.statusCode == 200) print('Uploaded!');
            }

            if (widget.imagen != 'no' &&
                widget.video != 'no' &&
                widget.file != 'no') {
              var request = http.MultipartRequest('PUT', uri)
                ..fields['nombre'] = widget.nombre
                ..fields['descripcion'] = widget.descripcion
                ..fields['idUsuario'] = codigos[selectedItems[i]]
                ..fields['idProfesional'] = "1"
                ..fields['categoria'] = "1"
                ..files.add(await http.MultipartFile.fromPath(
                    'imagen', widget.imagen,
                    contentType: MediaType('application', 'udefined')))
                ..files.add(await http.MultipartFile.fromPath(
                    'video', widget.video,
                    contentType: MediaType('application', 'undefined')))
                ..files.add(await http.MultipartFile.fromPath(
                    'pdf', widget.file,
                    contentType: MediaType('application', 'undefined')));
              response = await request.send();
              if (response.statusCode == 200) print('Uploaded!');
            }

            if (widget.imagen == 'no' &&
                widget.video != 'no' &&
                widget.file != 'no') {
              var request = http.MultipartRequest('PUT', uri)
                ..fields['nombre'] = widget.nombre
                ..fields['descripcion'] = widget.descripcion
                ..fields['idUsuario'] = codigos[selectedItems[i]]
                ..fields['idProfesional'] = "1"
                ..fields['categoria'] = "1"
                /* ..files.add(await http.MultipartFile.fromPath(
                    'imagen', widget.imagen,
                    contentType: MediaType('application', 'udefined')))*/
                ..files.add(await http.MultipartFile.fromPath(
                    'video', widget.video,
                    contentType: MediaType('application', 'undefined')))
                ..files.add(await http.MultipartFile.fromPath(
                    'pdf', widget.file,
                    contentType: MediaType('application', 'undefined')));
              response = await request.send();
              if (response.statusCode == 200) print('Uploaded!');
            }

            if (widget.imagen == 'no' &&
                widget.video == 'no' &&
                widget.file != 'no') {
              var request = http.MultipartRequest('PUT', uri)
                ..fields['nombre'] = widget.nombre
                ..fields['descripcion'] = widget.descripcion
                ..fields['idUsuario'] = codigos[selectedItems[i]]
                ..fields['idProfesional'] = "1"
                ..fields['categoria'] = "1"
                /* ..files.add(await http.MultipartFile.fromPath(
                    'imagen', widget.imagen,
                    contentType: MediaType('application', 'udefined')))
                ..files.add(await http.MultipartFile.fromPath(
                    'video', widget.video,
                    contentType: MediaType('application', 'undefined')))*/
                ..files.add(await http.MultipartFile.fromPath(
                    'pdf', widget.file,
                    contentType: MediaType('application', 'undefined')));
              response = await request.send();
              if (response.statusCode == 200) print('Uploaded!');
            }

            if (widget.imagen != 'no' &&
                widget.video == 'no' &&
                widget.file != 'no') {
              var request = http.MultipartRequest('PUT', uri)
                ..fields['nombre'] = widget.nombre
                ..fields['descripcion'] = widget.descripcion
                ..fields['idUsuario'] = codigos[selectedItems[i]]
                ..fields['idProfesional'] = "1"
                ..fields['categoria'] = "1"
                ..files.add(await http.MultipartFile.fromPath(
                    'imagen', widget.imagen,
                    contentType: MediaType('application', 'udefined')))
                /*  ..files.add(await http.MultipartFile.fromPath(
                    'video', widget.video,
                    contentType: MediaType('application', 'undefined')))*/
                ..files.add(await http.MultipartFile.fromPath(
                    'pdf', widget.file,
                    contentType: MediaType('application', 'undefined')));
              response = await request.send();
              if (response.statusCode == 200) print('Uploaded!');
            }

            /*   if (widget.imagen != 'no') {
               var request2 = http.MultipartRequest('PUT', uri)
               ..fields['idActividad'] = await response.stream.transform(utf8.decoder).join()['id'];
               ..files.add(await http.MultipartFile.fromPath(
                  'imagen', widget.imagen,
                  contentType: MediaType('application', 'udefined')));
            }
            if (widget.imagen != 'no') {
               var request2 = http.MultipartRequest('PUT', uri)
               ..files.add(await http.MultipartFile.fromPath(
                  'imagen', widget.imagen,
                  contentType: MediaType('application', 'udefined')));
            }
            if (widget.imagen != 'no') {
               var request2 = http.MultipartRequest('PUT', uri)
               ..files.add(await http.MultipartFile.fromPath(
                  'imagen', widget.imagen,
                  contentType: MediaType('application', 'udefined')));
            }
            if (widget.imagen != 'no') {
               var request2 = http.MultipartRequest('PUT', uri)
               ..files.add(await http.MultipartFile.fromPath(
                  'imagen', widget.imagen,
                  contentType: MediaType('application', 'udefined')));
            }*/

            print(await response.stream.transform(utf8.decoder).join());

            print(widget.imagen);
            print(widget.video);
            print(widget.file);
          }
          _showMyDialog(widget.nombre);
          /*Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TareaMandada(
                      nombre: "hola", selectedItems: selectedItems)));*/
        },
        child: Text("Mandar",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    widgets = {
      "Socios a los que mandar la tarea:": SearchableDropdown.multiple(
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
      "Grupos a los que mandar la tarea": SearchableDropdown.multiple(
        items: items2,
        selectedItems: selectedItems2,
        hint: "Selecciona un grupo",
        searchHint: "Selecciona un grupo",
        onChanged: (value) {
          setState(() {
            selectedItems2 = value;
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
                      selectedItems2.clear();
                      selectedItems2.addAll(
                          Iterable<int>.generate(items2.length).toList());
                    });
                  },
                  child: Text("Todos")),
              RaisedButton(
                  onPressed: () {
                    setState(() {
                      selectedItems2.clear();
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
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(children: <Widget>[
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
        ),
      ),
    ));
  }
}
