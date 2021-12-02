import 'dart:io';
import 'dart:typed_data';
import 'package:body_detection/models/body_mask.dart';
import 'package:body_detection/png_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:body_detection/models/image_result.dart';
import 'package:body_detection/models/pose.dart';

import 'package:praktapp/bgswitchpage.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:body_detection/body_detection.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

import 'pose_mask_painter.dart';

import 'dart:ui';

void main() {
  runApp(const SecCamPage());
}

class SecCamPage extends StatefulWidget {
  const SecCamPage({Key? key}) : super(key: key);

  @override
  State<SecCamPage> createState() => _SecCamPageState();
}

class _SecCamPageState extends State<SecCamPage> {
  ui.Image? nic;
  ui.Image? tlo;

  bool turnin = false;
  bool _isDetectingBodyMask = false;
  ui.Image? _maskImage;
  Image? _cameraImage;
  ui.Image? _uiCameraImage;
  Size _imageSize = Size.zero;

  Future<void> _startCameraStream() async {
    final request = await Permission.camera.request();
    if (request.isGranted) {
      await BodyDetection.startCameraStream(
        onFrameAvailable: _handleCameraImage,
        onMaskAvailable: (mask) {
          if (!_isDetectingBodyMask) return;
          _handleBodyMask(mask);
        },
      );
    }
  }

  void _handleBodyMask(BodyMask? mask) {
    // Ignore if navigated out of the page.
    if (!mounted) return;

    if (mask == null) {
      setState(() {
        _maskImage = null;
      });
      return;
    }

    final bytes = mask.buffer
        .expand(
          (it) => [0, 0, 0, (it * 255).toInt()],
        )
        .toList();
    ui.decodeImageFromPixels(Uint8List.fromList(bytes), mask.width, mask.height,
        ui.PixelFormat.rgba8888, (image) {
      setState(() {
        _maskImage = image;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    loadBckgImage("img/mountains.jpg");
    loadBckgImage("img/city.jpg");
    loadBckgImage("img/beach.jpg");
    loadBckgImage("img/forest.jpg");
  }

  void background1() {
    setState(() {
      loadBckgImage("img/mountains.jpg");
    });
  }

  void background2() {
    setState(() {
      loadBckgImage("img/beach.jpg");
    });
  }

  void background3() {
    setState(() {
      loadBckgImage("img/city.jpg");
    });
  }

  void background4() {
    setState(() {
      loadBckgImage("img/forest.jpg");
    });
  }

  Future loadBckgImage(String path) async {
    final data = await rootBundle.load(path);
    final bytes = data.buffer.asUint8List();
    final tlo = await decodeImageFromList(bytes);

    setState(() => this.tlo = tlo);
  }

  Future<void> _stopCameraStream() async {
    await BodyDetection.stopCameraStream();

    setState(() {
      _cameraImage = null;
      _imageSize = Size.zero;
    });
  }

  void _handleCameraImage(ImageResult result) async {
    // Ignore callback if navigated out of the page.
    if (!mounted) return;

    // To avoid a memory leak issue.
    // https://github.com/flutter/flutter/issues/60160
    PaintingBinding.instance?.imageCache?.clear();
    PaintingBinding.instance?.imageCache?.clearLiveImages();

    final uiCameraImage = Image.memory(
      result.bytes,
      gaplessPlayback: true,
      fit: BoxFit.fill,
    );
    var cameraImage = await decodeImageFromList(result.bytes);
    setState(() {
      _cameraImage = uiCameraImage;
      _imageSize = result.size;
      _uiCameraImage = cameraImage;
    });
  }

  Future<void> _toggleDetectBodyMask() async {
    if (_isDetectingBodyMask) {
      await BodyDetection.disableBodyMaskDetection();
    } else {
      await BodyDetection.enableBodyMaskDetection();
    }

    setState(() {
      _isDetectingBodyMask = !_isDetectingBodyMask;
      _maskImage = null;
    });
  }

  Widget get _cameraDetectionView => SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: CustomPaint(
                  child: _cameraImage,
                  foregroundPainter: PoseMaskPainter(
                    obrazkamery: _uiCameraImage,
                    tlo: tlo,
                    turnin: turnin,
                    mask: _maskImage,
                    imageSize: _imageSize,
                  ),
                ),
              ),
              Wrap(
                spacing: 10.0,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                      onPressed: () {
                        _startCameraStream();
                      },
                      child: Text(
                        "On Cam",
                        style: GoogleFonts.overpass(
                            color: Colors.black, fontSize: 20.0),
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                      onPressed: () async {
                        _stopCameraStream();
                      },
                      child: Text(
                        "Off Cam",
                        style: GoogleFonts.overpass(
                            color: Colors.black, fontSize: 20.0),
                      )),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                    onPressed: () async {
                      turnin = !turnin;
                      _toggleDetectBodyMask();
                    },
                    child: _isDetectingBodyMask
                        ? Text(
                            'Turn off mask detection',
                            style: GoogleFonts.overpass(color: Colors.black),
                          )
                        : Text('Turn on mask detection',
                            style: GoogleFonts.overpass(color: Colors.black)),
                  ),
                ],
              )
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white38,
      body: LayoutBuilder(builder: (context, constraints) {
        return Scaffold(
            body: SlidingUpPanel(
          minHeight: 110,
          body: Container(
            color: Colors.black87,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              _cameraDetectionView,
            ]),
          ),
          panelBuilder: (controller) => BgSwitchPage(
            controller: controller,
            bckgrnd1: background1,
            bckgrnd2: background2,
            bckgrnd3: background3,
            bckgrnd4: background4,
          ),
        ));
      }),
    );
  }
}
