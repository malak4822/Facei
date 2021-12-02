import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:body_detection/models/pose.dart';
import 'package:body_detection/models/pose_landmark.dart';
import 'package:body_detection/models/pose_landmark_type.dart';

class PoseMaskPainter extends CustomPainter {
  PoseMaskPainter({
    this.obrazkamery,
    this.zdj,
    this.tlo,
    this.pose,
    this.mask,
    required this.imageSize,
    this.turnin,
    ui.Image? background,
  });

  final ui.Image? tlo;
  final ui.Image? zdj;
  bool? turnin = false;
  final Pose? pose;
  final ui.Image? mask;
  final ui.Image? obrazkamery;
  final Size imageSize;

  final circlePaint = Paint()..color = const Color.fromRGBO(0, 255, 0, 0.8);

  @override
  void paint(ui.Canvas canvas, Size size) {
    if (turnin == true) {
      canvas.drawImageRect(
          obrazkamery!,
          Rect.fromLTWH(0, 0, obrazkamery!.width.toDouble(),
              obrazkamery!.height.toDouble()),
          Rect.fromLTWH(0, 0, size.width, size.height),
          Paint()..blendMode = ui.BlendMode.srcATop);
      canvas.drawImageRect(
          mask!,
          Rect.fromLTWH(0, 0, mask!.width.toDouble(), mask!.height.toDouble()),
          Rect.fromLTWH(0, 0, size.width, size.height),
          Paint()..blendMode = ui.BlendMode.dstIn);
      paintBackgroundimage(
          canvas, tlo!, const ui.Offset(0, 0), 0.25, ui.BlendMode.dstATop);
    } else {}
    final double hRatio =
        imageSize.width == 0 ? 1 : size.width / imageSize.width;
    final double vRatio =
        imageSize.height == 0 ? 1 : size.height / imageSize.height;

    offsetForPart(PoseLandmark part) =>
        Offset(part.position.x * hRatio, part.position.y * vRatio);

    for (final part in pose!.landmarks) {
      // Draw a circular indicator for the landmark.
      canvas.drawCircle(offsetForPart(part), 5, circlePaint);
    }

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

  void paintBackgroundimage(ui.Canvas canvas, ui.Image image, Offset centrum,
      double skala, ui.BlendMode tryb) {
    final double left = -1 / 2 * image.width * skala;
    final double top = -1 / 2 * image.height * skala;
    final double right = 1 / 2 * image.width * skala;
    final double bottom = 1 / 2 * image.height * skala;
    canvas.drawImageRect(
        image,
        Rect.fromLTRB(0, 0, image.width.toDouble(), image.height.toDouble()),
        Rect.fromLTRB(left + centrum.dx, top + centrum.dy, right + centrum.dx,
            bottom + centrum.dy),
        Paint()..blendMode = tryb);
  }

  void paintimage(
      ui.Canvas canvas, ui.Image image, Offset centrum, double skala) {
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
