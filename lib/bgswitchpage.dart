import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class BgSwitchPage extends StatefulWidget {
  const BgSwitchPage(
      {Key? key,
      required this.controller,
      this.bckgrnd1,
      this.bckgrnd2,
      this.bckgrnd3,
      this.bckgrnd4,
      this.ssFuntion})
      : super(key: key);
  final ScrollController controller;

  @override
  State<BgSwitchPage> createState() => _BgSwitchPageState();

  final bckgrnd1;
  final bckgrnd2;
  final bckgrnd3;
  final bckgrnd4;
  final ssFuntion;
}

class _BgSwitchPageState extends State<BgSwitchPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: widget.controller,
      padding: EdgeInsets.zero,
      children: [
        Container(
            color: Colors.black87,
            height: 110.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                    child: Material(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(15),
                        child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            splashColor: Colors.blue,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              widget.bckgrnd1();
                            },
                            child: SizedBox(
                                width: 80.0,
                                height: 90.0,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const FaIcon(
                                        FontAwesomeIcons.mountain,
                                        color: Colors.white,
                                        size: 50.0,
                                      ),
                                      Center(
                                          child: Text(
                                        "mountains",
                                        style: GoogleFonts.overpass(
                                            fontSize: 12.0,
                                            color: Colors.white),
                                      ))
                                    ]))))),
                Padding(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                    child: Material(
                        color: const Color.fromARGB(230, 230, 230, 1),
                        borderRadius: BorderRadius.circular(15),
                        child: InkWell(
                            splashColor: Colors.yellow,
                            highlightColor: Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {
                              widget.bckgrnd2();
                            },
                            child: SizedBox(
                                width: 80.0,
                                height: 90.0,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const FaIcon(
                                        FontAwesomeIcons.umbrellaBeach,
                                        color: Colors.white,
                                        size: 50.0,
                                      ),
                                      Center(
                                          child: Text(
                                        "beach",
                                        style: GoogleFonts.overpass(
                                            fontSize: 12.0,
                                            color: Colors.white),
                                      ))
                                    ]))))),
                Padding(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                    child: Material(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(15),
                        child: InkWell(
                            splashColor: Colors.grey,
                            highlightColor: Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {
                              widget.bckgrnd3();
                            },
                            child: SizedBox(
                                width: 80.0,
                                height: 90.0,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const FaIcon(
                                        FontAwesomeIcons.city,
                                        color: Colors.white,
                                        size: 50.0,
                                      ),
                                      Center(
                                          child: Text(
                                        "city",
                                        style: GoogleFonts.overpass(
                                            fontSize: 10.0,
                                            color: Colors.white),
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
                              widget.bckgrnd4();
                            },
                            child: SizedBox(
                                width: 80.0,
                                height: 90.0,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const FaIcon(
                                        FontAwesomeIcons.tree,
                                        color: Colors.white,
                                        size: 50.0,
                                      ),
                                      Center(
                                          child: Text(
                                        "forest",
                                        style: GoogleFonts.overpass(
                                            fontSize: 10.0,
                                            color: Colors.white),
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
                  widget.ssFuntion();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100.0),
                    const Icon(Icons.screenshot,
                        size: 80.0, color: Colors.white),
                    Text("Take Screenshot",
                        style: GoogleFonts.overpass(
                          color: Colors.white,
                          fontSize: 25.0,
                        )),
                    const Icon(Icons.screenshot,
                        size: 80.0, color: Colors.white),
                  ],
                )))
      ],
    );
  }
}
