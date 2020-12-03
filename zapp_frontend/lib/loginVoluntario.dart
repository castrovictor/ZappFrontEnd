import 'package:flutter/material.dart';
import 'vistasVoluntario.dart';
import 'myTextFormField.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';

const Map<String, String> header = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};

class LoginVoluntario extends StatefulWidget {
  LoginVoluntario({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginVoluntario createState() => _LoginVoluntario();
}

class _LoginVoluntario extends State<LoginVoluntario> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _formKey = GlobalKey<FormState>();
  String codigo;
  String contrasena;

  @override
  Widget build(BuildContext context) {
    const url = 'http://zapp.pythonanywhere.com/loginFacilitador/';
    final login = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();

            print(codigo);
            print(contrasena);

            http.Response response = await http.post(
              url,
              body: jsonEncode(<String, String>{
                'username': codigo,
                'password': contrasena,
              }),
              headers: {
                HttpHeaders.acceptHeader: 'application/json',
                HttpHeaders.contentTypeHeader: 'application/json',
              },
            );

            final jsonResponse = jsonDecode(response.body);

            if (jsonResponse.containsKey("error")) {
              print("Usuario no registrado");
              Fluttertoast.showToast(
                  msg: "Codigo o contraseña incorrecto",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
            if (jsonResponse.containsKey("success")) {
              print("Usuario de logea");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => VistasVoluntario()));
            }
          }
        },
        child: Text("Iniciar sesión",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
        // body: SingleChildScrollView(
        appBar: AppBar(
          title: const Text('Facilitador'),
        ),
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
                                  height: 155.0,
                                  child: Center(
                                    child: Image.asset(
                                      "assets/logo.png",
                                      fit: BoxFit.contain,
                                    ),
                                  )),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              MyTextFormField(
                                hintText: 'Código',
                                text: 'Codigo',
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Introduce un codigo';
                                  }
                                  return null;
                                },
                                onSaved: (String value) {
                                  codigo = value;
                                },
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              MyTextFormField(
                                hintText: 'Contraseña',
                                text: 'Contraseña',
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Introduce una contraseña';
                                  }
                                  return null;
                                },
                                onSaved: (String value) {
                                  contrasena = value;
                                },
                                isPassword: true,
                              ),
                              login,
                            ]))))));
  }
}
