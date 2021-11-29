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
  bool selected4 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              width: selected1
                  ? MediaQuery.of(context).size.width * 0.45
                  : MediaQuery.of(context).size.width * 0.5,
              height: selected1
                  ? MediaQuery.of(context).size.height * 0.5
                  : MediaQuery.of(context).size.height * 0.7,
              curve: Curves.fastOutSlowIn,
              child: ElevatedButton(
                onPressed: () {
                  if (selected1 == false) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CamPage()));
                  }
                  setState(() {
                    selected1 = !selected1;
                  });
                  if (selected2 == false) {
                    selected2 = true;
                  }

                  if (selected4 == false) {
                    selected4 = true;
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Add some effects on face",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.overpass(
                          fontSize: 29.0, color: Colors.white),
                    ),
                    const Icon(Icons.face, size: 80.0, color: Colors.white)
                  ],
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
                width: selected2
                    ? MediaQuery.of(context).size.width * 0.45
                    : MediaQuery.of(context).size.width * 0.5,
                height: selected2
                    ? MediaQuery.of(context).size.height * 0.5
                    : MediaQuery.of(context).size.height * 0.7,
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

                    if (selected4 == false) {
                      selected4 = true;
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Swap your background",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.overpass(
                            fontSize: 29.0, color: Colors.white),
                      ),
                      const Icon(Icons.image, size: 80.0, color: Colors.white)
                    ],
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
              alignment: Alignment.bottomRight,
              child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                width: MediaQuery.of(context).size.width,
                height: selected4
                    ? MediaQuery.of(context).size.height * 0.2
                    : MediaQuery.of(context).size.height * 0.2 * 2,
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
                    }
                  },
                  child: const Icon(Icons.exit_to_app,
                      size: 80, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    side: const BorderSide(width: 1, color: Colors.white),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(80),
                            topRight: Radius.circular(80))),
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
