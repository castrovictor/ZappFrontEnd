import 'package:flutter/material.dart';
import 'mandar.dart';
import 'myTextFormField.dart';

class CrearTarea extends StatelessWidget {
  CrearTarea();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String nombre;
  String descripcion;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyApp(nombre: nombre)));
          }
        },
        child: Text("Crear",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
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
                        )),
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
