import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
//import 'imagePicker.dart';

// ignore: must_be_immutable

class Chat extends StatefulWidget {
  Chat({this.nombre, this.idActividad});
  final String nombre;
  final String idActividad;
  @override
  _Chat createState() => _Chat();
}

class _Chat extends State<Chat> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  /*File _image;
  File file;

  void _getImage() async {
    PickedFile pickedFile =
        await ImagePicker.getImage(source: ImageSource.gallery);

    file = File(pickedFile.path);
  }*/

  @override
  Widget build(BuildContext context) {
    final chat = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text("Chat de tarea",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.nombre),
          backgroundColor: Colors.green,
        ),
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text('Sin hacer',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 20.0,
                            )),
                      ),
                    ]))));
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
