import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      color: Colors.black,
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 40.0,
        mainAxisSpacing: 40.0,
        children: [
          Container(
            child: Center(
              child: Text(
                "Let's play 1'st game",
                textAlign: TextAlign.center,
                style:
                    GoogleFonts.overpass(fontSize: 31.0, color: Colors.white),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(80)),
            ),
          ),
          Container(
            child: Center(
              child: Text(
                "Let's play 2'nd game",
                textAlign: TextAlign.center,
                style:
                    GoogleFonts.overpass(fontSize: 31.0, color: Colors.white),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
            ),
          ),
          Container(
            child: Center(
              child: Text(
                "Let's read the rules",
                textAlign: TextAlign.center,
                style:
                    GoogleFonts.overpass(fontSize: 31.0, color: Colors.white),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.only(topRight: Radius.circular(80)),
            ),
          ),
          Container(
            child: Center(
              child: Text(
                "Let's leave the APK",
                textAlign: TextAlign.center,
                style:
                    GoogleFonts.overpass(fontSize: 31.0, color: Colors.white),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.yellowAccent,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(80)),
            ),
          ),
        ],
      ),
    ));
  }
}
