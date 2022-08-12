import 'dart:developer';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deen/main.dart';
import 'package:deen/utils/validate.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';

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
