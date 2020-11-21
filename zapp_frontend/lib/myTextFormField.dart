import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:zapp_frontend/perfil.dart';
import 'perfil.dart';

class MyTextFormField extends StatelessWidget {
  final String text;
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isPassword;
  final bool isEmail;

  MyTextFormField({
    this.text,
    this.hintText,
    this.validator,
    this.onSaved,
    this.isPassword = false,
    this.isEmail = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                  child: Text(
                text,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20.0,
                ),
              )),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: hintText,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  filled: true,
                ),
                obscureText: isPassword ? true : false,
                validator: validator,
                onSaved: onSaved,
                keyboardType:
                    isEmail ? TextInputType.emailAddress : TextInputType.text,
              ),
            ]));
  }
}
