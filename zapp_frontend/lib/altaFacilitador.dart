import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:zapp_frontend/perfil.dart';
import 'perfil.dart';
import 'myTextFormField.dart';
import 'model.dart';
import 'package:http/http.dart' as http;

class AltaFacilitador extends StatefulWidget {
  AltaFacilitador();
  @override
  _AltaFacilitador createState() => _AltaFacilitador();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _AltaFacilitador extends State<AltaFacilitador> {
  final _formKey = GlobalKey<FormState>();
  ModelSocio model = ModelSocio();
  String nombre;
  String apellidos;
  String email;
  String contrasena;

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final altaFacilitador = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();

            //const url = 'https://pythoneverywhere/alta_socio';
            //await http.post(url,
            //    body: jsonEncode(<String, String>{
            //      'nombre': model.nombre,
            //    }));
            print(model.nombre);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Perfil()));
          }
        },
        child: Text("Dar de alta",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

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
                                child: Text("Alta Facilitador",
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold)),
                              )),
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
                                  nombre = value;
                                },
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              MyTextFormField(
                                hintText: 'Apellidos',
                                text: 'Apellidos',
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Introduce un apellido';
                                  }
                                  return null;
                                },
                                onSaved: (String value) {
                                  apellidos = value;
                                },
                              ),
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
                                  email = value;
                                },
                                isEmail: true,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              altaFacilitador,
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

/*
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:zapp_frontend/perfil.dart';
import 'perfil.dart';

class AltaFacilitador extends StatelessWidget {
  AltaFacilitador();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final nombre = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Nombre",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final apellidos = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Apellidos",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final contrasena = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Contraseña",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final email = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Apellido",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final crear = Material(
        borderRadius: BorderRadius.circular(30.0),
        color: Color(0xff01A0C7),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Perfil()));
          },
          child: Text("Dar alta",
              textAlign: TextAlign.center,
              style: style.copyWith(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        ));

    return Scaffold(
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      SizedBox(
                          child: Center(
                        child: Text("Alta Facilitador",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold)),
                      )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      SizedBox(
                          child: Text(
                        "Nombre:",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20.0,
                        ),
                      )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      nombre,
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
                      contrasena,
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      crear,
                    ])))));
  }
}
*/
