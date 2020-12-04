import 'package:flutter/material.dart';

class MenuVoluntario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú'),
      ),
      body: Center(
        child: new Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            new Container(
              child: RaisedButton(
                child: Text('Perfil'),
                onPressed: () {},
              ),
              alignment: Alignment.topRight,
              height: 60.0,
              width: 300.0,
            ),
            new Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () => {},
                    color: Colors.lightBlue,
                    padding: EdgeInsets.all(40.0),
                    child: Column(
                      // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Icon(Icons.add_box_rounded),
                        Text("Administrar")
                      ],
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () => {},
                    color: Colors.lightBlue,
                    padding: EdgeInsets.all(40),
                    height: 80.0,
                    child: Column(
                      // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Icon(Icons.account_balance_rounded),
                        Text("Biblioteca")
                      ],
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () => {},
                    color: Colors.lightBlue,
                    padding: EdgeInsets.all(40),
                    height: 80.0,
                    child: Column(
                      // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Icon(Icons.accessibility_new_outlined),
                        Text("Usuarios")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        /*child: RaisedButton(
          child: Text('Volver al login'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        */
      ),
    );
  }
}
