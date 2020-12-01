import 'package:flutter/material.dart';

class PerfilFacilitador extends StatelessWidget {
  PerfilFacilitador();
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
                  radius: 80,
                  backgroundImage: AssetImage('assets/facilitador.png'),
                ),
                Text(
                  'Perfil del Facilitador',
                  style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontSize: 25,
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
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      //leading: Icon (icono al principio
                      trailing: Icon(
                        Icons.person,
                        color: Colors.teal[900],
                      ),
                      title: Text(
                        'Nombre',
                        style:
                            TextStyle(fontFamily: 'BalooBhai', fontSize: 20.0),
                      ),
                    )),
                Card(
                  color: Colors.white,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    trailing: Icon(
                      Icons.cake,
                      color: Colors.teal[900],
                    ),
                    title: Text(
                      'Edad',
                      style: TextStyle(fontSize: 20.0, fontFamily: 'Neucha'),
                    ),
                  ),
                ),
                Card(
                    color: Colors.white,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      //leading: Icon (icono al principio
                      trailing: Icon(
                        Icons.phone,
                        color: Colors.teal[900],
                      ),
                      title: Text(
                        'Número de teléfono',
                        style:
                            TextStyle(fontFamily: 'BalooBhai', fontSize: 20.0),
                      ),
                    )),
                Card(
                    color: Colors.white,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      //leading: Icon (icono al principio
                      trailing: Icon(
                        Icons.email,
                        color: Colors.teal[900],
                      ),
                      title: Text(
                        'Email',
                        style:
                            TextStyle(fontFamily: 'BalooBhai', fontSize: 20.0),
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
