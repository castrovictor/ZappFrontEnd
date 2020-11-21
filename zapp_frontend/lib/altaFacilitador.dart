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
