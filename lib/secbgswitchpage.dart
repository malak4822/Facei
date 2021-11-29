import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SecBgSwitchPage extends StatefulWidget {
  const SecBgSwitchPage({
    Key? key,
    required ScrollController controller,
    required this.buttoncallback1,
    required this.buttoncallback2,
    required this.buttoncallback3,
    required this.buttoncallback4,
  }) : super(key: key);

  @override
  _SecBgSwitchPageState createState() => _SecBgSwitchPageState();

  final buttoncallback1;
  final buttoncallback2;
  final buttoncallback3;
  final buttoncallback4;
}

class _SecBgSwitchPageState extends State<SecBgSwitchPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          color: Colors.black87,
          height: 110.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 10, 15),
                  child: Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          splashColor: Colors.black,
                          highlightColor: Colors.transparent,
                          onTap: () {},
                          child: SizedBox(
                              width: 80.0,
                              height: 90.0,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.fileImage,
                                      color: Colors.black,
                                      size: 50.0,
                                    ),
                                    Center(
                                        child: Text(
                                      "Ur own image",
                                      style: GoogleFonts.overpass(
                                          fontSize: 10.0, color: Colors.black),
                                    ))
                                  ]))))),
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
          ))
    ]);
  }
}
