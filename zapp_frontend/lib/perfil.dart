import 'package:flutter/material.dart';

class Perfil extends StatelessWidget {
  Perfil();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
<<<<<<< HEAD
        // backgroundColor: Colors.blue[300],
=======
        appBar: AppBar(
          title: Text(
            "Perfil de usuario ",
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        backgroundColor: Colors.blue[300],
>>>>>>> 3fbd7563439f5a24531f382649c5450c9711fd31
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
<<<<<<< HEAD
                CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('assets/persona.png'),
                ),
=======

                CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('assets/user-150x150.png'),
                ),

>>>>>>> 3fbd7563439f5a24531f382649c5450c9711fd31
                Text(
                  'Perfil de usuario',
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
<<<<<<< HEAD
                    color: Colors.blue[400],
=======
                    color: Colors.red[400],
>>>>>>> 3fbd7563439f5a24531f382649c5450c9711fd31
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
<<<<<<< HEAD
                Card(
                    color: Colors.white,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
=======



                Card(
                    color: Colors.white,
                    margin:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(

>>>>>>> 3fbd7563439f5a24531f382649c5450c9711fd31
                      //leading: Icon (icono al principio
                      trailing: Icon(
                        Icons.phone,
                        color: Colors.teal[900],
                      ),
                      title: Text(
                        'Nombre',
                        style:
<<<<<<< HEAD
                            TextStyle(fontFamily: 'BalooBhai', fontSize: 20.0),
=======
                        TextStyle(fontFamily: 'BalooBhai', fontSize: 20.0),
>>>>>>> 3fbd7563439f5a24531f382649c5450c9711fd31
                      ),
                    )),
                Card(
                  color: Colors.white,
                  margin:
<<<<<<< HEAD
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
=======
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
>>>>>>> 3fbd7563439f5a24531f382649c5450c9711fd31
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
<<<<<<< HEAD
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
=======
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(

>>>>>>> 3fbd7563439f5a24531f382649c5450c9711fd31
                      //leading: Icon (icono al principio
                      trailing: Icon(
                        Icons.phone,
                        color: Colors.teal[900],
                      ),
                      title: Text(
                        'Numero de telefono',
                        style:
<<<<<<< HEAD
                            TextStyle(fontFamily: 'BalooBhai', fontSize: 20.0),
=======
                        TextStyle(fontFamily: 'BalooBhai', fontSize: 20.0),
>>>>>>> 3fbd7563439f5a24531f382649c5450c9711fd31
                      ),
                    )),
                Card(
                    color: Colors.white,
                    margin:
<<<<<<< HEAD
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
=======
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(

>>>>>>> 3fbd7563439f5a24531f382649c5450c9711fd31
                      //leading: Icon (icono al principio
                      trailing: Icon(
                        Icons.phone,
                        color: Colors.teal[900],
                      ),
                      title: Text(
                        'Nombre coordinador',
                        style:
<<<<<<< HEAD
                            TextStyle(fontFamily: 'BalooBhai', fontSize: 20.0),
=======
                        TextStyle(fontFamily: 'BalooBhai', fontSize: 20.0),
>>>>>>> 3fbd7563439f5a24531f382649c5450c9711fd31
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
<<<<<<< HEAD
=======

>>>>>>> 3fbd7563439f5a24531f382649c5450c9711fd31
  }
}
