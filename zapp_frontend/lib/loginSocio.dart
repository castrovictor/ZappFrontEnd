import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'vistasSocio.dart';

// ignore: must_be_immutable
class LoginSocio extends StatelessWidget {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final codigo = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Código",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final loginButton = Material(
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => VistasSocio()));
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
                    //child: const ColoredBox(color: Colors.amber),
                  ),
                  codigo,
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
    );
  }
}
