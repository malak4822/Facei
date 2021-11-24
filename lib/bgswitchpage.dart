import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BgSwitchPage extends StatelessWidget {
  const BgSwitchPage({Key? key, required this.controller}) : super(key: key);
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: controller,
      padding: EdgeInsets.zero,
      children: [
        const SizedBox(height: 40),
        buildAboutText(),
        const SizedBox(height: 20)
      ],
    );
  }
}

Widget buildAboutText() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("dhuwhduiwdhwuidwhduiwhudwhuidhduwhudhuiwhudwhuidwhudwuiw",
              style: GoogleFonts.overpass(fontSize: 30.0, color: Colors.white)),
          const SizedBox(height: 40.0),
          const Text(
              "jdiw jidwji djwidiowdiowjdj wdiojwid wiudjh awda ndjkawn ioudhawih diuwhdiawdj awjildjaldjiouwadjawsdiojwajiodjwajdawoidiuwajdiji")
        ],
      ),
    );
