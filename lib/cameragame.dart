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
import 'package:provider/provider.dart';
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
}

class _CamPageState extends State<CamPage> {
  ui.Image? zdj;
  ui.Image? nic;
  var kontroler1 = ScreenshotController();

  bool _isObjectVis = false;
  bool _isDetectingPose = false;
  bool _isCameraDetectin = true;

  Pose? _detectedPose;

  Image? _cameraImage;
  Size _imageSize = Size.zero;

  Future<String> saveImages(Uint8List bytes) async {
    await [Permission.storage].request();

    final times = DateTime.now()
        .toIso8601String()
        .replaceAll(".", "-")
        .replaceAll(":", "-");

    final name = "screenshot$times";
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    return result["/Pictures"];
  }

  void takeScreenshot1() async {
    final screenshot1 =
        await kontroler1.captureFromWidget(_cameraDetectionView);

    await saveImages(screenshot1);
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

  double value = 0.5;

  Future loadImage(String path) async {
    final data = await rootBundle.load(path);
    final bytes = data.buffer.asUint8List();
    final zdj = await decodeImageFromList(bytes);

    setState(() => this.zdj = zdj);
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
                      value: value,
                      zdj: _isObjectVis ? zdj : nic,
                      pose: _detectedPose,
                      imageSize: _imageSize,
                    ),
                  ))
            ],
          ),
        ),
      );
  Widget get reszta => Wrap(
        spacing: 10.0,
        children: [
          SizedBox(
              width: 200.0,
              child: Slider(
                  value: value,
                  min: 0,
                  activeColor: Colors.white,
                  inactiveColor: Colors.white38,
                  max: 1,
                  onChanged: (value) => setState(() {
                        this.value = value;
                      }))),
          Column(children: [
            IconButton(
                splashColor: Colors.black87,
                iconSize: 50.0,
                onPressed: () {
                  _isCameraDetectin = !_isCameraDetectin;
                  if (_isCameraDetectin == true) {
                    _stopCameraStream();
                  } else {
                    _startCameraStream();
                  }
                },
                icon:
                    const Icon(Icons.camera_alt_outlined, color: Colors.white)),
            Text("on/off cam",
                style:
                    GoogleFonts.overpass(color: Colors.white, fontSize: 15.0))
          ]),
          Column(children: [
            IconButton(
                splashColor: Colors.black87,
                iconSize: 50.0,
                onPressed: () {
                  _toggleDetectPose();
                },
                icon: const Icon(Icons.portrait_rounded, color: Colors.white)),
            Text("on/off efekt",
                style:
                    GoogleFonts.overpass(color: Colors.white, fontSize: 15.0))
          ]),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
          backgroundColor: const Color.fromRGBO(60, 60, 60, 1),
          body: SlidingUpPanel(
            maxHeight: 210,
            minHeight: 110,
            body: Container(
              color: Colors.black45,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [_cameraDetectionView, reszta]),
            ),
            panelBuilder: (controller) => SecBgSwitchPage(
                buttoncallback1: essan1,
                buttoncallback2: essan2,
                buttoncallback3: essan3,
                buttoncallback4: essan4,
                ssFuntion1: takeScreenshot1),
          ));
    }));
  }
}
