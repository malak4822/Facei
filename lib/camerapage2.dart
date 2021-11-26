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
  ui.Image? zdj;
  ui.Image? nic;
  ui.Image? tlo;

  bool turnin = false;
  bool _isAppleVis = false;
  Pose? _detectedPose;
  bool _isDetectingBodyMask = false;
  bool _isDetectingPose = false;
  ui.Image? _maskImage;
  Image? _cameraImage;
  Size _imageSize = Size.zero;
  Size zdjSize = Size.zero;
  bool _detectedMask = false;
  Image? _selectedImage;

  Future<void> _selectImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null || result.files.isEmpty) return;
    final path = result.files.single.path;
    if (path != null) {
      _resetState();
      setState(() {
        _selectedImage = Image.file(File(path));
      });
    }
  }

  void _resetState() {
    setState(() {
      _maskImage = null;
      _detectedPose = null;
      _imageSize = Size.zero;
    });
  }

  Future<void> _detectImageBodyMask() async {
    PngImage? pngImage = await _selectedImage?.toPngImage();
    if (pngImage == null) return;
    setState(() {
      _imageSize = Size(pngImage.width.toDouble(), pngImage.height.toDouble());
    });
    final mask = await BodyDetection.detectBodyMask(image: pngImage);
    _handleBodyMask(mask);
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
        onMaskAvailable: (mask) {
          if (!_isDetectingBodyMask) return;
          _handleBodyMask(mask);
        },
      );
    }
  }

  void _handlePose(Pose? pose) {
    // Ignore if navigated out of the page.
    if (!mounted) return;

    setState(() {
      _detectedPose = pose;
    });
  }

  Future<void> _detectImagePose() async {
    PngImage? pngImage = await _selectedImage?.toPngImage();
    if (pngImage == null) return;
    setState(() {
      _imageSize = Size(pngImage.width.toDouble(), pngImage.height.toDouble());
    });
    final pose = await BodyDetection.detectPose(image: pngImage);
    _handlePose(pose);
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
                            'Turn off body mask detection',
                            style: GoogleFonts.overpass(color: Colors.black),
                          )
                        : Text('Turn on body mask detection',
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
          ),
        ));
      }),
    );
  }
}
