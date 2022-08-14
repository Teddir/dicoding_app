// ignore_for_file: void_checks, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deen/pages/home.dart';
import 'package:deen/utils/validate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:carousel_slider/carousel_slider.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({super.key});

  @override
  State<SplashScreenWidget> createState() => SplashScreenWidgetState();
}

class SplashScreenWidgetState extends State<SplashScreenWidget> {
  bool _showPassword = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // ignore: deprecated_member_use

  void _loginFb() async {
    print('object');
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      return alertDialog(
          context: context,
          titles: 'Pemberitahuan',
          desc: "Mohon maaf data tidak lengkap");
    }
    if (isEmail(email)) {
      if (password.length < 8) {
        return alertDialog(
            context: context,
            titles: "Konfirmasi",
            desc: 'Password max 8 karakter');
      } else {
        try {
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);
          log('$credential');
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            log('No user found for that email.');
          } else if (e.code == 'wrong-password') {
            log('Wrong password provided for that user.');
          }
        } catch (e) {
          print(e);
          log('$e');
          alertDialog(
              context: context, titles: "Konfirmasi", desc: '$e.message');
        }
      }
    } else {
      return alertDialog(
          context: context, titles: "Konfirmasi", desc: 'Email tidak tepat');
    }
  }

  void _toggleVisible() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 24),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Image.network(
                        "https://dicoding-web-img.sgp1.cdn.digitaloceanspaces.com/original/commons/homepage-hero.png",
                        height: 320,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Bangun Karirmu Sebagai Developer Profesional",
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 32)),
                            const SizedBox(
                              height: 18,
                            ),
                            Text("Mulai belajar terarah dengan learning path",
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14)),
                            const SizedBox(
                              height: 60,
                            ),
                            Container(
                                margin: const EdgeInsets.only(bottom: 14),
                                child: TextField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    labelText: "Email",
                                    hintText: "Masukkan Email",
                                    border: OutlineInputBorder(),
                                  ),
                                )),
                            Container(
                                margin: const EdgeInsets.only(bottom: 14),
                                child: TextField(
                                  controller: passwordController,
                                  obscureText:
                                      MediaQuery.of(context).size.width > 600
                                          ? false
                                          : !_showPassword,
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    hintText: "Masukkan Password",
                                    border: const OutlineInputBorder(),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        _toggleVisible();
                                      },
                                      child: Icon(
                                        _showPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off_outlined,
                                      ),
                                    ),
                                  ),
                                )),
                            const SizedBox(
                              height: 24,
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 14),
                              width: MediaQuery.of(context).size.width,
                              child: TextButton(
                                onPressed: () {
                                  _loginFb();
                                },
                                style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(16.0),
                                    primary: Colors.white,
                                    textStyle: const TextStyle(fontSize: 20),
                                    backgroundColor:
                                        const Color.fromARGB(255, 62, 80, 100)),
                                child: const Text('Login Sekarang',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                            Center(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                      child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 1,
                                    color: Color.fromARGB(255, 212, 212, 212),
                                  )),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 32),
                                    color: Colors.white,
                                    child: const Text('atau'),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(6)),
                              margin: const EdgeInsets.only(bottom: 14),
                              width: MediaQuery.of(context).size.width,
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(16.0),
                                    primary: Colors.white,
                                    textStyle: const TextStyle(fontSize: 20),
                                    backgroundColor: Colors.white,
                                  ),
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 12.0),
                                        child: Image.network(
                                          "https://cdn-icons-png.flaticon.com/512/281/281764.png",
                                          height: 24,
                                          width: 24,
                                        ),
                                      ),
                                      const Text('Masuk dengan Google',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black)),
                                    ],
                                  )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  "Belum punya akun? ",
                                  style: TextStyle(
                                      color: Color.fromARGB(73, 0, 0, 0)),
                                ),
                                RichText(
                                    text: TextSpan(
                                        text: 'Ayo ',
                                        style: const TextStyle(
                                            color: Color.fromARGB(73, 0, 0, 0),
                                            fontSize: 16),
                                        children: [
                                      TextSpan(
                                          text: 'daftar',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.blue[600],
                                              fontWeight: FontWeight.w500),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SplashScreenWidgetSign()),
                                              );
                                            })
                                    ]))
                              ],
                            )),
                          ]),
                    ),
                  ],
                ))));
  }

  Stream<List<User>> readUser() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((event) => event.docs.map((e) => User.fromJson(e.data())).toList());
}

class User {
  String id;
  final String name;
  final String email;
  final String password;

  User(
      {this.id = '',
      required this.name,
      required this.email,
      this.password = ''});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
      };

  static User fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
      );
}

class SplashScreenWidgetSign extends StatefulWidget {
  const SplashScreenWidgetSign({super.key});

  @override
  State<SplashScreenWidgetSign> createState() => SplashScreenWidgetSignState();
}

class SplashScreenWidgetSignState extends State<SplashScreenWidgetSign> {
  bool _showPassword = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // ignore: deprecated_member_use

  void _toggleVisible() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _regiterToFb() async {
    final docs = FirebaseFirestore.instance.collection('users').doc();

    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;

    final users = User(id: docs.id, name: name, email: email);
    final jsonUser = users.toJson();
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      return alertDialog(
          context: context,
          titles: 'Pemberitahuan',
          desc: "Mohon maaf data tidak lengkap");
    }
    if (isEmail(email)) {
      if (password.length < 8) {
        return alertDialog(
            context: context,
            titles: "Konfirmasi",
            desc: 'Password max 8 karakter');
      } else {
        try {
          final credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          await docs.set(jsonUser);
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyHomeWidget(uid: docs.id)),
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            log('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            log('The account already exists for that email.');
          }
        } catch (e) {
          log('$e');
        }
      }
    } else {
      return alertDialog(
          context: context, titles: "Konfirmasi", desc: 'Email tidak tepat');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 24),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Image.network(
                        "https://dicoding-web-img.sgp1.cdn.digitaloceanspaces.com/original/commons/homepage-hero.png",
                        height: 320,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Daftar akun Dicoding",
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 32)),
                            const SizedBox(
                              height: 18,
                            ),
                            Text("Mulai belajar terarah dengan learning path",
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14)),
                            const SizedBox(
                              height: 60,
                            ),
                            Container(
                                margin: const EdgeInsets.only(bottom: 14),
                                child: TextField(
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                    labelText: "Nama Lengkap",
                                    hintText: "Masukkan nama lengkap",
                                    border: OutlineInputBorder(),
                                  ),
                                )),
                            Container(
                                margin: const EdgeInsets.only(bottom: 14),
                                child: TextField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    labelText: "Email",
                                    hintText: "Masukkan email",
                                    border: OutlineInputBorder(),
                                  ),
                                )),
                            Container(
                                margin: const EdgeInsets.only(bottom: 14),
                                child: TextField(
                                  controller: passwordController,
                                  obscureText:
                                      MediaQuery.of(context).size.width > 600
                                          ? false
                                          : !_showPassword,
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    hintText: "Masukkan password",
                                    border: const OutlineInputBorder(),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        _toggleVisible();
                                      },
                                      child: Icon(
                                        _showPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off_outlined,
                                      ),
                                    ),
                                  ),
                                )),
                            const SizedBox(
                              height: 24,
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 14),
                              width: MediaQuery.of(context).size.width,
                              child: TextButton(
                                onPressed: () {
                                  _regiterToFb();
                                },
                                style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(16.0),
                                    primary: Colors.white,
                                    textStyle: const TextStyle(fontSize: 20),
                                    backgroundColor:
                                        const Color.fromARGB(255, 62, 80, 100)),
                                child: const Text('Daftar',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                            Center(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                      child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 1,
                                    color: Color.fromARGB(255, 212, 212, 212),
                                  )),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 32),
                                    color: Colors.white,
                                    child: const Text('atau'),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(6)),
                              margin: const EdgeInsets.only(bottom: 14),
                              width: MediaQuery.of(context).size.width,
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(16.0),
                                    primary: Colors.white,
                                    textStyle: const TextStyle(fontSize: 20),
                                    backgroundColor: Colors.white,
                                  ),
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 12.0),
                                        child: Image.network(
                                          "https://cdn-icons-png.flaticon.com/512/281/281764.png",
                                          height: 24,
                                          width: 24,
                                        ),
                                      ),
                                      const Text('Daftar dengan Google',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black)),
                                    ],
                                  )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  "Belum punya akun? ",
                                  style: TextStyle(
                                      color: Color.fromARGB(73, 0, 0, 0)),
                                ),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: 'Masuk sekarang',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue[600],
                                          fontWeight: FontWeight.w500),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pop(context);
                                        })
                                ]))
                              ],
                            )),
                          ]),
                    ),
                  ],
                ))));
  }
}
