import 'dart:io';
import 'dart:typed_data';
import 'package:body_detection/models/body_mask.dart';
import 'package:body_detection/png_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:body_detection/models/image_result.dart';
import 'package:body_detection/models/pose.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:praktapp/bgswitchpage.dart';
import 'package:screenshot/screenshot.dart';
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
  bool _isCameraDetectin = true;
  double? value = 0.5;
  var kontroler = ScreenshotController();

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

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();

    final time1 = DateTime.now()
        .toIso8601String()
        .replaceAll(".", "-")
        .replaceAll(":", "-");

    final name = "screenshot$time1";
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    return result["/Pictures"];
  }

  void takeScreenshot() async {
    final screenshot = await kontroler.captureFromWidget(_cameraDetectionView);

    await saveImage(screenshot);
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
                    value: value!,
                    obrazkamery: _uiCameraImage,
                    tlo: tlo,
                    turnin: turnin,
                    mask: _maskImage,
                    imageSize: _imageSize,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  Widget get reszta => Wrap(
        spacing: 10.0,
        children: [
          Column(children: [
            IconButton(
                splashColor: Colors.black87,
                iconSize: 60.0,
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
                iconSize: 60.0,
                onPressed: () {
                  turnin = !turnin;
                  _toggleDetectBodyMask();
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
    return Scaffold(
      backgroundColor: const Color.fromRGBO(60, 60, 60, 1),
      body: LayoutBuilder(builder: (context, constraints) {
        return Scaffold(
            body: SlidingUpPanel(
          minHeight: 110,
          maxHeight: 210,
          body: Container(
            color: Colors.black87,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_cameraDetectionView, reszta]),
          ),
          panelBuilder: (controller) => BgSwitchPage(
              controller: controller,
              bckgrnd1: background1,
              bckgrnd2: background2,
              bckgrnd3: background3,
              bckgrnd4: background4,
              ssFuntion: takeScreenshot),
        ));
      }),
    );
  }
}
