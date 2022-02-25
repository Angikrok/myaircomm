import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

showAlertDialog(BuildContext context) {
  String message =
      "Il codice cliente lo può trovare nel contratto o nella sua fattura sempre posizionato in alto a sinistra.  Il suo codice coincide con l'anno di installazione seguito dal codice AIR. Ad esempio il signor Mario Rossi installato nel 2018 avrà il codice cliente composto da 2018AIRXXXX.";
  Platform.isIOS
      ? showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text('Codice Cliente'),
              actions: [
                CupertinoDialogAction(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
              content: Text(message),
            );
          },
        )
      : showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32))),
              title: Text(
                'Codice Cliente',
                style: TextStyle(),
              ),
              content: Text(message),
              actions: [
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
}
