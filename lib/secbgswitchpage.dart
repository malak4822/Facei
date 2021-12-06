import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:praktapp/pose_mask_painter.dart';
import 'package:provider/provider.dart';

class SecBgSwitchPage extends StatefulWidget {
  SecBgSwitchPage(
      {Key? key,
      required this.buttoncallback1,
      required this.buttoncallback2,
      required this.buttoncallback3,
      required this.buttoncallback4,
      this.ssFuntion1,
      this.value})
      : super(key: key);

  @override
  _SecBgSwitchPageState createState() => _SecBgSwitchPageState();

  final buttoncallback1;
  final buttoncallback2;
  final buttoncallback3;
  final buttoncallback4;
  final ssFuntion1;
  double? value = 0.6;
}

class _SecBgSwitchPageState extends State<SecBgSwitchPage> {
  double value = 0.6;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          color: Colors.black87,
          height: 110.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                  child: Material(
                      color: Colors.orange.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15),
                      child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          splashColor: Colors.orange,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            widget.buttoncallback1();
                          },
                          child: SizedBox(
                              width: 80.0,
                              height: 90.0,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.carrot,
                                      color: Colors.white,
                                      size: 50.0,
                                    ),
                                    Center(
                                        child: Text(
                                      "Carrot",
                                      style: GoogleFonts.overpass(
                                          fontSize: 10.0, color: Colors.white),
                                    ))
                                  ]))))),
              Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                  child: Material(
                      color: Colors.red.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15),
                      child: InkWell(
                          splashColor: Colors.red,
                          highlightColor: Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                          onTap: () {
                            widget.buttoncallback2();
                          },
                          child: SizedBox(
                              width: 80.0,
                              height: 90.0,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.appleAlt,
                                      color: Colors.white,
                                      size: 50.0,
                                    ),
                                    Center(
                                        child: Text(
                                      "Apple",
                                      style: GoogleFonts.overpass(
                                          fontSize: 10.0, color: Colors.white),
                                    ))
                                  ]))))),
              Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                  child: Material(
                      color: Colors.yellow.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(15),
                      child: InkWell(
                          splashColor: Colors.yellow,
                          highlightColor: Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                          onTap: () {
                            widget.buttoncallback3();
                          },
                          child: SizedBox(
                              width: 80.0,
                              height: 90.0,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.lemon,
                                      color: Colors.white,
                                      size: 50.0,
                                    ),
                                    Center(
                                        child: Text(
                                      "Lemon",
                                      style: GoogleFonts.overpass(
                                          fontSize: 10.0, color: Colors.white),
                                    ))
                                  ]))))),
              Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                  child: Material(
                      color: Colors.green.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(15),
                      child: InkWell(
                          splashColor: Colors.green.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(15),
                          highlightColor: Colors.transparent,
                          onTap: () {
                            widget.buttoncallback4();
                          },
                          child: SizedBox(
                              width: 80.0,
                              height: 90.0,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.leaf,
                                      color: Colors.white,
                                      size: 50.0,
                                    ),
                                    Center(
                                        child: Text(
                                      "Leaf",
                                      style: GoogleFonts.overpass(
                                          fontSize: 10.0, color: Colors.white),
                                    ))
                                  ])))))
            ],
          )),
      Material(
          color: Colors.black87,
          child: InkWell(
              splashColor: Colors.black38,
              highlightColor: Colors.transparent,
              onTap: () {
                widget.ssFuntion1();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 100.0),
                  const Icon(Icons.screenshot, size: 80.0, color: Colors.white),
                  Text("Take Screenshot",
                      style: GoogleFonts.overpass(
                        color: Colors.white,
                        fontSize: 25.0,
                      )),
                  const Icon(Icons.screenshot, size: 80.0, color: Colors.white),
                ],
              )))
    ]);
  }
}
