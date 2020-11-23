import 'package:flutter/material.dart';
import 'myTextFormField.dart';
import 'mandar.dart';


class ListSearch extends StatefulWidget {
  ListSearchState createState() => ListSearchState();
}

class ListSearchState extends State<ListSearch> {

  TextEditingController _textController = TextEditingController();
  // String lista
  static List<String> mainDataList = [
    "Tarea1",
    "Tarea2",
    "Tarea3",
    "Tarea",
    "Tarea5",
    "Tarea6",
  ];

  // Copy Main List into New List.
  List<String> newDataList = List.from(mainDataList);

  onItemChanged(String value) {
    setState(() {
      newDataList = mainDataList
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Búsqueda...',
              ),
              onChanged: onItemChanged,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(12.0),
              children: newDataList.map((data) {
                return ListTile(
                  title: Text(data),
                  onTap: () => print(data),);
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}

class Biblioteca extends StatelessWidget {
  Biblioteca();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String nombre;
  String descripcion;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _textController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    final crear = Material(
      elevation: 5.0,
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyApp()));
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
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
                title: Text('Búsqueda tareas'),

            ),
            body: Center(
             child: new SingleChildScrollView(
                child: new Column(
                    children: [

                      Text(
                        'Biblioteca',
                        style: TextStyle(
                          fontFamily: 'SourceSansPro',
                          fontSize: 40,
                          letterSpacing: 2.5,
                        ),
                      ),
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: AssetImage('assets/biblio.jpg'),
                      ),

                    //  ListSearch(),
                  ]
                )
             ))
          //backgroundColor: Colors.blue[300],
          ));
  }
 
}
/*
  body: Center(
              child: Column(
              children: <Widget>[
                ListSearch(),
                  Form(
                    key: _formKey,

                    child: new SingleChildScrollView(

                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            Text(
                              'Biblioteca',
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 40,
                                letterSpacing: 2.5,
                              ),
                            ),
                            CircleAvatar(
                              radius: 80,
                              backgroundImage: AssetImage('assets/biblio.jpg'),
                            ),


                          ]),
                        )),
              ]),
            )
 */