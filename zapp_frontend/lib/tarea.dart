import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'chat.dart';
import 'dart:async';
import 'dart:convert';

//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
//import 'package:dash_chat/dash_chat.dart';
//import 'imagePicker.dart';

// ignore: must_be_immutable

File _image;
bool hayImagen = true;
File file;
bool hayFile = true;
File _video;
bool hayVideo = true;

class Tarea extends StatefulWidget {
  Tarea({this.iconData, this.title, this.description, this.idTarea});
  final IconData iconData;
  final String title;
  final String description;
  final String idTarea;

  Future getTareas(codigo) async {
    String url = 'http://zapp.pythonanywhere.com/actividad/';
    url = url + idTarea;
    http.Response response = await http.get(
      url,
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    final jsonResponse = jsonDecode(response.body);
  }

  @override
  _Tarea createState() => _Tarea();
}

class _Tarea extends State<Tarea> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  VideoPlayerController _controller;
  VoidCallback listener;

  @override
  void initState() {
    super.initState();
    if (hayVideo) {
      listener = () {
        setState(() {});
      };

      // _controller = VideoPlayerController.network(
      //     'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      //   ..initialize().then((_) {
      //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      //     setState(() {});
      //   });
    }
    if (hayImagen) {
      //
    }
    if (hayFile) {}
  }

  @override
  void createVideo() {
    if (_controller == null) {
      // para el api
      //_controller = VideoPlayerController.network("")
      _controller = VideoPlayerController.asset("assets/videoplayback.mp4")
        ..addListener(listener)
        ..setVolume(1.0)
        ..initialize();
    } else {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.initialize();
        _controller.play();
      }
    }
  }

  @override
  void deactivate() {
    _controller.setVolume(0.0);
    _controller.removeListener(listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final chat = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          /*
            Navigator.push(
                  context,
               //   MaterialPageRoute(builder: (context) => WelcomeScreen()));
               */
          /*
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.purple,
            ),
            home: Chat(),
          );
        */

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Chat(nombre: widget.title, idActividad: widget.idTarea)));
        },
        child: Text("Chat de tarea",
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
                        child: Text(widget.title,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.05,
                        //child: const ColoredBox(color: Colors.amber),
                      ),
                      Icon(widget.iconData, size: 100.0),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.05,
                        //child: const ColoredBox(color: Colors.amber),
                      ),
                      Expanded(
                        child: Text(widget.description,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 20.0,
                            )),
                      ),
                      Card(
                          child: (_image != null)
                              ? Image.file(_image)
                              : Container()
                          //: Image.asset('assets/gal.png'),
                          ),
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          child: (_controller != null
                              ? VideoPlayer(_controller)
                              : Container()),
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          createVideo();
                          _controller.play();
                        },
                        child: Icon(Icons.play_arrow),
                      ),
                      // Expanded(
                      //   child: MaterialApp(
                      //     title: 'Video',
                      //     home: Scaffold(
                      //       body: Center(
                      //         child: _controller.value.initialized
                      //             ? AspectRatio(
                      //                 aspectRatio:
                      //                     _controller.value.aspectRatio,
                      //                 child: VideoPlayer(_controller),
                      //               )
                      //             : Container(),
                      //       ),
                      //       floatingActionButton: FloatingActionButton(
                      //         onPressed: () {
                      //           setState(() {
                      //             _controller.value.isPlaying
                      //                 ? _controller.pause()
                      //                 : _controller.play();
                      //           });
                      //         },
                      //         child: Icon(
                      //           _controller.value.isPlaying
                      //               ? Icons.pause
                      //               : Icons.play_arrow,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Expanded(
                        child: Text(
                            'Sube tu solución o pregunta duda en el chat de tarea',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 20.0,
                            )),
                      ),

                      /* Expanded(
                          child: file == null
                              ? Center(
                                  child: Text('AÑADIR',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 20.0,
                                      )))
                              : Image.file(file)),
                      new FloatingActionButton(
                        onPressed: pickImage,
                        child: Icon(Icons.camera_alt, size: 25),
                      ),*/
                      chat,
                    ]))));
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

/* Lo que habia en GITHUB
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
//import 'imagePicker.dart';

// ignore: must_be_immutable

class Tarea extends StatefulWidget{
  @override
  _Tarea createState() => _Tarea();
}


class _Tarea extends Statel<Tarea> {
  Tarea({this.iconData, this.title, this.description});
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  File _image;

  void _getImage() async {
    PickedFile pickedFile = await ImagePicker.getImage(source: ImageSource.gallery);

    file = File(pickedFile.path);
  }

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
        onPressed: () {},
        
        child: Text("Contestar",
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
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.05,
                        //child: const ColoredBox(color: Colors.amber),
                      ),
                      Icon(iconData, size: 100.0),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.05,
                        //child: const ColoredBox(color: Colors.amber),
                      ),
                      Expanded(
                        child: Text(description,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 20.0,
                            )),
                      ),
                      Expanded(
                        body: file == null? Center(
                          child: Text(
                            'AÑADIR',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 20.0,
                            )),
                          )
                        ): Image.file(file),
                        floatingActionButton: FloatingActionButton(
                          onPressed: pickImage,
                          child: Icon(Icons.camera_alt, size: 25),
                        )
                      ),
                      //adjuntar,
                    ]))));
  }
}
*/
