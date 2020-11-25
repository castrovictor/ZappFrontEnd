import 'package:flutter/material.dart';
import 'tarea.dart';

class TareaWidget extends StatelessWidget {
  TareaWidget({this.iconData, this.title, this.onPressed});

  /// icon data
  final IconData iconData;

  /// Title to show
  final String title;

  /// Airport to show
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.height * 0.075,
                    child: ColoredBox(
                        color: Colors.lightBlue[50],
                        child: Center(
                          child: Text(title,
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)),
                        ))),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.height * 0.075,
                    child: ColoredBox(
                        color: Colors.lightBlue[50],
                        child: Center(child: Icon(iconData, size: 40.0)))),
              ])),
    );
  }
}

// ignore: must_be_immutable
class Deberes extends StatelessWidget {
  Deberes();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 30.0);

  List<int> tareas = [1, 2, 3, 4]; //futura lista de tareas del socio

  @override
  Widget build(BuildContext context) {
    List<int> tareas = [1, 2, 3, 4]; //futura lista de tareas del socio
    return Scaffold(
        /* appBar: AppBar(
          title: Text('Sub Page'),
          backgroundColor: Colors.redAccent,
        ),*/
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Deberes',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 50.0,
                                  fontWeight: FontWeight.bold)),
                          Icon(Icons.pending_actions_rounded, size: 50.0),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.02,
                        //child: const ColoredBox(color: Colors.amber),
                      ),
                      Expanded(
                          child: ListView(children: [
                        for (var i in tareas)
                          TareaWidget(
                            iconData: Icons.sports_bar_rounded,
                            title: "Tarea " + i.toString(),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Tarea(
                                      iconData: Icons.sports_bar_rounded,
                                      title: "Tarea " + i.toString(),
                                      description: "Descripion")));
                            },
                          )
                      ]))
                    ]))));
  }
}
