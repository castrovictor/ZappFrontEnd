import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'tarea.dart';

import 'dart:convert';

//import 'imagePicker.dart';

// ignore: must_be_immutable

List<String> mensajes = new List<String>();
List<String> codigos = new List<String>();
class MensajeWidget extends StatelessWidget {
  MensajeWidget({this.iconData, this.title, this.onPressed, this.file,this.fimage, this.tutor});

  /// icon data
  final IconData iconData;
  final File file ;
  final File fimage;
  final bool tutor ;
  /// Title to show
  final String title;

  /// Airport to show
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.height * 0.075,
                    child: ColoredBox(
                        color: Colors.lightBlue[50],
                        child: Center(
                            //poner mensaje dependiendo de si es de tutor
                            //Distinguir si el contenido es nulll 
                          child: Text(title,
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)),
                        ))),
                        //



                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.height * 0.075,
                    child: ColoredBox(
                        color: Colors.lightBlue[50],
                        //
                        child: Center(child: Icon(iconData, size: 40.0)))),


              ])),
    );
  }
}
Future getMensajes(codigo) async {
  String url = 'http://zapp.pythonanywhere.com/mensaje/noentregadas/';
  url = url + codigo;
  //print(url);
  http.Response response = await http.get(
    url,
    headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
    },
  );

  final jsonResponse = jsonDecode(response.body);
  mensajes.clear();
  codigos.clear();
  if (jsonResponse.containsKey('Mensaje')) {
    for (int i = 0; i < jsonResponse['Mensaje'].length; i++) {
      mensajes.add(jsonResponse['Mensaje'][i]['contenido']);
      codigos.add(jsonResponse['Mensaje'][i]['id'].toString());
      //print(jsonResponse['mensaje'][i]['id'].toString());
    }
  }
}
class Chat extends StatefulWidget {



  Chat({this.contenido, this.idmensaje});
  final String contenido;
  final String idmensaje;
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
    Timer(Duration(milliseconds: 500), () {
      setState(() {
        getMensajes(widget.idmensaje);
      });
    });

    final chat = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text("Chat de Mensaje",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.contenido),
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
                      
                          child: ListView(children: [
                        for (int i = 0; i < mensajes.length; i++)


                            //*****CREA MENSAJE **************/
                          MensajeWidget(

                            
                            iconData: Icons.pending_actions_rounded,
                            title: mensajes[i],


                            onPressed: () async {
                              String url =
                                  'http://zapp.pythonanywhere.com/mensaje/';
                              url = url + codigos[i];
                              //print(url);
                              http.Response response = await http.get(
                                url,
                                headers: {
                                  HttpHeaders.acceptHeader: 'application/json',
                                  HttpHeaders.contentTypeHeader:
                                      'application/json',
                                },
                              );

                              final jsonResponse = jsonDecode(response.body);
                              print(jsonResponse);

                              String contenido =
                                  jsonResponse['mensaje']['contenido'];
                              String descripcion =
                                  jsonResponse['mensaje']['descripcion'];
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Tarea(
                                      iconData: Icons.pending_actions_rounded,
                                      title: contenido,
                                      description: descripcion)));
                            },
                          
                          
                            /******************************/

                          )

                      ]))
                    ]))));
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
