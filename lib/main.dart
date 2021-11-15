import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:praktapp/cameragame.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PraktApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Praktapp'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: Stack(
          children: [
            SizedBox(
              width: 180.0,
              height: 360.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, _) {
                      return const CamPage();
                    },
                  ));
                },
                child: Text(
                  "Let's play 1'st game",
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.overpass(fontSize: 31.0, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Colors.white, width: 1),
                  primary: Colors.black12,
                  elevation: 30,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(80))),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                width: 180.0,
                height: 360.0,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Let's play 2'nd game",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.overpass(
                        fontSize: 31.0, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black12,
                    side: const BorderSide(width: 1, color: Colors.white),
                    elevation: 30,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(80))),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: SizedBox(
                width: 180.0,
                height: 360.0,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Let's read the rules",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.overpass(
                        fontSize: 31.0, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black12,
                    side: const BorderSide(width: 1, color: Colors.white),
                    elevation: 30,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(80))),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                width: 180.0,
                height: 360.0,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Let's leave the game",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.overpass(
                        fontSize: 31.0, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black12,
                    side: const BorderSide(width: 1, color: Colors.white),
                    elevation: 30,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(80))),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
