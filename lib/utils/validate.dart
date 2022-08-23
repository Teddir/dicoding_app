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
  final snackBar = SnackBar(
    content: Text(desc),
    action: SnackBarAction(
      label: 'Ok',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  // Find the ScaffoldMessenger in the widget tree
  // and use it to show a SnackBar.
  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

// dynamic center() {
//   return Center(
//                 child: TextButton(
//                     onPressed: () async {
//                       await FirebaseAuth.instance.signOut();

//                       // ignore: use_build_context_synchronously
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const SplashScreenWidget()),
//                       );
//                       alertDialog(
//                           context: context,
//                           titles: "Konfirmasi",
//                           desc: 'Berhasil keluar aplikasi');
//                     },
//                     child: const Text('Logout')),
//               )
// }
