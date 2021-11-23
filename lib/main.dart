import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:praktapp/cameragame.dart';
import 'package:praktapp/camerapage2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PraktApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool selected1 = true;
  bool selected2 = true;
  bool selected3 = true;
  bool selected4 = true;

  List<String> listazmiennych = ["sel1", "sel2", "sel3", "sel4"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              width: selected1 ? 180.0 : 190.0,
              curve: Curves.fastOutSlowIn,
              height: selected1 ? 360.0 : 400.0,
              child: ElevatedButton(
                onPressed: () {
                  if (selected1 == false) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CamPage()));
                  }
                  setState(() {
                    selected1 = !selected1;
                  });
                  if (selected2 == false) {
                    selected2 = true;
                  }
                  if (selected3 == false) {
                    selected3 = true;
                  }
                  if (selected4 == false) {
                    selected4 = true;
                  }
                },
                child: Text(
                  "Let's play 1'st game",
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.overpass(fontSize: 31.0, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Colors.white, width: 1),
                  primary: Colors.black,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(80))),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                duration: const Duration(milliseconds: 400),
                width: selected2 ? 180.0 : 190.0,
                height: selected2 ? 360 : 400.0,
                child: ElevatedButton(
                  onPressed: () {
                    if (selected2 == false) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SecCamPage()));
                    }
                    setState(() {
                      selected2 = !selected2;
                    });
                    if (selected1 == false) {
                      selected1 = true;
                    }
                    if (selected3 == false) {
                      selected3 = true;
                    }
                    if (selected4 == false) {
                      selected4 = true;
                    }
                  },
                  child: Text(
                    "Let's play 2'nd game",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.overpass(
                        fontSize: 31.0, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    side: const BorderSide(width: 1, color: Colors.white),
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(80))),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                duration: const Duration(milliseconds: 400),
                width: selected3 ? 180.0 : 190.0,
                height: selected3 ? 360.0 : 400.0,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selected3 = !selected3;
                    });
                    if (selected1 == false) {
                      selected1 = true;
                    }
                    if (selected2 == false) {
                      selected2 = true;
                    }
                    if (selected4 == false) {
                      selected4 = true;
                    }
                  },
                  child: Text(
                    "Let's read the rules",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.overpass(
                        fontSize: 31.0, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    side: const BorderSide(width: 1, color: Colors.white),
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(80))),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                width: selected4 ? 180.0 : 190.0,
                height: selected4 ? 360.0 : 400.0,
                duration: const Duration(milliseconds: 400),
                child: ElevatedButton(
                  onPressed: () {
                    if (selected4 == false) {
                      SystemNavigator.pop();
                    }
                    setState(() {
                      selected4 = !selected4;
                    });
                    if (selected1 == false) {
                      selected1 = true;
                    }
                    if (selected2 == false) {
                      selected2 = true;
                    } else if (selected3 == false) {
                      selected3 = true;
                    }
                  },
                  child: const Icon(Icons.exit_to_app,
                      size: 80, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    side: const BorderSide(width: 1, color: Colors.white),
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
