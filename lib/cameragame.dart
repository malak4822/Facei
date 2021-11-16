import 'dart:typed_data';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:body_detection/models/image_result.dart';
import 'package:body_detection/models/pose.dart';
import 'package:body_detection/models/body_mask.dart';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:body_detection/body_detection.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

import 'pose_mask_painter.dart';

void main() {
  runApp(const CamPage());
}

class CamPage extends StatefulWidget {
  const CamPage({Key? key}) : super(key: key);

  @override
  State<CamPage> createState() => _CamPageState();
}

class _CamPageState extends State<CamPage> {
  int _selectedTabIndex = 0;

  bool _isDetectingPose = false;
  bool _isDetectingBodyMask = false;

  Pose? _detectedPose;
  ui.Image? _maskImage;
  Image? _cameraImage;
  Size _imageSize = Size.zero;

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
      fit: BoxFit.contain,
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
          (it) => [0, 0, 0, (it * 230).toInt()],
        )
        .toList();
    ui.decodeImageFromPixels(Uint8List.fromList(bytes), mask.width, mask.height,
        ui.PixelFormat.rgba8888, (image) {
      setState(() {
        _maskImage = image;
      });
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

  void _onTabEnter(int index) {
    // Camera tab
    if (index == 1) {
      _startCameraStream();
    }
  }

  void _onTabExit(int index) {
    // Camera tab
    if (index == 1) {
      _stopCameraStream();
    }
  }

  void _onTabSelectTapped(int index) {
    _onTabExit(_selectedTabIndex);
    _onTabEnter(index);
    _startCameraStream();

    setState(() {
      _selectedTabIndex = index;
    });
  }

  Widget get _cameraDetectionView => SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ClipRect(
                child: CustomPaint(
                  child: _cameraImage,
                  foregroundPainter: PoseMaskPainter(
                    pose: _detectedPose,
                    mask: _maskImage,
                    imageSize: _imageSize,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white38,
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            _cameraDetectionView,
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                onPressed: () async {
                  _startCameraStream();
                },
                child: Text(
                  "Włącz kamerę",
                  style:
                      GoogleFonts.overpass(color: Colors.black, fontSize: 20.0),
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                onPressed: () async {
                  _stopCameraStream();
                },
                child: Text(
                  "Wyłącz kamerę",
                  style:
                      GoogleFonts.overpass(color: Colors.black, fontSize: 20.0),
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                onPressed: () async {
                  _toggleDetectBodyMask();
                },
                child: Text(
                  "Wyłącz / Wyłącz odk",
                  style:
                      GoogleFonts.overpass(color: Colors.black, fontSize: 20.0),
                )),
          ]),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                color: Colors.black12,
                height: 100.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Material(
                        color: Colors.orange.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          splashColor: Colors.orange,
                          highlightColor: Colors.transparent,
                          onTap: () {},
                          child: SizedBox(
                            width: 100.0,
                            height: 70.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.carrot,
                                  color: Colors.white,
                                ),
                                Center(
                                  child: Text(
                                    "Carrot",
                                    style: GoogleFonts.overpass(
                                        fontSize: 20.0, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Material(
                        color: Colors.red.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15),
                        child: InkWell(
                          splashColor: Colors.red,
                          highlightColor: Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                          onTap: () {},
                          child: SizedBox(
                            width: 100.0,
                            height: 70.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const FaIcon(FontAwesomeIcons.appleAlt,
                                    color: Colors.white),
                                Center(
                                  child: Text(
                                    "Apple",
                                    style: GoogleFonts.overpass(
                                        fontSize: 20.0, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Material(
                        color: Colors.yellow.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(15),
                        child: InkWell(
                            splashColor: Colors.yellow,
                            highlightColor: Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {},
                            child: SizedBox(
                              width: 100.0,
                              height: 70.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const FaIcon(FontAwesomeIcons.lemon,
                                      color: Colors.white),
                                  Center(
                                    child: Text(
                                      "Lemon",
                                      style: GoogleFonts.overpass(
                                          fontSize: 20.0, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Material(
                          color: Colors.green.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(15),
                          child: InkWell(
                            splashColor: Colors.green.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(15),
                            highlightColor: Colors.transparent,
                            onTap: () {},
                            child: SizedBox(
                              width: 100.0,
                              height: 70.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const FaIcon(FontAwesomeIcons.leaf,
                                      color: Colors.white),
                                  Center(
                                    child: Text(
                                      "Leaf",
                                      style: GoogleFonts.overpass(
                                          fontSize: 20.0, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    )
                  ],
                )),
          )
        ]);
      }),
    );
  }
}
