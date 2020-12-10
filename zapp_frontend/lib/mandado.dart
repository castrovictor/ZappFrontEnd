import 'package:flutter/material.dart';

class TareaMandada extends StatelessWidget {
  TareaMandada({this.nombre, this.selectedItems});
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  final List<int> selectedItems;
  final String nombre;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          child: Center(
                        child: Text("Pagina mandado en obras",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ))
                    ]))));
  }
}
