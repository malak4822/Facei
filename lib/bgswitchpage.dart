import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class BgSwitchPage extends StatelessWidget {
  const BgSwitchPage({Key? key, required this.controller}) : super(key: key);
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: controller,
      padding: EdgeInsets.zero,
      children: [buildAboutText(), const SizedBox(height: 20)],
    );
  }
}

Widget buildAboutText() => Column(
      children: [
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
                                            fontSize: 10.0,
                                            color: Colors.black),
                                      ))
                                    ]))))),
                Padding(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                    child: Material(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(15),
                        child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            splashColor: Colors.blue,
                            highlightColor: Colors.transparent,
                            onTap: () {},
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
                            onTap: () {},
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
                            onTap: () {},
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
                            onTap: () {},
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
            ))
      ],
    );
