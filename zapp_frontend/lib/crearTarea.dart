import 'package:flutter/material.dart';
import 'mandar.dart';
import 'myTextFormField.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';



class CrearTarea extends StatelessWidget {

  CrearTarea({this.usuarios, this.codigos});
  final List<String> usuarios;
  final List<String> codigos;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String nombre;
  String descripcion;
  final _formKey = GlobalKey<FormState>();



/*

(String filename, String url) async {
  var request = http.MultipartRequest('POST', Uri.parse(url));
  request.files.add(
    http.MultipartFile(
      'picture',
      File(filename).readAsBytes().asStream(),
      File(filename).lengthSync(),
      filename: filename.split("/").last
    )
  );
  var res = await request.send();
}
*/
  

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
  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter File Upload Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(state)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var file = await ImagePicker.pickImage(source: ImageSource.gallery);
          var res = await uploadImage(file.path, widget.url);
          setState(() {
            state = res;
            print(res);
          });
        },
        child: Icon(Icons.add),
      ),
    );
*/


  @override
  Widget build(BuildContext context) {

    //Botón crear
    final crear = Material(
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
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
    
      )
    );




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
                        )
                      ),

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
                                        
      ),
                    crear,
                    
                    const SizedBox(height: 50)
                    
                  ]),
            )),
         ),
       )
        )
    
    );
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
