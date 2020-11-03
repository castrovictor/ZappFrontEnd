import 'package:flutter/material.dart';

class SubPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub Page'),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Click button to back to Main Page'),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.redAccent,
              child: Text('Back to Main Page'),
              onPressed: () {
                // AQUI SE QUITA ESTA PANTALLA Y SE VUELVE A LA DE ANTES 
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}