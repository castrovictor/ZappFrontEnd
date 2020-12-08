import 'package:flutter/material.dart';

class Perfil extends StatelessWidget {
  Perfil(this.nombre, this.email, this.codigo);
  String nombre;
  String email;
  String fechaNacimiento;
  String codigo;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // backgroundColor: Colors.blue[300],
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/persona.png'),
                ),
                Text(
                  'Perfil de usuario',
                  style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontSize: 30,
                  ),
                ),
                Text(
                  'Bienvenido',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'SourceSansPro',
                    color: Colors.blue[400],
                    letterSpacing: 2.5,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                  width: 200,
                  child: Divider(
                    color: Colors.teal[100],
                  ),
                ),
                Card(
                    color: Colors.white,
                    margin:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                    child: ListTile(
                      //leading: Icon (icono al principio
                      trailing: Icon(
                        Icons.person,
                        color: Colors.teal[900],
                        size: 50.0,
                      ),
                      title: Text(
                        nombre,
                        style:
                            TextStyle(fontFamily: 'BalooBhai', fontSize: 25.0),
                      ),
                    )),
                Card(
                  color: Colors.white,
                  margin:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  child: ListTile(
                    trailing: Icon(
                      Icons.cake,
                      color: Colors.teal[900],
                      size: 50.0,
                    ),
                    title: Text(
                      codigo,
                      style: TextStyle(fontSize: 30.0, fontFamily: 'Neucha'),
                    ),
                  ),
                ),
                Card(
                  color: Colors.white,
                  margin:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  child: ListTile(
                    trailing: Icon(
                      Icons.cake,
                      color: Colors.teal[900],
                      size: 50.0,
                    ),
                    title: Text(
                      fechaNacimiento,
                      style: TextStyle(fontSize: 30.0, fontFamily: 'Neucha'),
                    ),
                  ),
                ),
                /* Card(
                    color: Colors.white,
                    margin:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                    child: ListTile(
                      //leading: Icon (icono al principio
                      trailing: Icon(
                        Icons.phone,
                        color: Colors.teal[900],
                        size: 50.0,
                      ),
                      title: Text(
                        'Número de teléfono',
                        style:
                            TextStyle(fontFamily: 'BalooBhai', fontSize: 25.0),
                      ),
                    )),*/
                Card(
                    color: Colors.white,
                    margin:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                    child: ListTile(
                      //leading: Icon (icono al principio
                      trailing: Icon(
                        Icons.person_outline,
                        color: Colors.teal[900],
                        size: 50.0,
                      ),
                      title: Text(
                        'Nombre coordinador',
                        style:
                            TextStyle(fontFamily: 'BalooBhai', fontSize: 25.0),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
