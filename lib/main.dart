import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyAaecI-W75B7ot-z2T1lMPZi4RrNt_lH3E",
        authDomain: "sommerce-develop.firebaseapp.com",
        projectId: "sommerce-develop",
        storageBucket: "sommerce-develop.appspot.com",
        messagingSenderId: "512854204757",
        appId: "1:512854204757:web:31dcecc6b692c5f13b4fdc",
        measurementId: "G-36P2PQZVVF"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? result = FirebaseAuth.instance.currentUser;
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const OnBoardingWidget());
  }
}

class OnBoardingWidget extends StatefulWidget {
  const OnBoardingWidget({super.key});

  @override
  State<OnBoardingWidget> createState() => OnBoardingWidgetState();
}

class OnBoardingWidgetState extends State<OnBoardingWidget> {
  bool _showPassword = false;
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference dbRef =
      // ignore: deprecated_member_use
      FirebaseDatabase.instance.reference().child("Users");
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // ignore: deprecated_member_use

  void _regiterToFb() {
    firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((result) {
      dbRef.child(result.user!.uid).set({
        "email": emailController.text,
        "password": passwordController.text
      }).then((res) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomeWidget(uid: result.user!.uid)));
      });
    }).catchError((e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(e.message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Ok"))
            ],
          );
        },
      );
    });
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
                            Text(
                                "Mulai belajar terarah dengan learning path $_showPassword",
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
                                  _regiterToFb();
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
                                    children: [
                                      Image.network(
                                        "https://d17ivq9b7rppb3.cloudfront.net/original/commons/sso-google-v3.svg",
                                        height: 24,
                                        width: 24,
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
                                const Text(
                                  "Ayo ",
                                  style: TextStyle(
                                      color: Color.fromARGB(73, 0, 0, 0)),
                                ),
                                Text(
                                  "daftar",
                                  style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )),
                          ]),
                    ),
                  ],
                ))));
  }
}

class MyHomeWidget extends StatefulWidget {
  const MyHomeWidget({Key? key, required uid}) : super(key: key);
  @override
  State<MyHomeWidget> createState() => MyHomeWidgetState();
}

class MyHomeWidgetState extends State<MyHomeWidget> {
  final String _name = '';

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          actions: [],
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 16.0),
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                    height: 200,
                    autoPlay: true,
                    viewportFraction: 1,
                    autoPlayInterval: Duration(seconds: 3)),
                items: [1, 2, 3, 4].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        margin: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0)),
                        child: Align(
                          child: Container(
                            height: 200,
                            width: screenWidth - 32,
                            color: Colors.pinkAccent[200],
                            child: Align(
                              child: Text(
                                'Ini Banner $i',
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.pink[500],
                      borderRadius: BorderRadius.circular(100)),
                  margin: const EdgeInsets.all(12.0),
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Width : $screenSize, orientasi : $orientation',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
