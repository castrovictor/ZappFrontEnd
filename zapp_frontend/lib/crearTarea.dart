import 'package:flutter/material.dart';
import 'perfil.dart';
<<<<<<< HEAD

=======
>>>>>>> 3fbd7563439f5a24531f382649c5450c9711fd31
class CrearTarea extends StatelessWidget {
  CrearTarea();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
<<<<<<< HEAD
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
=======
        appBar: AppBar(
          /*
          title: Text(
            "Administración ",
            style: TextStyle(fontSize: 18.0),
          ),*/
        ),
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
                    letterSpacing:2.5,

                  ),
                ),


            Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                  children: <Widget>[


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
                      margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                      child: ListTile(

                        title: Text(
                          '  ',
                          style: TextStyle(fontSize: 20.0, fontFamily: 'Neucha'),
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
                        margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                        child: ListTile(

                          //leading: Icon (icono al principio

                          title: Text(
                            '  ',
                            style:
                            TextStyle(fontFamily: 'BalooBhai', fontSize: 80.0),
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
                        margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                        child: ListTile(

                          //leading: Icon (icono al principio
                          trailing: Icon(
                            Icons.attach_file,
                            color: Colors.teal[900],
                          ),
                          title: Text(
                            '  ',
                            style:
                            TextStyle(fontFamily: 'BalooBhai', fontSize: 20.0),
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
                        margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                        child: ListTile(

                          //leading: Icon (icono al principio
                          trailing: Icon(
                            Icons.assignment_ind_rounded,
                            color: Colors.teal[900],
                          ),
                          title: Text(
                            ' ',
                            style:
                            TextStyle(fontFamily: 'BalooBhai', fontSize: 80.0),
                          ),
                        )),
                  //márgenes
                    const SizedBox(height: 20),
                    RaisedButton(
                      onPressed: () {},
                      child: const Text('Crear tarea', style: TextStyle(fontSize: 20)),
                    ),
                    const SizedBox(height: 50)

            ]),
          ),



              ],
            ),
          ),
          ),
>>>>>>> 3fbd7563439f5a24531f382649c5450c9711fd31
        ),
      ),
    );
  }
}
