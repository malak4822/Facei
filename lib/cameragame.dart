import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:body_detection/models/image_result.dart';
import 'package:body_detection/models/pose.dart';
import 'package:body_detection/models/body_mask.dart';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:body_detection/body_detection.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:praktapp/secbgswitchpage.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'pose_mask_painter.dart';

import 'dart:ui';

void main() {
  runApp(CamPage());
}

class CamPage extends StatefulWidget {
  CamPage({Key? key}) : super(key: key);

  @override
  State<CamPage> createState() => _CamPageState();
  final kontroler = ScreenshotController();
}

class _CamPageState extends State<CamPage> {
  ui.Image? zdj;
  ui.Image? nic;
  var kontroler = ScreenshotController();

  bool _isObjectVis = false;
  bool _isDetectingPose = false;
  Pose? _detectedPose;

  Image? _cameraImage;
  Size _imageSize = Size.zero;

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();

    final time = DateTime.now()
        .toIso8601String()
        .replaceAll(".", "-")
        .replaceAll(":", "-");

    final name = "screenshot$time";
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    return result["/Pictures"];
  }

  void takeScreenshot() async {
    final screenshot = await kontroler.captureFromWidget(_cameraDetectionView);

    await saveImage(screenshot);
  }

  void essan1() {
    setState(() {
      loadImage("img/carrot.png");
      if (_isDetectingPose == true) {
        _isObjectVis = !_isObjectVis;
      }
    });
  }

  void essan2() {
    setState(() {
      loadImage("img/apple.png");
      if (_isDetectingPose == true) {
        _isObjectVis = !_isObjectVis;
      }
    });
  }

  void essan3() {
    setState(() {
      loadImage("img/lemon.png");
      if (_isDetectingPose == true) {
        _isObjectVis = !_isObjectVis;
      }
    });
  }

  void essan4() {
    setState(() {
      loadImage("img/leaf.png");
      if (_isDetectingPose == true) {
        _isObjectVis = !_isObjectVis;
      }
    });
  }

  Future<void> _startCameraStream() async {
    final request = await Permission.camera.request();
    if (request.isGranted) {
      await BodyDetection.startCameraStream(
        onFrameAvailable: _handleCameraImage,
        onPoseAvailable: (pose) {
          if (!_isDetectingPose) return;
          _handlePose(pose);
        },
      );
    }
  }

  Future<void> _stopCameraStream() async {
    await BodyDetection.stopCameraStream();

    setState(() {
      _cameraImage = null;
      _imageSize = Size.zero;
    });
  }

  void _handleCameraImage(ImageResult result) {
    // Ignore callback if navigated out of the page.
    if (!mounted) return;

    // To avoid a memory leak issue.
    // https://github.com/flutter/flutter/issues/60160
    PaintingBinding.instance?.imageCache?.clear();
    PaintingBinding.instance?.imageCache?.clearLiveImages();

    final image = Image.memory(
      result.bytes,
      gaplessPlayback: true,
      fit: BoxFit.fill,
    );

    setState(() {
      _cameraImage = image;
      _imageSize = result.size;
    });
  }

  void _handlePose(Pose? pose) {
    // Ignore if navigated out of the page.
    if (!mounted) return;

    setState(() {
      _detectedPose = pose;
    });
  }

  Future<void> _toggleDetectPose() async {
    if (_isDetectingPose) {
      await BodyDetection.disablePoseDetection();
    } else {
      await BodyDetection.enablePoseDetection();
    }

    setState(() {
      _isDetectingPose = !_isDetectingPose;
      _detectedPose = null;
    });
  }

  Future loadImage(String path) async {
    final data = await rootBundle.load(path);
    final bytes = data.buffer.asUint8List();
    final zdj = await decodeImageFromList(bytes);

    setState(() => this.zdj = zdj);
  }

  Widget get _cameraDetectionView => Center(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: CustomPaint(
            child: _cameraImage,
            foregroundPainter: PoseMaskPainter(
              zdj: _isObjectVis ? zdj : nic,
              pose: _detectedPose,
              imageSize: _imageSize,
            ),
          )));
  Widget get reszta => Wrap(
        spacing: 10.0,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.white),
              onPressed: () async {
                _startCameraStream();
              },
              child: Text(
                "On cam",
                style:
                    GoogleFonts.overpass(color: Colors.black, fontSize: 20.0),
              )),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.white),
              onPressed: () async {
                _stopCameraStream();
              },
              child: Text(
                "Off cam",
                style:
                    GoogleFonts.overpass(color: Colors.black, fontSize: 20.0),
              )),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.white),
              onPressed: () async {
                if (_isObjectVis == true) {
                  _isObjectVis = !_isObjectVis;
                }
                // _toggleDetectBodyMask();
                _toggleDetectPose();
              },
              child: Text(
                "Wyłącz Efekty",
                style:
                    GoogleFonts.overpass(color: Colors.black, fontSize: 20.0),
              )),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white38,
        body: LayoutBuilder(builder: (context, constraints) {
          return Scaffold(
              body: SlidingUpPanel(
            maxHeight: 230,
            minHeight: 110,
            body: Container(
              color: Colors.black87,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _cameraDetectionView,
                    reszta,
                  ]),
            ),
            panelBuilder: (controller) => SecBgSwitchPage(
                buttoncallback1: essan1,
                buttoncallback2: essan2,
                buttoncallback3: essan3,
                buttoncallback4: essan4,
                ssFuntion: takeScreenshot),
          ));
        }));
  }
}
