import 'package:flutter/material.dart';
import 'mandar.dart';
import 'myTextFormField.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/widgets.dart';
import 'filepickerdemo.dart';
import 'package:flutter/widgets.dart';


import 'pdf.dart';

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
    List<File> files ;
    File file ;
    //****************************************ARCHIVOS******************* */
    
    MyPDFList pdf ;


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
    var file = null;
    //Botón crear
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyApp(
                          nombre: nombre,
                          descripcion: descripcion,
                          usuarios: widget.usuarios,
                          codigos: widget.codigos)));
            }

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
                                                      ? Text('No file selected.')
                                                    //  : Image.file(files.first)
                                                  : // ListView(
                                                    Card(
                                                                      child:ListTile(
                                                                        title: Text(files[0].path.split('/').last),
                                                                        leading: Icon(Icons.picture_as_pdf),
                                                                         trailing: IconButton(
                                                                             icon: Icon(Icons.delete),

                                                                             //Borrar archivo
                                                                                     onPressed: () async {


                                                                                   //    Future<int> deleteFile() async {
                                                                                              try {
                                                                                               //files[0] = await _localFile;

                                                                                                //await files[0].delete();
                                                                                               files[0].delete();
                                                                                                print('Deleted');
                                                                                              } catch (e) {
                                                                                                  print('Couldnt delete');
                                                                                                return 0;
                                                                                              }
                                                                                            
                                                                                      //    file[0]=null ;
                                                                                     }
                                                                         ),
                                                                       // trailing: Icon(Icons.arrow_forward, color: Colors.redAccent,),
                                                                        onTap: (){
                                                                          Navigator.push(context, MaterialPageRoute(builder: (context){
                                                                            return ViewPDF(pathPDF:files[0].path.toString());
                                                                            //open viewPDF page on click
                                                                          }));
                                                                        },
                                                                      
                                                                      )
                                                    ),
                                             
                                                    
                                                  
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
                                                      
                                                      FilePickerResult result = await FilePicker.platform.pickFiles(allowMultiple: true);

                                                                    if(result != null) {
                                                                      //   List<File> files = result.paths.map((path) => File(path)).toList();
                                                                    files = result.paths.map((path) => File(path)).toList();
                                                                    } else {
                                                                      // User canceled the picker
                                                                    }


                                                          
                                                        
                                                    //***************************************ARCHIVOOOOOO**********************************************////

                                                  },
                                                ),

                                                title: Text(
                                                  '  ',
                                                  style: TextStyle(
                                                      fontFamily: 'BalooBhai', fontSize: 20.0),
                                                ),
                                              ),

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
                      
                      ])
                  ),
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
                                      backgroundColor: Colors.black,
                                      radius: 40.0,
                                      child: CircleAvatar(
                                        radius: 39.0,
                                        child: CircleAvatar(
                                          
                                          child: (_image != null)
                                          ? Image.file(_image)
                                          : Text('   Añadir  \n     imagen')
                                        ),
                                        backgroundColor: Colors.white,
                                      ),
                                    ),
                     ),
                    /*
                  ListView(
                        //Imprimir imagen
                     //   radius: 55,
                    //    backgroundColor: Color(0xffFDCF09),
                       child: files == null? Text("Searching Files"):
                                    ListView.builder(  //if file/folder list is grabbed, then show here
                                        itemCount: files?.length ?? 0,
                                        //Size of each child
                                      //    itemExtent: 100,
                                        itemBuilder: (context, index) {
                                          return   Card(
                                                  child: ListTile(
                                                    leading: FlutterLogo(size: 56.0),
                                                    title: Text('Two-line ListTile'),
                                                    subtitle: Text('Here is a second line'),
                                                    trailing: Icon(Icons.more_vert),
                                                  )
                                          );
                                                /*
                                              return Card(
                                                // height: 100.0,
                                                child:ListTile(
                                                  
                                                  title: Text(files[index].path.split('/').last),
                                                  leading: Icon(Icons.picture_as_pdf),
                                                  trailing: Icon(Icons.arrow_forward, color: Colors.redAccent,),
                                                  //Ver el pdf
                                                  onTap: (){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                                      return ViewPDF(pathPDF:files[index].path.toString());
                                                      //open viewPDF page on click
                                                    }));
                                                  },
                                                )
                                              );
                                                */
                                        },
                                    )
                          /*files == null
                            //  ? Text('No image selected.')
                            ? Text('No file selected.')
                          //  : Image.file(files.first)
                        :Text(files.first.toString())
                        */
                        /*
                              child: file != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.file(
                                       _image,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.circular(50)),
                                      width: 100,
                                      height: 100,
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                */
                     ),
                    */
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
