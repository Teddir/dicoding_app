// ignore_for_file: unnecessary_this, unnecessary_const

import 'dart:developer';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deen/main.dart';
import 'package:deen/pages/splashScreen.dart';
import 'package:deen/utils/validate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

class MyHomeWidget extends StatefulWidget {
  const MyHomeWidget({Key? key, required uid, datas}) : super(key: key);
  @override
  State<MyHomeWidget> createState() => MyHomeWidgetState();
}

class MySlider {
  final int id;
  final String imgUrl;
  final String title;
  final String desc;
  final String creator;

  const MySlider(
      {required this.id,
      required this.imgUrl,
      required this.title,
      required this.desc,
      required this.creator});

  @override
  String toString() {
    return '{${this.id}, ${this.title}, ${this.desc}, ${this.creator}, ${this.imgUrl}}';
  }
}

final List<MySlider> sliderList = [
  const MySlider(
    id: 0,
    title: 'Studi Independen Bersertifikat Kampus Merdeka Batch Ketiga',
    desc:
        'Program Studi Independen memungkinkan mahasiswa/i dari jurusan apapun mempelajari Teknologi & Persiapan Karier sebagai Developer dengan konversi hingga 20 SKS.',
    creator: 'Dicoding & Kemendikbudristek - Dikti',
    imgUrl:
        'https://dicoding-web-img.sgp1.cdn.digitaloceanspaces.com/original/commons/dos:studi_independen_bersertifikat_kampus_merdeka_batch_ketiga_image_010722152429.png',
  ),
  const MySlider(
    id: 3,
    title: 'Bangkit Academy 2022',
    desc:
        'Program kesiapan karier terafiliasi Kampus Merdeka. Melatih mahasiswa agar memiliki keterampilan relevan untuk karier sukses di perusahaan teknologi terkemuka.',
    creator: 'Google, GoTo, Traveloka, Kemdikbudristek',
    imgUrl:
        'https://dicoding-web-img.sgp1.cdn.digitaloceanspaces.com/original/commons/dos:bangkit_academy_2022_image_301121094414.png',
  ),
];

final List<MySlider> sliderListKategori = [
  const MySlider(
      id: 0,
      imgUrl:
          'https://images.unsplash.com/photo-1510915228340-29c85a43dcfe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
      title: 'Android Developer',
      desc: '',
      creator: ''),
  const MySlider(
      id: 1,
      imgUrl:
          'https://images.unsplash.com/photo-1534665482403-a909d0d97c67?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
      title: 'Back-End Developer',
      desc: '',
      creator: ''),
  const MySlider(
      id: 2,
      imgUrl:
          'https://images.unsplash.com/photo-1555066931-bf19f8fd1085?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=871&q=80',
      title: 'Front-End Web Developer',
      desc: '',
      creator: ''),
  const MySlider(
      id: 3,
      imgUrl:
          'https://images.unsplash.com/photo-1623479322729-28b25c16b011?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
      title: 'Ios Developer',
      desc: '',
      creator: ''),
];

class MyHomeWidgetState extends State<MyHomeWidget> {
  final String _name = '';

  @override
  Widget build(BuildContext context) {
    return Desain2();
  }

  void initState() {
    // put it here
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    super.initState();
  }
}

class Desain2 extends StatefulWidget {
  const Desain2({Key? key}) : super(key: key);

  @override
  State<Desain2> createState() => Desain2Widget();
}

class Desain2Widget extends State<Desain2> {
  int _selectedIndex = 0;

  void __onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    String userName = '';
    final result = FirebaseAuth.instance.currentUser!.uid;
    readData() async {
      var data = await FirebaseFirestore.instance
          .collection("users")
          .where('id', isEqualTo: result)
          .get();
      data.docs
          .forEach((documentSnapshot) => {userName = documentSnapshot['name']});
      return userName;
    }

    // ignore: prefer_function_declarations_over_variables

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          padding: const EdgeInsets.only(top: 12),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hello',
                    style: TextStyle(fontSize: 16, color: Colors.black45),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  FutureBuilder(
                    future: readData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('error ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final userName = snapshot.data;
                        return Container(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            '$userName',
                            style: const TextStyle(color: Colors.black87),
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(right: 16),
                child: Stack(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications,
                          color: Colors.black38,
                          size: 32,
                        )),
                    Positioned(
                      right: 11,
                      top: 8,
                      child: Container(
                        alignment: Alignment.center,
                        constraints:
                            const BoxConstraints(minHeight: 14, minWidth: 14),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6)),
                        child: const Text(
                          '1',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 18.0),
          CarouselSlider(
            options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 1,
                aspectRatio: 16 / 9,
                initialPage: 0,
                autoPlayInterval: const Duration(seconds: 10)),
            items: sliderList.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      height: 250,
                      width: screenWidth,
                      child: Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                                child: Container(
                              width: screenWidth,
                              color: Color.fromARGB(255, 212, 212, 212),
                              child: Image.network(
                                i.imgUrl,
                                fit: BoxFit.cover,
                              ),
                            )),
                            Container(
                              width: screenWidth,
                              height: 300,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(59, 62, 80, 100),
                                  Color.fromARGB(78, 43, 55, 70),
                                ],
                                stops: [0.4, 0.76],
                              )),
                            ),
                          ],
                        ),
                      ));
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 18.0),
          Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 32.0),
                child: const Text(
                  'Learning Path',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black54),
                ),
              ),
              const SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DetailLearning()),
                  );
                },
                child: CarouselSlider(
                  options: CarouselOptions(
                      height: screenWidth - (screenWidth / 10),
                      autoPlay: false,
                      viewportFraction: 0.9,
                      aspectRatio: 22 / 9,
                      initialPage: 1,
                      reverse: false,
                      enableInfiniteScroll: false,
                      autoPlayInterval: const Duration(seconds: 10)),
                  items: [0, 1, 2, 3].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 8, right: 12),
                              width: screenWidth,
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.0, color: Colors.black26),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.stacked_bar_chart_outlined,
                                          color: Colors.black54,
                                          size: 32,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          'Langkah ${i + 1}',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6),
                                      child: const Text(
                                        'Memulai Pemrograman Dengan Kotlin',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black54),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 14,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.timelapse,
                                              size: 32,
                                              color: Colors.green[300],
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            const Text(
                                              '50 jam',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black54),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              size: 32,
                                              color: Colors.yellow[700],
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            const Text(
                                              '4.85',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black54),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons
                                                  .call_missed_outgoing_outlined,
                                              size: 32,
                                              color: Colors.blue[300],
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            const Text(
                                              'Dasar - Pemula',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black54),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 14,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.bookmark_added_outlined,
                                              size: 32,
                                              color: Colors.grey[500],
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            const Text(
                                              '118 Modul',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black54),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 26,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.people_outline,
                                              size: 32,
                                              color: Colors.grey[500],
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            const Text(
                                              '41.225 Siswa',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black54),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Langkah ${i == 0 ? 'Pertama' : i == 1 ? 'Kedua' : i == 2 ? 'Ketiga' : 'Terakhir'}',
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black54),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        'Langkah ${i == 0 ? 'pertama' : i == 1 ? 'kedua' : i == 2 ? 'ketiga' : 'terakhir'}  untuk menjadi seorang Android Developer dengan mempelajari bahasa yang direkomendasikan oleh Google.',
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black87,
                                            letterSpacing: 1.0,
                                            height: 1.4),
                                      ),
                                    ]))
                          ],
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 32.0),
                child: const Text(
                  'Langganan',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black54),
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 26.0),
                child: Column(
                  children: List.generate(
                    2,
                    (index) {
                      return Container(
                        margin: const EdgeInsets.only(
                            left: 8, right: 12, bottom: 16),
                        width: screenWidth,
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1.0, color: Colors.black26),
                            borderRadius: BorderRadius.circular(4)),
                        child: Column(
                          children: [
                            const Text(
                              'Langganan 1 bulan (30 hari)',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Text('Rp 1.500.000'),
                            const SizedBox(
                              height: 8,
                            ),
                            TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                    primary: Colors.white,
                                    backgroundColor:
                                        const Color.fromARGB(255, 62, 80, 100)),
                                child: const Text(
                                  'Pilih Paket',
                                ))
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ))
        ]),
      )),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Katalog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner_rounded),
            label: 'Aktivasi Token',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: __onItemTapped,
        selectedItemColor: const Color.fromARGB(255, 62, 80, 100),
        unselectedItemColor: const Color.fromARGB(85, 62, 80, 100),
      ),
    );
  }
}

class DetailLearning extends StatelessWidget {
  const DetailLearning({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // ignore: prefer_const_constructors
    final myColor = Color.fromARGB(255, 62, 80, 100);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Langkah 1'),
        backgroundColor: myColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              height: screenWidth / 3.5,
              width: screenWidth,
              child: Image.network(
                'https://images.unsplash.com/photo-1555066932-e78dd8fb77bb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 32,
                            color: Colors.yellow[700],
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          const Text('4.85')
                        ],
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.arrow_right_alt,
                            size: 32,
                            color: myColor,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Row(
                            children: const [
                              Text(
                                'Android ',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.solid,
                                ),
                              ),
                              Text('Learning Path'),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Memulai Pemrograman Dengan Kotlin',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: myColor,
                        fontSize: 24,
                        letterSpacing: 1.4),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Teknologi:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 6),
                          decoration: BoxDecoration(
                              border: Border.all(width: 3, color: myColor),
                              borderRadius: BorderRadius.circular(4)),
                          child: const Text('Android',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ))),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 6),
                        decoration: BoxDecoration(
                            border: Border.all(width: 3, color: myColor),
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text('Multi Platform',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: [
                      Row(
                        children: const [
                          const Icon(
                            Icons.stacked_bar_chart_outlined,
                            size: 32,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          const Text('Level: Dasar',
                              style: TextStyle(
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.solid,
                                  fontWeight: FontWeight.w300))
                        ],
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Row(
                        children: const [
                          const Icon(
                            Icons.timer_outlined,
                            size: 32,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          const Text('50 jam',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w300))
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: const [
                      const Icon(
                        Icons.people_outline,
                        size: 32,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      const Text('41.304 Siswa terdaftar',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black38,
                              fontWeight: FontWeight.w300))
                    ],
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  const Text(
                    'Pelajari dasar bahasa pemrograman, functional programming, object-oriented programming (OOP), serta concurrency dengan menggunakan Kotlin.',
                    style: TextStyle(
                        height: 1.4, fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Container(
                      height: screenWidth / 12,
                      child: Image.network(
                        'https://dicoding-web-img.sgp1.cdn.digitaloceanspaces.com/original/academy/dos:memulai_pemrograman_dengan_kotlin_partner_110322081612.png',
                        fit: BoxFit.cover,
                      ))
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class Desain1 extends StatelessWidget {
  const Desain1({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 1,
                aspectRatio: 16 / 9,
                initialPage: 0,
                autoPlayInterval: const Duration(seconds: 10)),
            items: sliderList.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      height: 400,
                      width: screenWidth,
                      child: Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                                child: Container(
                              width: screenWidth,
                              color: Color.fromARGB(255, 212, 212, 212),
                              child: Image.network(
                                i.imgUrl,
                                fit: BoxFit.cover,
                              ),
                            )),
                            Container(
                              width: screenWidth,
                              height: 400,
                              alignment: Alignment.center,
                              // decoration: const BoxDecoration(
                              //     gradient: LinearGradient(
                              //   begin: Alignment.topCenter,
                              //   end: Alignment.bottomCenter,
                              //   colors: [
                              //     Color.fromARGB(59, 62, 80, 100),
                              //     Color.fromARGB(78, 43, 55, 70),
                              //   ],
                              //   stops: [0.4, 0.76],
                              // )),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                            ),
                          ],
                        ),
                      ));
                },
              );
            }).toList(),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Learning',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  Container(
                    alignment: Alignment.center,
                    color: Colors.pink,
                    child: GridView.count(
                      shrinkWrap: true,
                      primary: false,
                      scrollDirection: Axis.vertical,
                      crossAxisCount: 8,
                      children: List.generate(16, (index) {
                        return Text('sa');
                      }),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
