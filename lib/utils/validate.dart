import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

bool isEmail(String string) {
  // Null or empty string is invalid
  if (string == null || string.isEmpty) {
    return false;
  }

  const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  final regExp = RegExp(pattern);

  if (!regExp.hasMatch(string)) {
    return false;
  }
  return true;
}

dynamic alertDialog(
    {required context, required String titles, required String desc}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titles, textScaleFactor: 1.5),
          content: Text(desc, textScaleFactor: 1.2),
          actions: <Widget>[
            TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        );
      });
}
