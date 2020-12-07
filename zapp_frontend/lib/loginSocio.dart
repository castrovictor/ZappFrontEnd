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

class LoginSocio extends StatefulWidget {
  LoginSocio();
  @override
  _LoginSocio createState() => _LoginSocio();
}

// ignore: must_be_immutable
class _LoginSocio extends State<LoginSocio> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String codigo = "";
  final _formKey = GlobalKey<FormState>();
  List<String> lista = [];

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
          padding: const EdgeInsets.only(
              left: 36.0, right: 36.0, top: 10.0, bottom: 10.0),
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.04,
                    child: Text("Introduce tu código",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.98,
                    height: MediaQuery.of(context).size.height * 0.10,
                    child: ColoredBox(
                        color: Colors.grey,
                        child: ResponsiveGridList(
                            desiredItemWidth:
                                MediaQuery.of(context).size.height * 0.1,
                            minSpacing: 1,
                            children: lista.map((imagen) {
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                height:
                                    MediaQuery.of(context).size.height * 0.10,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  image: DecorationImage(
                                      image: AssetImage(
                                        imagen,
                                      ),
                                      fit: BoxFit.contain),
                                ),
                              );
                            }).toList())),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.025,
                    // child: const ColoredBox(color: Colors.amber),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.04,
                    child: Center(
                        child: Text("Teclado",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ))),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.52,
                      child: ResponsiveGridList(
                        desiredItemWidth:
                            MediaQuery.of(context).size.height * 0.11,
                        minSpacing: 10,
                        children: <Widget>[
                          Container(
                              height: 120,
                              width: 40,
                              child: GestureDetector(
                                  onTap: () {
                                    if (lista.length < 4) {
                                      codigo += 1.toString();
                                      print(codigo);
                                      setState(() {
                                        lista.add('assets/sol.jpg');
                                      });
                                    } else {}
                                  },
                                  child: Image.asset('assets/sol.jpg'))),
                          Container(
                              height: 120,
                              width: 40,
                              child: GestureDetector(
                                  onTap: () {
                                    if (lista.length < 4) {
                                      codigo += 2.toString();
                                      print(codigo);
                                      setState(() {
                                        lista.add('assets/luna.png');
                                      });
                                    }
                                  },
                                  child: Image.asset('assets/luna.png'))),
                          Container(
                              height: 120,
                              width: 40,
                              child: GestureDetector(
                                  onTap: () {
                                    if (lista.length < 4) {
                                      codigo += 3.toString();
                                      print(codigo);
                                      setState(() {
                                        lista.add('assets/sol.jpg');
                                      });
                                    }
                                  },
                                  child: Image.asset('assets/sol.jpg'))),
                          Container(
                              height: 120,
                              width: 40,
                              child: GestureDetector(
                                  onTap: () {
                                    if (lista.length < 4) {
                                      codigo += 4.toString();
                                      print(codigo);
                                      setState(() {
                                        lista.add('assets/sol.jpg');
                                      });
                                    }
                                  },
                                  child: Image.asset('assets/sol.jpg'))),
                          Container(
                              height: 120,
                              width: 40,
                              child: GestureDetector(
                                  onTap: () {
                                    if (lista.length < 4) {
                                      codigo += 5.toString();
                                      print(codigo);
                                      setState(() {
                                        lista.add('assets/sol.jpg');
                                      });
                                    }
                                  },
                                  child: Image.asset('assets/sol.jpg'))),
                          Container(
                              height: 120,
                              width: 40,
                              child: GestureDetector(
                                  onTap: () {
                                    if (lista.length < 4) {
                                      codigo += 6.toString();
                                      print(codigo);
                                      setState(() {
                                        lista.add('assets/sol.jpg');
                                      });
                                    }
                                  },
                                  child: Image.asset('assets/sol.jpg'))),
                          Container(
                              height: 120,
                              width: 40,
                              child: GestureDetector(
                                  onTap: () {
                                    if (lista.length < 4) {
                                      codigo += 7.toString();
                                      print(codigo);
                                      setState(() {
                                        lista.add('assets/sol.jpg');
                                      });
                                    }
                                  },
                                  child: Image.asset('assets/sol.jpg'))),
                          Container(
                              height: 120,
                              width: 40,
                              child: GestureDetector(
                                  onTap: () {
                                    if (lista.length < 4) {
                                      codigo += 8.toString();
                                      print(codigo);
                                      setState(() {
                                        lista.add('assets/sol.jpg');
                                      });
                                    }
                                  },
                                  child: Image.asset('assets/sol.jpg'))),
                          Container(
                              height: 120,
                              width: 40,
                              child: GestureDetector(
                                  onTap: () {
                                    if (lista.length < 4) {
                                      codigo += 9.toString();
                                      print(codigo);
                                      setState(() {
                                        lista.add('assets/sol.jpg');
                                      });
                                    }
                                  },
                                  child: Image.asset('assets/sol.jpg'))),
                          Container(
                              height: 120,
                              width: 40,
                              child: GestureDetector(
                                  onTap: () {
                                    if (lista.length < 4) {
                                      codigo += 0.toString();
                                      print(codigo);
                                      setState(() {
                                        lista.add('assets/sol.jpg');
                                      });
                                    }
                                  },
                                  child: Image.asset('assets/sol.jpg'))),
                          Container(
                              height: 120,
                              width: 40,
                              child: GestureDetector(
                                  onTap: () {
                                    if (lista.length > 0) {
                                      String x = codigo;
                                      List<String> c = x.split("");
                                      c.removeLast();
                                      codigo = c.join();
                                      print(codigo);
                                      setState(() {
                                        lista.removeLast();
                                      });
                                    }
                                  },
                                  child: Image.asset('assets/borrar.jpg'))),
                        ],
                      )
                      /*children: [1, 2, 3, 4, 5, 6, 7, 8, 9].map((i) {
                              return Container(
                                height: 100,
                                alignment: Aligfnment(0, 0),
                                color: Colors.cyan,
                                child: Text(i.toString()),
                              );
                            }).toList()),*/
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
