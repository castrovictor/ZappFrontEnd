import 'package:flutter/material.dart';
/*
import 'filePicker.dart';
*/

// ignore: must_be_immutable
class Tarea extends StatelessWidget {
  Tarea({this.iconData, this.title, this.description});
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  /// icon data
  final IconData iconData;

  /// Title to show
  final String title;

  // Description to show
  final String description;

  @override
  Widget build(BuildContext context) {
    final adjuntar = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        /*onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => FilePickerDemo()));
        },*/
        child: Text("Adjuntar",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
        /* appBar: AppBar(
          title: Text('Sub Page'),
          backgroundColor: Colors.redAccent,
        ),*/
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text(title,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.02,
                        //child: const ColoredBox(color: Colors.amber),
                      ),
                      Icon(iconData, size: 60.0),
                      Expanded(
                        child: Text(description,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 20.0,
                            )),
                      ),
                      //adjuntar,
                    ]))));
  }
}
