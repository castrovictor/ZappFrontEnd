import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

class LoginSocio extends StatelessWidget {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final codigo = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Código",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginSocio()));
        },
        child: Text("Entrar",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('LoginSocio'),
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text("Código",
                        style: TextStyle(
                            fontFamily: 'Montserrat', fontSize: 20.0)),
                  ),
                  SizedBox(height: 15.0),
                  codigo,
                  Expanded(
                    flex: 8,
                    child: ResponsiveGridList(
                        desiredItemWidth: 100,
                        minSpacing: 10,
                        children: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((i) {
                          return Container(
                            height: 100,
                            alignment: Alignment(0, 0),
                            color: Colors.cyan,
                            child: Text(i.toString()),
                          );
                        }).toList()),
                  )
                ])),
        /*
          child: ResponsiveGridRow(children: [
        ResponsiveGridCol(
          child: Container(
            height: 20,
            alignment: Alignment(0, 0),
            child: Text("Código",
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0)),
          ),
        ),
        ResponsiveGridCol(
          lg: 8,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 45.0),
                codigo,
              ]),
        ),
        ResponsiveGridCol(
          xs: 6,
          md: 3,
          child: Container(
            height: 100,
            alignment: Alignment(0, 0),
            color: Colors.green,
            child: Text("xs : 6 \r\nmd : 3"),
          ),
        ),
        ResponsiveGridCol(
          xs: 6,
          md: 3,
          child: Container(
            height: 100,
            alignment: Alignment(0, 0),
            color: Colors.orange,
            child: Text("xs : 6 \r\nmd : 3"),
          ),
        ),
        ResponsiveGridCol(
          xs: 6,
          md: 3,
          child: Container(
            height: 100,
            alignment: Alignment(0, 0),
            color: Colors.red,
            child: Text("xs : 6 \r\nmd : 3"),
          ),
        ),
        ResponsiveGridCol(
          xs: 6,
          md: 3,
          child: Container(
            height: 100,
            alignment: Alignment(0, 0),
            color: Colors.blue,
            child: Text("xs : 6 \r\nmd : 3"),
          ),
        ),
      ])*/
      ),
    );
  }
}
