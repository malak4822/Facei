import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:body_detection/models/pose.dart';
import 'package:body_detection/models/pose_landmark.dart';
import 'package:body_detection/models/pose_landmark_type.dart';

class PoseMaskPainter extends CustomPainter {
  PoseMaskPainter({
    this.zdj,
    required this.pose,
    required this.mask,
    required this.imageSize,
  });

  final ui.Image? zdj;
  final Pose? pose;
  final ui.Image? mask;
  final Size imageSize;
  final pointPaint = Paint()..color = const Color.fromRGBO(0, 0, 0, 1);
  final leftPointPaint = Paint()..color = const Color.fromRGBO(40, 245, 200, 1);
  final rightPointPaint = Paint()
    ..color = const Color.fromRGBO(100, 208, 218, 1);
  final linePaint = Paint()
    ..color = const Color.fromRGBO(255, 255, 255, 0.9)
    ..strokeWidth = 3;
  final maskPaint = Paint()
    ..colorFilter = const ColorFilter.mode(
        Color.fromRGBO(197, 108, 175, 0.6), BlendMode.srcOut);

  @override
  void paint(ui.Canvas canvas, Size size) {
    final double hRatio =
        imageSize.width == 0 ? 1 : size.width / imageSize.width;
    final double vRatio =
        imageSize.height == 0 ? 1 : size.height / imageSize.height;

    offsetForPart(PoseLandmark part) =>
        Offset(part.position.x * hRatio, part.position.y * vRatio);

    if (zdj != null) {
      if (pose?.landmarks
              .indexWhere((element) => element.type == PoseLandmarkType.nose) !=
          -1) {
        final landmark = pose?.landmarks.firstWhere(
          (element) => element.type == PoseLandmarkType.nose,
        );
        paintimage(canvas, zdj!, offsetForPart(landmark!), 0.1);
      }
    }
  }

  void paintimage(
    ui.Canvas canvas,
    ui.Image image,
    Offset centrum,
    double skala,
  ) {
    final double left = -1 / 2 * image.width * skala;
    final double top = -1 / 2 * image.height * skala;
    final double right = 1 / 2 * image.width * skala;
    final double bottom = 1 / 2 * image.height * skala;
    canvas.drawImageRect(
        image,
        Rect.fromLTRB(0, 0, image.width.toDouble(), image.height.toDouble()),
        Rect.fromLTRB(left + centrum.dx, top + centrum.dy, right + centrum.dx,
            bottom + centrum.dy),
        Paint());
  }

  void _paintMask(Canvas canvas, Size size) {
    if (mask == null) return;

    canvas.drawImageRect(
        mask!,
        Rect.fromLTWH(0, 0, mask!.width.toDouble(), mask!.height.toDouble()),
        Rect.fromLTWH(0, 0, size.width, size.height),
        maskPaint);
  }

  @override
  bool shouldRepaint(PoseMaskPainter oldDelegate) {
    return oldDelegate.pose != pose ||
        oldDelegate.zdj != zdj ||
        oldDelegate.mask != mask ||
        oldDelegate.imageSize != imageSize;
  }

  List<List<PoseLandmarkType>> get connections => [
        [PoseLandmarkType.leftEar, PoseLandmarkType.leftEyeOuter],
        [PoseLandmarkType.leftEyeOuter, PoseLandmarkType.leftEye],
        [PoseLandmarkType.leftEye, PoseLandmarkType.leftEyeInner],
        [PoseLandmarkType.leftEyeInner, PoseLandmarkType.nose],
        [PoseLandmarkType.nose, PoseLandmarkType.rightEyeInner],
        [PoseLandmarkType.rightEyeInner, PoseLandmarkType.rightEye],
        [PoseLandmarkType.rightEye, PoseLandmarkType.rightEyeOuter],
        [PoseLandmarkType.rightEyeOuter, PoseLandmarkType.rightEar],
        [PoseLandmarkType.mouthLeft, PoseLandmarkType.mouthRight],
        [PoseLandmarkType.leftShoulder, PoseLandmarkType.rightShoulder],
        [PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip],
        [PoseLandmarkType.rightShoulder, PoseLandmarkType.rightHip],
        [PoseLandmarkType.rightShoulder, PoseLandmarkType.rightElbow],
        [PoseLandmarkType.rightWrist, PoseLandmarkType.rightElbow],
        [PoseLandmarkType.rightWrist, PoseLandmarkType.rightThumb],
        [PoseLandmarkType.rightWrist, PoseLandmarkType.rightIndexFinger],
        [PoseLandmarkType.rightWrist, PoseLandmarkType.rightPinkyFinger],
        [PoseLandmarkType.leftHip, PoseLandmarkType.rightHip],
        [PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee],
        [PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee],
        [PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle],
        [PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle],
        [PoseLandmarkType.leftElbow, PoseLandmarkType.leftShoulder],
        [PoseLandmarkType.leftWrist, PoseLandmarkType.leftElbow],
        [PoseLandmarkType.leftWrist, PoseLandmarkType.leftThumb],
        [PoseLandmarkType.leftWrist, PoseLandmarkType.leftIndexFinger],
        [PoseLandmarkType.leftWrist, PoseLandmarkType.leftPinkyFinger],
        [PoseLandmarkType.leftAnkle, PoseLandmarkType.leftHeel],
        [PoseLandmarkType.leftAnkle, PoseLandmarkType.leftToe],
        [PoseLandmarkType.rightAnkle, PoseLandmarkType.rightHeel],
        [PoseLandmarkType.rightAnkle, PoseLandmarkType.rightToe],
        [PoseLandmarkType.rightHeel, PoseLandmarkType.rightToe],
        [PoseLandmarkType.leftHeel, PoseLandmarkType.leftToe],
        [PoseLandmarkType.rightIndexFinger, PoseLandmarkType.rightPinkyFinger],
        [PoseLandmarkType.leftIndexFinger, PoseLandmarkType.leftPinkyFinger],
      ];
}
