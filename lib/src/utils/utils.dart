import 'package:flutter/material.dart';

bool isNumber( String value) {
  if(value.isEmpty) return false;

  final number = num.tryParse(value);

  return (number == null ) ? false : true;
}

void showAlert(BuildContext context, String title, dynamic info) {
  String message = '';
  if(info['message'] == 'EMAIL_NOT_FOUND' ) {
    message = 'El email no ha sido encontrado.';
  } else if(info['message'] == 'INVALID_PASSWORD' ) {
    message = 'Los datos de acceso no son validos.';
  } else if(info['message'] =='EMAIL_EXISTS') {
    message = 'El usuario ya existe.';
  }

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],

      );
    }
  );
}