import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'tarea.dart';
import 'myTextFormField.dart';
import 'pdf.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

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
List<File> imgs = new List<File>();
List<File> fs = new List<File>();
List<File> vd = new List<File>();

List<String> imagenes = new List<String>();
List<String> videos = new List<String>();
List<String> archivos = new List<String>();

class MensajeWidget extends StatelessWidget {
  MensajeWidget(
      {this.iconData,
      this.texto,
      this.onPressed,
      this.f,
      this.im,
      this.v,
      this.tutor});

  /// icon data
  final IconData iconData;

  File file;
  File fimage;
  File fvideo;

  final bool tutor;

  /// texto to show
  final String texto;

  final String f;
  final String im;
  final String v;

  /// Airport to show
  final VoidCallback onPressed;

  final picker = ImagePicker();
  //comprobar que f!=''

  @override
  Widget build(BuildContext context) {
    print("texto: " + texto);
    print("imagen: " + im + "bool " + im != '');
    //  getFile() ;
    //   getImage();
    _showImageDialog( String url ) {
      showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          //  title: new Text("Material Dialog"),
          //   content: new Text("Hey! I'm Coflutter!"),
          actions: <Widget>[
            //Aquí mandamos al url de la imagen
            Image.network(url),
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                //aqui deberia hacer las cosas de meter en la lista la cosa que se haya elegido y tal
                //y un set state
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }

    print("imagen2: " + im + "bool222222 " + im != '');
    return InkWell(
      onTap: onPressed,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                (() {
                  print('IMPRIMO RUTA IMAGEN' + im.toString());
                  print('IMPRIMO RUTA IMAGEN' + texto);
                  if (texto != '') {
                    return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: MediaQuery.of(context).size.height * 0.075,
                        child: ColoredBox(
                          color: Colors.lightBlue[50],
                          // child: Center(
                          //poner mensaje dependiendo de si es de tutor
                          //Distinguir si el contenido es nulll

                          child: Text(
                              'Mensaje de ' +
                                  (tutor ? 'tutor: ' : 'socio: ') +
                                  texto,
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)),
                        ));
                  } else if (im != '') {
                    return InkWell(
                      onTap: () {
                                                     _showImageDialog( 'http://zapp.pythonanywhere.com' + im ) ;

                                                },
                        child: InkWell(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 40.0,

                        child: CircleAvatar(
                          child: Image.network(
                              'http://zapp.pythonanywhere.com' + im),
                          backgroundColor: Colors.white,
                          radius: 50.0,
                        ),
                        //  backgroundColor: Colors.white,
                      ),
                    ));
                    /*
                            return InkWell(
                                           
                                      child:   InkWell(
                                                onTap: () {
                                                     _showImageDialog() ;

                                                },
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 40.0,
                                              
                                                child: CircleAvatar(
                                                  
                                                    child:
                                                         Image.asset('assets/gal.png'),
                                                        backgroundColor: Colors.white,
                                                        radius: 50.0,
                                                    ),
                                              //  backgroundColor: Colors.white,


                                              
                                            ),
                                          )
                                        );
                                      */

                  } else if (f != '') {
                    print("IMPRIMO RUTA DE ARCHIVO EN MENSAJE " + f);
                    //getFile();

                    return Card(
                        child: ListTile(
                      title: Text(file.path.split('/').last),
                      leading: Icon(Icons.picture_as_pdf),

                      // trailing: Icon(Icons.arrow_forward, color: Colors.redAccent,),

                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ViewPDF(pathPDF: file.path.toString());
                          //open viewPDF page on click
                        }));
                      },
                    ));
                  } else {
                    return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: MediaQuery.of(context).size.height * 0.075,
                        child: ColoredBox(
                          color: Colors.lightBlue[50],
                          // child: Center(
                          //poner mensaje dependiendo de si es de tutor
                          //Distinguir si el contenido es nulll

                          child: Text('NADA',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)),
                        ));
                  }
                }()),

                /*
                     SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            height: MediaQuery.of(context).size.height * 0.075,
                            child: ColoredBox(
                              color: Colors.lightBlue[50],
                              // child: Center(
                              //poner mensaje dependiendo de si es de tutor
                              //Distinguir si el contenido es nulll
                          
                              child: Text('NADA',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)
                              ),
                            )
                          ),
                          */
                /*,
                        InkWell(
                                           
                                      child:   InkWell(
                                                onTap: () {
                                                     _showImageDialog() ;

                                                },
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 40.0,
                                              
                                                child: CircleAvatar(
                                                  
                                                    child:
                                                         Image.asset('assets/gal.png'),
                                                        backgroundColor: Colors.white,
                                                        radius: 50.0,
                                                    ),
                                              //  backgroundColor: Colors.white,


                                              
                                            ),
                                          )
                          )
                          */

                /*
                        f!='' ? 
                                  /* 
                                      (() {
                                          getFile() ;
                                          print("Cojo archivo");
                                        }());
                                        */
                                   Card(
                                        color: Colors.white,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 25.0),
                                        child: Column(

                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              /*FUNCIONA PARA UN ARCHIVO*/
                                                  
                                                  Card(
                                                      
                                                      child: ListTile(
                                                      title:
                                                          Text(files[0].path.split('/').last),
                                                      leading: Icon(Icons.picture_as_pdf),
                                                    
                                                      onTap: () {
                                                          /*
                                                          setState(() {});
                                                            setState(() {
                                                       // contentText = "Changed Content of Dialog";
                                                    });*/
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
                                            
                                            

                                              /*
                                                    
                                                title: Text(
                                                  '  ',
                                                  style: TextStyle(
                                                      fontFamily: 'BalooBhai', fontSize: 20.0),
                                                ),
                                                

                                              ),*/

                                          
                                            ]
                                          )
                                        )
                                     //   }())
                                        
                        :
                                    SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.75,
                                          height: MediaQuery.of(context).size.height * 0.075,
                                          child: ColoredBox(
                                            color: Colors.lightBlue[50],
                                            // child: Center(
                                            //poner mensaje dependiendo de si es de tutor
                                            //Distinguir si el contenido es nulll
                                        
                                            child: Text(texto,
                                                style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold)
                                            ),
                                          )
                                        )

                                        /*
                                              Text(texto,
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)
                                      */
                           //   )
                                    */

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
  http.Response response = await http.get(
    url,
    headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
    },
  );

  final jsonResponse = await jsonDecode(response.body);
  print(jsonResponse);
  print(jsonResponse['Adjuntado']);

  tutor.clear();
  mensajes.clear();
  imagenes.clear();
  videos.clear();
  archivos.clear();


  if (jsonResponse.containsKey("Adjuntado")) {
    for (int i = 0; i < jsonResponse['Adjuntado'].length; i++) {
      print('tutor:' + jsonResponse['Adjuntado'][i]['is_staff'].toString());
      print( 'comentario' + jsonResponse['Adjuntado'][i]['comentario'].toString());
      print('imagen de get mensaje :' + jsonResponse['Adjuntado'][i]['imagen'].toString());


      
      if (jsonResponse['Adjuntado'][i]['is_staff'].toString() == 'false') {
        tutor.add(false);
      } else
        tutor.add(true);


      if (jsonResponse['Adjuntado'][i]['comentario'].toString() != '') {
        print(
            "holaaa:" + jsonResponse['Adjuntado'][i]['comentario'].toString());
        mensajes.add(jsonResponse['Adjuntado'][i]['comentario'].toString());
        imagenes.add('');
        videos.add('');
        archivos.add('');
      } else if (jsonResponse['Adjuntado'][i]['imagen'].toString() != '') {
        print("AÑADO IMAGENNNNNNNNNNNN " +
            jsonResponse['Adjuntado'][i]['imagen'].toString());
     imagenes.add(jsonResponse['Adjuntado'][i]['imagen'].toString());
        mensajes.add('');
        videos.add('');
        archivos.add('');
      }

    }
  }
}
/*if (jsonResponse.containsKey('Adjuntado')) {
    for (int i = 0; i < jsonResponse['Adjuntado'].length; i++) {
      mensajes.add(jsonResponse['Adjuntado'][i]['comentario']);
      if (jsonResponse['Adjuntado'][i]['is_staff']) {
        tutor.add('true');
      } else {
        tutor.add('false');
      }
    }*/

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
  bool si = false;
  bool sv = false;
  bool sf = false;

/************************************************************************************************ */
  //*******************************+IMAGENES */

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    //   final pickedFile = await picker.getImage(source: ImageSource.gallery);
    File f = await ImagePicker.pickImage(source: ImageSource.gallery);
/*
    setState(() {
      _image = File(pickedFile.path);
      si=true ;
      
    });
      setState(() {});
     */
    setState(() {
      // _image = File(pickedFile.path);
      _image = f;
    });
  }
  //*****************IMAGENES**************************************/ */

  //*************************************ARCHIVOS********************** */
  List<File> files;
  File file;
  //****************************************ARCHIVOS******************* */

  /******************************************VIDEOO****************************** */
  File _video = null;
  VideoPlayerController _videoPlayerController;

/************************************************************************************************ */

// This funcion will helps you to pick a Video File

  _pickVideo() async {
    /*
          sv=true ;
      setState(() {});
      PickedFile pickedFile = await picker.getVideo(source: ImageSource.gallery);
      _video = File(pickedFile.path); 
      _videoPlayerController = VideoPlayerController.file(_video)..initialize().then((_) {
        setState(() {sv=true ; });
        _videoPlayerController.play();
      });
      sv=true ;
        setState(() {});
        */
    //PickedFile pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    File f = await ImagePicker.pickVideo(source: ImageSource.gallery);
    //_video = File(pickedFile.path);
    _video = f;
    //print('url de video: ' + pickedFile.path);
    _videoPlayerController = VideoPlayerController.file(_video)
      ..initialize().then((_) {
        setState(() {});
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
    sv = false;
    si = false;
    sf = false;

    Future<void> _showMyDialog() async {
      setState(() {});

      return showDialog<void>(
        context: context,
        builder: (context) {
          String contentText = "Content of Dialog";

          return StatefulBuilder(builder: (context, setState) {
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
                                              sf = false;
                                              contentText =
                                                  "Changed Content of Dialog";
                                            });
                                            try {
                                              await files.first.delete();
                                              files = null;
                                              sf = false;
                                              print('Deleted');
                                              print('IMPRIMO URL' +
                                                  files.first.toString());
                                              setState(() {});
                                            } catch (e) {
                                              sf = false;
                                              files = null;
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
                                          contentText =
                                              "Changed Content of Dialog";
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
                                    )),
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

                                      sf = true;

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
                      onTap: () async {
                        setState(() {});
                        getImage();
                        si = true;
                        print('IMPRIMO image elegida ' + _image.toString());
                        getImage();
                        setState(() {});
                      },
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
                        child: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              setState(() {});
                              try {
                                await _image.delete();
                                // files=null ;
                                print('Deleted image');
                                print('IMPRIMO image' + _image.toString());
                                // setState(() {});
                                si = false;
                              } catch (e) {
                                _image = null;
                                print('Couldnt delete image');
                                print('IMPRIMO image' + _image.toString());
                                si = false;
                              }
                              setState(() {});
                            })),

                    /***********************************************************************************IMAGEN*******************************+ */

                    _video == null
                        ? //SELECCIONAR
                        InkWell(
                            onTap: _pickVideo,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 40.0,

                              child: CircleAvatar(
                                child: Image.asset('assets/23.webp'),
                                backgroundColor: Colors.white,
                                radius: 30.0,
                              ),
                              //  backgroundColor: Colors.white,
                            ),
                          )
                        : _videoPlayerController.value.initialized
                            ? AspectRatio(
                                aspectRatio:
                                    _videoPlayerController.value.aspectRatio,
                                child: VideoPlayer(_videoPlayerController),
                              )
                            : Container(),
                    Positioned(
                        top: -(radius + iconSize + distance),
                        right: 0,
                        bottom: radius,
                        left: 0,
                        child: IconButton(
                            icon: Icon(Icons.delete),
                            //BORRAR
                            onPressed: () async {
                              sv = false;
                              setState(() {
                                sv = false;
                              });
                              try {
                                await _video.delete();
                                // files=null ;
                                print('Deleted video');
                                print('IMPRIMO video' + _video.toString());
                                // setState(() {});
                                sv = false;
                              } catch (e) {
                                _video = null;
                                print('Couldnt delete video');
                                print('IMPRIMO video' + _video.toString());
                                sv = false;
                              }
                              setState(() {});
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
                    setState(() {
                      _image != null ? si = true : si = false;
                      _video != null ? sv = true : sv = false;
                      files != null ? sf = true : sf = false;
                    });
                    //aqui deberia hacer las cosas de meter en la lista la cosa que se haya elegido y tal
                    //y un set state
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                ),
              ],
            );
          });
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
              await _showMyDialog();

              if (si == true) {
                var uri = Uri.parse('http://zapp.pythonanywhere.com/subir/');
                var request = http.MultipartRequest('PUT', uri)
                  ..fields['idActividad'] = widget.idActividad
                  ..fields['is_staff'] = 'false'
                  ..files.add(await http.MultipartFile.fromPath(
                      'imagen', _image.path,
                      contentType: MediaType('application', 'udefined')));

                var response = await request.send();
                if (response.statusCode == 200) print('Uploaded!');
              }

              si = false;
              sv = false;
              sf = false;
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

                var uri = Uri.parse('http://zapp.pythonanywhere.com/subir/');
                var request = http.MultipartRequest('PUT', uri)
                  ..fields['comentario'] = mensaje
                  ..fields['idActividad'] = widget.idActividad
                  ..fields['is_staff'] = 'false';

                var response = await request.send();
                if (response.statusCode == 200) print('Uploaded!');
                print(await response.stream.transform(utf8.decoder).join());
              }
              _formKey.currentState.reset();
            },
            child: Text("Mandar mensaje",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold))));

    Timer(Duration(milliseconds: 500), () {
      setState(() {
        if (!mounted) return;
        getMensajes(widget.idActividad);
      });
    });
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
                              MensajeWidget(
                                iconData: Icons.pending_actions_rounded,
                                texto: mensajes[i],
                                im: imagenes[i],
                                v: videos[i],
                                f: archivos[i],
                                tutor: tutor[i],
                                onPressed: () async {},
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
