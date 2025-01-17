import 'package:flutter/material.dart';
import 'mandar.dart';
import 'myTextFormField.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'filepickerdemo.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import 'pdf.dart';

List<String> grupos = new List<String>();

class CrearTarea extends StatefulWidget {
  CrearTarea({this.usuarios, this.codigos});
  List<String> usuarios;
  List<String> codigos;

  @override
  _CrearTarea createState() => _CrearTarea();
}

class _CrearTarea extends State<CrearTarea> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String nombre;
  String descripcion;
  final _formKey = GlobalKey<FormState>();
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

// This funcion will helps you to pick a Video File
  _pickVideo() async {
    PickedFile pickedFile = await picker.getVideo(source: ImageSource.gallery);
    String new_path =
        pickedFile.path.substring(0, pickedFile.path.length - 3) + 'mp4';
    _video = File(pickedFile.path);
    print("url del video es:" + new_path + "pero " + pickedFile.path);
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

  //**************************************************************************************************** */

  @override
  Widget build(BuildContext context) {
    double radius = 40;
    double iconSize = 40;
    double distance = 10;
    var file = null;
    //Botón crear

    Future getGrupos() async {
      String url = 'http://zapp.pythonanywhere.com/grupos/';
      print(url);
      http.Response response = await http.get(
        url,
        headers: {
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      grupos.clear();
      for (int i = 0; i < jsonResponse['grupos'].length; i++) {
        grupos.add(jsonResponse['grupos'][i]);
      }
      for (int i = 0; i < grupos.length; i++) {
        print(grupos[i]);
        //print(codigos[i]);
      }
    }

    final crear = Material(
        borderRadius: BorderRadius.circular(30.0),
        color: Color(0xff01A0C7),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          child: Text("Crear",
              textAlign: TextAlign.center,
              style: style.copyWith(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();

              //const url = 'https://pythoneverywhere/alta_socio';
              //await http.post(url,
              //    body: jsonEncode(<String, String>{
              //      'nombre': model.nombre,
              //    }));
              print(nombre);
              print(widget.codigos.length);
              String imagen;
              String fichero;
              String video;
              if (_image != null) {
                imagen = _image.path;
              } else {
                imagen = 'no';
              }
              if (_video != null) {
                video = _video.toString();
              } else {
                video = 'no';
              }
              if (file != null) {
                fichero = file[0].path;
              } else {
                fichero = 'no';
              }
              await getGrupos();
              print(grupos.length);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyApp(
                          nombre: nombre,
                          descripcion: descripcion,
                          usuarios: widget.usuarios,
                          codigos: widget.codigos,
                          imagen: imagen,
                          video: video,
                          file: fichero,
                          grupos: grupos)));
            }

            /*var res = await uploadImage(
                file.path, "http://zapp.pythonanywhere.com/crearActividad/");
            //  setState() {
            state = res;
            print(res);
            print('COJO IMAGEN');*/
            //         }

            //**************************************************************************************************** */
            /*
        child: Text("Crear",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold));
                */
          },
        ));

    return MaterialApp(
        home: Scaffold(
            //backgroundColor: Colors.blue[300],
            body: Padding(
      padding: const EdgeInsets.all(36.0),
      child: Center(
        child: Form(
            key: _formKey,
            child: new SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Crear tarea',
                      style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontSize: 40,
                        letterSpacing: 2.5,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    MyTextFormField(
                      hintText: 'Nombre de tarea',
                      text: 'Nombre de tarea',
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Introduce un nombre';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        nombre = value;
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    MyTextFormField(
                      hintText: 'Descripcion',
                      text: 'Descripcion',
                      onSaved: (String value) {
                        descripcion = value;
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Adjuntos',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),

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
                                            try {
                                              await files.first.delete();
                                              // files=null ;
                                              print('Deleted');
                                              print('IMPRIMO URL' +
                                                  files.first.toString());
                                              // setState(() {});

                                            } catch (e) {
                                              files = null;
                                              print('Couldnt delete');
                                              print('IMPRIMO URL' +
                                                  files.first.toString());
                                            }
                                            //   setState(() {});

                                            //    file[0]=null ;
                                          }),
                                      // trailing: Icon(Icons.arrow_forward, color: Colors.redAccent,),
                                      onTap: () {
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

                              /****************************VARIOS ARCHIVOS NO FUNCIONA*************** */
                              /*
                                                      //  ? Text('No image selected.')
                                                      ? Text('No file selected.')
                                                    //  : Image.file(files.first)

                                                  :
                                                  Expanded(
                                                    child: SizedBox(
                                                        height: 200.0,
                                                        child: new ListView.builder(  //if file/folder list is grabbed, then show here
                                                               scrollDirection: Axis.horizontal,
                                                              itemCount: files?.length ?? 0,
                                                              itemBuilder: (context, index) {
                                                                    Card(
                                                                      child:ListTile(
                                                                        title: Text(files[index].path.split('/').last),
                                                                        leading: Icon(Icons.picture_as_pdf),
                                                                        trailing: Icon(Icons.arrow_forward, color: Colors.redAccent,),
                                                                        onTap: (){
                                                                          Navigator.push(context, MaterialPageRoute(builder: (context){
                                                                            return ViewPDF(pathPDF:files[index].path.toString());
                                                                            //open viewPDF page on click
                                                                          }));
                                                                        },
                                                                      )
                                                                    );
                                                              },
                                                          ),

                                                    ),
                                                  )

                                                */

                              //   ),
                              /*
                                                                        
                                                  files == null? Text("Searching Files"):
                                                          ListView.builder(  //if file/folder list is grabbed, then show here
                                                              itemCount: files?.length ?? 0,
                                                              itemBuilder: (context, index) {
                                                                    return Card(
                                                                      child:ListTile(
                                                                        title: Text(files[index].path.split('/').last),
                                                                        leading: Icon(Icons.picture_as_pdf),
                                                                        trailing: Icon(Icons.arrow_forward, color: Colors.redAccent,),
                                                                        onTap: (){
                                                                          Navigator.push(context, MaterialPageRoute(builder: (context){
                                                                            return ViewPDF(pathPDF:files[index].path.toString());
                                                                            //open viewPDF page on click
                                                                          }));
                                                                        },
                                                                      )
                                                                    );
                                                              },
                                                          ),

                                                  */

                              ListTile(
                                //leading: Icon (icono al principio

                                //BOTON ADJUNTAR IMAGEN
                                trailing: IconButton(
                                  icon: Icon(Icons.attach_file),
                                  onPressed: () async {
                                    /*
                                                    //Para añadir IMAGEN
                                                    //*************************************IMAGENN***************************************** */
                                                    // file = await ImagePicker.pickImage(source: ImageSource.gallery);
                                                    /*
                                                                  file = await picker.getImage(source: ImageSource.gallery);
                                                                  var res = await uploadImage(file.path, "http://zapp.pythonanywhere.com/crearActividad/");
                                                                      //  setState() {
                                                                            state = res;
                                                                          print(res);
                                                                          print('COJO IMAGEN');
                                                              //         }
                                                              */

                                                      //Lo que sirve si queremos imageeeen
                                                    final pickedFile = await picker.getImage(
                                                        source: ImageSource.gallery);

                                                    print(pickedFile);
                                                    if (pickedFile != null) {
                                                      _image = File(pickedFile.path);
                                                      print('COGIDO');
                                                      print(_image);
                                                    } else {
                                                      print('No image selected.');
                                                    }
                                                    */
                                    //*************************************IMAGENN***************************************** */
                                    //**************************************************************************************************** */

                                    //***************************************ARCHIVOOOOOO**********************************************////

                                    /*
                                                          FilePickerResult result = await FilePicker.platform.pickFiles(allowMultiple: true);

                                                          if(result != null) {
                                                                  files = result.paths.map((path) => File(path)).toList();
                                                                    PlatformFile file = result.files.first;
                        
                                                                        print(file.name);
                                                                        print(file.bytes);
                                                                        print(file.size);
                                                                        print(file.extension);
                                                                        print(file.path);
                                                          } else {
                                                            // User canceled the picker
                                                          }
                                                            */
                                    //return new FilePickerDemo() ;

                                    // ****************UN SOLO ARCHIVO************************//

                                    /*
                                                        FilePickerResult result = await FilePicker.platform.pickFiles();

                                                                    if(result != null) {
                                                                      file = File(result.files.single.path);
                                                                      print('Archivo cargado  : '+file.toString()) ;
                                                                    } else {
                                                                      // User canceled the picker
                                                                    }
                                                        */
                                    /*
                                                                        if(result != null) {
                                                                                  PlatformFile file = result.files.first;
                                                                                  
                                                                                  print(file.name);
                                                                                  print(file.bytes);
                                                                                  print(file.size);
                                                                                  print(file.extension);
                                                                                  print(file.path);
                                                                          } else {
                                                                                  // User canceled the picker
                                                                          }

                                                            */
                                    //************************************************************ */
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
                    /*
                            files == null? Text("Searching Files"):
                                  ListView.builder(  //if file/folder list is grabbed, then show here
                                      itemCount: files?.length ?? 0,
                                      itemBuilder: (context, index) {
                                            return Card(
                                              child:ListTile(
                                                title: Text(files[index].path.split('/').last),
                                                leading: Icon(Icons.picture_as_pdf),
                                                trailing: Icon(Icons.arrow_forward, color: Colors.redAccent,),
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                                    return ViewPDF(pathPDF:files[index].path.toString());
                                                    //open viewPDF page on click
                                                  }));
                                                },
                                              )
                                            );
                                      },
                                  )
                            ),
                        */
                    /*
                      new Column(
                                children: <Widget>[
                                  new Expanded(
                                      child: new ListView.builder( itemCount: files?.length ?? 0,
                                      itemBuilder: (context, index) {
                                            return Card(
                                              child:ListTile(
                                                title: Text(files[index].path.split('/').last),
                                                leading: Icon(Icons.picture_as_pdf),
                                                trailing: Icon(Icons.arrow_forward, color: Colors.redAccent,),
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                                    return ViewPDF(pathPDF:files[index].path.toString());
                                                    //open viewPDF page on click
                                                  }));
                                                },
                                              )
                                            );
                                      },
                                  )
                                  ),
                                ],
                            ),
                            */
                    // print(_image) ;

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

                              } catch (e) {
                                _image = null;
                                print('Couldnt delete image');
                                print('IMPRIMO image' + _image.toString());
                              }
                            }
                            /*Icon(
                            Icons.delete_forever,
                            color: Colors.grey,
                            size: iconSize,
                            */
                            )),

                    /**************************************VIDEO********************************** */
                    //  (() {
                    _video == null
                        ? InkWell(
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
                            onPressed: () async {
                              setState(() {});
                              try {
                                await _video.delete();
                                // files=null ;
                                print('Deleted video');
                                print('IMPRIMO video' + _video.toString());
                                // setState(() {});

                              } catch (e) {
                                _video = null;
                                print('Couldnt delete video');
                                print('IMPRIMO video' + _video.toString());
                              }
                            }
                            /*Icon(
                                                                        Icons.delete_forever,
                                                                        color: Colors.grey,
                                                                        size: iconSize,
                                                                        */
                            )),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Pictograma',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Card(
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 25.0),
                        child: ListTile(
                          //leading: Icon (icono al principio

                          trailing: Icon(
                            Icons.assignment_ind_rounded,
                            color: Colors.teal[900],
                          ),

                          title: Text(
                            ' ',
                            style: TextStyle(
                                fontFamily: 'BalooBhai', fontSize: 80.0),
                          ),
                        )),
                    /*
                                MaterialButton(
                                            minWidth: MediaQuery.of(context).size.width,
                                            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                            onPressed: () async {
                                              if (_formKey.currentState.validate()) {
                                                _formKey.currentState.save();

                                                //const url = 'https://pythoneverywhere/alta_socio';
                                                //await http.post(url,
                                                //    body: jsonEncode(<String, String>{
                                                //      'nombre': model.nombre,
                                                //    }));
                                                print(nombre);
                                                print(codigos.length);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => MyApp(
                                                            nombre: nombre,
                                                            descripcion: descripcion,
                                                            usuarios: usuarios,
                                                            codigos: codigos)));
                                              }
                                                  //Onpressed IMAGEN FILEPICKER
                                                  //**************************************************************************************************** */
                                                  
                                              var file = await ImagePicker.pickImage(source: ImageSource.gallery);
                                              var res = await uploadImage(file.path, "http://zapp.pythonanywhere.com/crearActividad/");
                                                  setState() {
                                                      state = res;
                                                    print(res);
                                                  }
                                                  
                                                  
                                                //**************************************************************************************************** */
                                            child: Text("Crear",
                                                textAlign: TextAlign.center,
                                                style: style.copyWith(
                                                    color: Colors.white, fontWeight: FontWeight.bold));
                                            },
                                        
      ),*/
                    crear,

                    const SizedBox(height: 50)
                  ]),
            )),
      ),
    )));
  }
}

/*import 'package:flutter/material.dart';
import 'perfil.dart';

class CrearTarea extends StatelessWidget {
  CrearTarea();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue[300],
        body: SafeArea(
          child: Center(
            child: new SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Crear tarea',
                    style: TextStyle(
                      fontFamily: 'SourceSansPro',
                      fontSize: 40,
                      letterSpacing: 2.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Título',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),

                      Card(
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 25.0),
                        child: ListTile(
                          title: Text(
                            '  ',
                            style:
                                TextStyle(fontSize: 20.0, fontFamily: 'Neucha'),
                          ),
                        ),
                      ),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Descripción',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),

                      Card(
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 25.0),
                          child: ListTile(
                            //leading: Icon (icono al principio

                            title: Text(
                              '  ',
                              style: TextStyle(
                                  fontFamily: 'BalooBhai', fontSize: 80.0),
                            ),
                          )),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Adjuntos',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Card(
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 25.0),
                          child: ListTile(
                            //leading: Icon (icono al principio
                            trailing: Icon(
                              Icons.attach_file,
                              color: Colors.teal[900],
                            ),
                            title: Text(
                              '  ',
                              style: TextStyle(
                                  fontFamily: 'BalooBhai', fontSize: 20.0),
                            ),
                          )),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Pictograma',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Card(
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 25.0),
                          child: ListTile(
                            //leading: Icon (icono al principio
                            trailing: Icon(
                              Icons.assignment_ind_rounded,
                              color: Colors.teal[900],
                            ),
                            title: Text(
                              ' ',
                              style: TextStyle(
                                  fontFamily: 'BalooBhai', fontSize: 80.0),
                            ),
                          )),
                      //márgenes
                      const SizedBox(height: 20),
                      RaisedButton(
                        onPressed: () {},
                        child: const Text('Crear tarea',
                            style: TextStyle(fontSize: 20)),
                      ),
                      const SizedBox(height: 50)
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
*/
