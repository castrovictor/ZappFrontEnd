import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'perfil2.dart';
import 'myTextFormField.dart';
import 'model.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';

class AltaSocio extends StatefulWidget {
  AltaSocio();
  @override
  _AltaSocio createState() => _AltaSocio();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _AltaSocio extends State<AltaSocio> {
  final _formKey = GlobalKey<FormState>();
  ModelSocio model = ModelSocio();
  DateTime selectedDate;

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog(String id, String nombre) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Nuevo socio creado'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('El ID de 1' + nombre + ' es ' + id),
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

    final altaSocio = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Color(0xff01A0C7),
        child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();

                final DateFormat formatter = DateFormat('yyyy-MM-dd');
                final String formattedDate = formatter.format(selectedDate);

                const url = 'http://zapp.pythonanywhere.com/crearSocio/';
                http.Response response = await http.post(
                  url,
                  body: jsonEncode(<String, dynamic>{
                    "user": {
                      'username': model.nombre,
                      'email': model.email,
                      'fechaNacimiento': formattedDate,
                    }
                  }),
                  headers: {
                    HttpHeaders.acceptHeader: 'application/json',
                    HttpHeaders.contentTypeHeader: 'application/json',
                  },
                );

                final jsonResponse = jsonDecode(response.body);

                print(response.body);
                print(formattedDate);
                print(selectedDate);
                print(model.nombre);

                print(jsonResponse['id'].toString());

                if (jsonResponse.containsKey("error")) {
                  print("Este usuario ya existe");
                  Fluttertoast.showToast(
                      msg: "Este usuario ya existe",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
                if (jsonResponse.containsKey("success")) {
                  _showMyDialog(jsonResponse['id'].toString(), model.nombre);
                }
              }
            },
            child: Text("Dar de alta",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold))));

    return Scaffold(
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: SingleChildScrollView(
                    child: Form(
                        key: _formKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                child: Center(
                                    child: Text(
                                  'Alta Socio',
                                  style: TextStyle(
                                    fontFamily: 'Monste',
                                    fontSize: 40,
                                    letterSpacing: 2.5,
                                  ),
                                )),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              MyTextFormField(
                                hintText: 'Nombre',
                                text: 'Nombre',
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Introduce un nombre';
                                  }
                                  return null;
                                },
                                onSaved: (String value) {
                                  model.nombre = value;
                                },
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              /*MyTextFormField(
                                hintText: 'Apellidos',
                                text: 'Apellidos',
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Introduce un apellido';
                                  }
                                  return null;
                                },
                                onSaved: (String value) {
                                  model.apellidos = value;
                                },
                              ),*/
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              MyTextFormField(
                                hintText: 'Email',
                                text: 'Email',
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Introduce un email';
                                  }
                                  return null;
                                },
                                onSaved: (String value) {
                                  model.email = value;
                                },
                                isEmail: true,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              DateTimeField(
                                selectedDate: selectedDate,
                                onDateSelected: (DateTime date) {
                                  setState(() {
                                    selectedDate = date;
                                  });
                                },
                                lastDate: DateTime(2020),
                                mode: DateFieldPickerMode.date,
                              ),
                              altaSocio,
                            ]))))));
  }
}

/*
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Nombre",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    )
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      SizedBox(
                          child: Text(
                        "Apellidos:",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20.0,
                        ),
                      )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      apellidos,
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      SizedBox(
                        child: Text(
                        "Contraseña:",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20.0,
                        ),
                      )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      DateTimeField(
                selectedDate: selectedDate,
                    onDateSelected: (DateTime date) {
                      setState(() {
                        selectedDate = date;
                      });
                    },
                    lastDate: DateTime(2020),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      crear,
                    ])))));
  }
}
*/
