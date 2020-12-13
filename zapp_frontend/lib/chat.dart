import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'tarea.dart';
import 'myTextFormField.dart';
import 'pdf.dart';

import 'package:file_picker/file_picker.dart';

import 'package:flutter/widgets.dart';
import 'filepickerdemo.dart';
import 'package:flutter/widgets.dart';

import 'package:video_player/video_player.dart';

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

/************************************************************************************************ */
  //*******************************+IMAGENES */
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });

  }
  //*****************IMAGENES**************************************/ */

  //*************************************ARCHIVOS********************** */
  List<File> files;
  File file;
  //****************************************ARCHIVOS******************* */

  /******************************************VIDEOO****************************** */
  File _video;
  VideoPlayerController _videoPlayerController;


/************************************************************************************************ */

// This funcion will helps you to pick a Video File
  _pickVideo() async {
      PickedFile pickedFile = await picker.getVideo(source: ImageSource.gallery);
      _video = File(pickedFile.path); 
      _videoPlayerController = VideoPlayerController.file(_video)..initialize().then((_) {
        setState(() { });
        _videoPlayerController.play();
      });
}

  //Subir imágenes
  //**************************************************************************************************** */
  Future<String> uploadImage(filename, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('picture', filename));
    var res = await request.send();
    return res.reasonPhrase;
  }

  String state = "";


  @override
  Widget build(BuildContext context) {

     double radius = 40;
    double iconSize = 40;
    double distance = 10;
    var file = null;
    Future<void> _showMyDialog() async {
         setState(() {});

  
      return showDialog<void>(
        context: context,
  builder: (context) {
    String contentText = "Content of Dialog";
    return StatefulBuilder(
      builder: (context, setState) {
          return AlertDialog(
            title: Text('Adjuntar archivo'),
            content: SingleChildScrollView(
        //      child: ListBody(
          child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[


                    Text(contentText),
                    Card(
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 25.0),
                        child: Column(

                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              /*FUNCIONA PARA UN ARCHIVO*/
                              files == null
                                  //  ? Text('No image selected.')
                                  ? Text('')
                                  //  : Image.file(files.first)
                                  : // ListView(
                                  Card(
                                      
                                      child: ListTile(
                                      title:
                                          Text(files[0].path.split('/').last),
                                      leading: Icon(Icons.picture_as_pdf),
                                      trailing: IconButton(
                                          icon: Icon(Icons.delete),

                                          //Borrar archivo
                                          onPressed: () async {
                                           //  setState(() {});
                                            setState(() {});
                                             setState(() {
                  contentText = "Changed Content of Dialog";
                });
                                            try {
                                          
                                              await files.first.delete();
                                              files=null ;
                                              print('Deleted');
                                              print('IMPRIMO URL' +files.first.toString());
                                              setState(() {});

                                            } catch (e) {

                                              files=null ;
                                              print('Couldnt delete');
                                              print('IMPRIMO URL' +
                                              files.first.toString());
                                          
                                            }
                                           setState(() {});

                                            //    file[0]=null ;
                                          }),
                                      // trailing: Icon(Icons.arrow_forward, color: Colors.redAccent,),
                                      onTap: () {
                                           setState(() {});
                                             setState(() {
                                        contentText = "Changed Content of Dialog";
                                    });
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return ViewPDF(
                                              pathPDF:
                                                  files[0].path.toString());
                                          //open viewPDF page on click
                                        }));
                                      },
                                    )
                              ),
                             
                            

                              ListTile(
                                //leading: Icon (icono al principio

                                //BOTON ADJUNTAR IMAGEN
                                trailing: IconButton(
                                  icon: Icon(Icons.attach_file),
                                  onPressed: () async {
                                   
                                       setState(() {});
                                        setState(() {
                                                          contentText = "Changed Content of Dialog";
                                                        });
                                 
                                    //*******************************VARIOS ARCHIVOS ****************************** */

                                    FilePickerResult result = await FilePicker
                                        .platform
                                        .pickFiles(allowMultiple: true);

                                    if (result != null) {
                                      //   List<File> files = result.paths.map((path) => File(path)).toList();
                                      files = result.paths
                                          .map((path) => File(path))
                                          .toList();
                                      print('IMPRIMO URL' +
                                          files.first.toString());
                                    } else {
                                      // User canceled the picker
                                    }
                                    setState(() {});

                                    //***************************************ARCHIVOOOOOO**********************************************////
                                  },
                                ),

                                title: Text(
                                  '  ',
                                  style: TextStyle(
                                      fontFamily: 'BalooBhai', fontSize: 20.0),
                                ),
                              ),

                            ])),
                    /***********************************************************************************IMAGEN*******************************+ */
                    
                    InkWell(
                      onTap: getImage,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 40.0,
                        
                          child: CircleAvatar(
                            
                              child: (_image != null)
                                  ? Image.file(_image)
                                  : Image.asset('assets/gal.png'),
                                  backgroundColor: Colors.white,
                                  radius: 50.0,
                               ),
                        //  backgroundColor: Colors.white,


                        
                      ),
                    ),
                     Positioned(
                           top: -(radius + iconSize + distance),
                          right: 0,
                          bottom: radius,
                          left: 0,
                          child:  IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () async {
                                    setState(() {});
                                            try {
                                          
                                              await _image.delete();
                                             // files=null ;
                                              print('Deleted image');
                                              print('IMPRIMO image' +_image.toString());
                                             // setState(() {});

                                            } catch (e) {

                                              _image=null ;
                                              print('Couldnt delete image');
                                              print('IMPRIMO image' +
                                              _image.toString());
                                          
                                            }
                                          setState(() {});
                                  }
                            /*Icon(
                            Icons.delete_forever,
                            color: Colors.grey,
                            size: iconSize,
                            */  
                          )
                  ),

                    
                    /***********************************************************************************IMAGEN*******************************+ */



                                            _video==null

                                                ?
                                                        InkWell(
                                                              onTap:  _pickVideo,
                                                          child: CircleAvatar(
                                                            backgroundColor: Colors.white,
                                                            radius: 40.0,
                                                            
                                                              child: 
                                                                        CircleAvatar(
                                                                        child: Image.asset('assets/23.webp'),
                                                                            backgroundColor: Colors.white,
                                                                            radius: 30.0,
                                                                        ),
                                              //  backgroundColor: Colors.white,


                                              
                                                                ),
                                                          )

                                          :

                                                       _videoPlayerController.value.initialized
                                                      ? AspectRatio(
                                                          aspectRatio: _videoPlayerController.value.aspectRatio,
                                                          child: VideoPlayer(_videoPlayerController),
                                                      )
                                                      : Container(),
                                                      
                                                       Positioned(
                                                                      top: -(radius + iconSize + distance),
                                                                      right: 0,
                                                                      bottom: radius,
                                                                      left: 0,
                                                                      child:  IconButton(
                                                                              icon: Icon(Icons.delete),
                                                                              onPressed: () async {
                                                                                setState(() {});
                                                                                        try {
                                                                                      
                                                                                          await _video.delete();
                                                                                        // files=null ;
                                                                                          print('Deleted video');
                                                                                          print('IMPRIMO video' +_video.toString());
                                                                                        // setState(() {});

                                                                                        } catch (e) {

                                                                                          _video=null ;
                                                                                          print('Couldnt delete video');
                                                                                          print('IMPRIMO video' +
                                                                                          _video.toString());
                                                                                      
                                                                                        }

                                                                              }
                                                                        /*Icon(
                                                                        Icons.delete_forever,
                                                                        color: Colors.grey,
                                                                        size: iconSize,
                                                                        */
                                                              )),
                                                            
                        

                
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Aceptar'),
                onPressed: () {
                          setState(() {});
                  //aqui deberia hacer las cosas de meter en la lista la cosa que se haya elegido y tal
                  //y un set state
                  Navigator.of(context).pop();
                        setState(() {});
                },
              ),
            ],
          );}
          );
        },
      );
    }

    final adjuntar = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Color(0xff01A0C7),
        child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () async {
              _showMyDialog();
            },
            child: Text("Mandar adjunto",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold))));

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
            },
            child: Text("Mandar mensaje",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold))));

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
                          MyTextFormField(
                            hintText: 'Escribe mensaje',
                            text: 'Escribe una respuesta',
                            onSaved: (String value) {
                              mensaje = value;
                            },
                          ),
                          enviarMensaje,
                          adjuntar,
                        ])))));
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

