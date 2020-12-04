import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'vistasSocio.dart';
import 'myTextFormField.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

// ignore: must_be_immutable
class LoginSocio extends StatelessWidget {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String codigo;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    const url = 'http://zapp.pythonanywhere.com/loginSocio/';
    final loginButton = Material(
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();

            http.Response response = await http.post(
              url,
              body: jsonEncode(<String, String>{
                'idUser': codigo,
              }),
              headers: {
                HttpHeaders.acceptHeader: 'application/json',
                HttpHeaders.contentTypeHeader: 'application/json',
              },
            );

            final jsonResponse = jsonDecode(response.body);

            print(jsonDecode(response.body));

            if (jsonResponse.containsKey("error")) {
              print("Usuario no registrado");
              Fluttertoast.showToast(
                  msg: "Codigo incorrecto",
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
                  MaterialPageRoute(builder: (context) => VistasSocio()));
            }
          }
        },
        child: Text("Entrar",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text('LoginSocio'),
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                    /*
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
              */
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.04,
                        child: Text("Introduce tu código",
                            style: TextStyle(
                                fontFamily: 'Montserrat', fontSize: 20.0)),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.01,
                        child: const ColoredBox(color: Colors.amber),
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
                          isNumber: true),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.025,
                        // child: const ColoredBox(color: Colors.amber),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.52,
                        child: ResponsiveGridList(
                            desiredItemWidth:
                                MediaQuery.of(context).size.height * 0.09,
                            minSpacing: 10,
                            children: [1, 2, 3, 4, 5, 6, 7, 8, 9].map((i) {
                              return Container(
                                height: 100,
                                alignment: Alignment(0, 0),
                                color: Colors.cyan,
                                child: Text(i.toString()),
                              );
                            }).toList()),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.025,
                        //child: const ColoredBox(color: Colors.amber),
                      ),
                      loginButton,
                    ])),
          ),
        )));
  }
}
