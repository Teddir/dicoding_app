import 'dart:developer';
import 'dart:ui';

import 'package:deen/pages/home.dart';
import 'package:deen/pages/splashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final result = FirebaseAuth.instance.currentUser;
    final isValidasi = result != null
        ? FirebaseAuth.instance.currentUser!.uid != ''
        : result != null;
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        // ignore: unnecessary_null_comparison
        home: isValidasi
            ? const MyHomeWidget(
                uid: '',
              )
            : const SplashScreenWidget());
  }
}
