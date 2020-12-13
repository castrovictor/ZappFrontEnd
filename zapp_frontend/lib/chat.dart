import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'tarea.dart';
import 'myTextFormField.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

//import 'imagePicker.dart';

// ignore: must_be_immutable

List<String> mensajes = new List<String>();
List<String> codigos = new List<String>();
List<bool> tutor = new List<bool>();

class MensajeWidget extends StatelessWidget {
  MensajeWidget(
      {this.iconData,
      this.title,
      this.onPressed,
      this.file,
      this.fimage,
      this.tutor});

  /// icon data
  final IconData iconData;
  final File file;
  final File fimage;
  final bool tutor;

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
                      // child: Center(
                      //poner mensaje dependiendo de si es de tutor
                      //Distinguir si el contenido es nulll
                      child: Text(title,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                    )),
                //

                /*   SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.height * 0.075,
                    child: ColoredBox(
                        color: Colors.lightBlue[50],
                        //
                        child: Center(child: Icon(iconData, size: 40.0)))),*/
              ])),
    );
  }
}

Future getMensajes(idActividad) async {
  String url = 'http://zapp.pythonanywhere.com/actividad/adjuntar/';
  url = url + idActividad;
  //print(url);
  /*http.Response response = await http.get(
    url,
    headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
    },
  );*/

  //final jsonResponse = jsonDecode(response.body);
  mensajes.clear();
  tutor.clear();
  mensajes.add("hola");
  tutor.add(true);
  mensajes.add("que tal");
  tutor.add(false);

  /*if (jsonResponse.containsKey('Adjuntado')) {
    for (int i = 0; i < jsonResponse['Adjuntado'].length; i++) {
      mensajes.add(jsonResponse['Adjuntado'][i]['comentario']);
      if (jsonResponse['Adjuntado'][i]['is_staff']) {
        tutor.add('true');
      } else {
        tutor.add('false');
      }
    }*/
}

class Chat extends StatefulWidget {
  Chat({this.nombre, this.idActividad});
  final String nombre;
  final String idActividad;

  @override
  _Chat createState() => _Chat();
}

class _Chat extends State<Chat> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _formKey = GlobalKey<FormState>();
  String mensaje;

  /*File _image;
  File file;

  void _getImage() async {
    PickedFile pickedFile =
        await ImagePicker.getImage(source: ImageSource.gallery);

    file = File(pickedFile.path);
  }*/
  final TextEditingController textEditingController = TextEditingController();
  Widget buildInput() {
  
      if (textEditingController.text != '') {
             textEditingController.clear();
          }
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                icon: Icon(Icons.image),
             //   onPressed: getImage,
              //  color: primaryColor,
              ),
            ),
            color: Colors.white,
          ),
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                icon: Icon(Icons.face),
             //   onPressed: getSticker,
             //   color: primaryColor,
              ),
            ),
            color: Colors.white,
          ),

          // Edit text
         
          Flexible(
            child: Container(
          //      width: 100.00,
            child: TextField(
                  controller: textEditingController,
                   decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: Colors.blue),
                ),
                 onSubmitted: (value) {

                     mensaje = value;
                      textEditingController.clear();
                 }
              /*
                child: MyTextFormField(
                            hintText: 'Escribe mensaje',
                            text: 'Escribe ',
                            onSaved: (String value) {
                              mensaje = value;
                            },
                    */
                /*
                onSubmitted: (value) {
                  onSendMessage(textEditingController.text, 0);
                },
                style: TextStyle(color: primaryColor, fontSize: 15.0),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: greyColor),
                ),
                focusNode: focusNode,
                */
              ),
            ),
          ),
        
          // Button send message
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: Icon(Icons.send),
            //    onPressed: () => onSendMessage(textEditingController.text, 0),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                setState(() {
                  mensajes.add(mensaje);
                  tutor.add(true);
                });
                _formKey.currentState.reset();
              }
               _formKey.currentState.reset();
            },
                color: Colors.blueGrey,
              ),
            ),
            color: Colors.white,
          ),
        ],
     
     
      ),



      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.green, width: 0.5)),
          color: Colors.white),
          // Button send message
          /*
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => onSendMessage(textEditingController.text, 0),
                color: primaryColor,
              ),
            ),
            color: Colors.white,
          ),

          */
        //  )
    );

  }


  @override
  Widget build(BuildContext context) {
    /*
    final enviarMensaje = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Color(0xff01A0C7),
        child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                setState(() {
                  mensajes.add(mensaje);
                  tutor.add(true);
                });
                _formKey.currentState.reset();
              }
            }));


        */
    /*
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();

              const url = 'http://zapp.pythonanywhere.com/actividad/adjuntar/';
              http.Response response = await http.post(
                url,
                body: jsonEncode(<String, dynamic>{
                  "adjutando": {
                    'comentario': mensaje,
                    'idActividad': widget.idActividad,
                    'is_staff': 'false',
                  }
                }),
                headers: {
                  HttpHeaders.acceptHeader: 'application/json',
                  HttpHeaders.contentTypeHeader: 'application/json',
                },
              );

              final jsonResponse = jsonDecode(response.body);

              print(response.body);

              print(jsonResponse['id'].toString());
            }*/
    // }));

    /*  Timer(Duration(milliseconds: 500), () {
      setState(() {
        mensajes.add("hola");
        tutor.add(true);
        mensajes.add("que tal");
        tutor.add(false);
        //getMensajes(widget.idActividad);
      });
    });*/
    /* Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        getMensajes(widget.idActividad);
      });
    });*/

    /*final chat = Material(
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
    );*/

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.nombre),
          backgroundColor: Colors.green,
        ),
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                    key: _formKey,
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
                                tutor: tutor[i],
                                onPressed: () async {
                                  /*String url =
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
                                      description: descripcion)))*/
                                },
                              )

                            /******************************/
                          ])),
                         
                        
                        //  enviarMensaje,
                          buildInput(),
                     
                        ])))));
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}