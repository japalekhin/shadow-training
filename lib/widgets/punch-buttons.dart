import 'dart:ui' as ui;
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

class LeftPunch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(60, 60),
      painter: _CustomPainter(Rect.fromLTWH(0, 0, 64, 64)),
    );
  }
}

class RightPunch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(60, 60),
      painter: _CustomPainter(Rect.fromLTWH(64, 0, 64, 64)),
    );
  }
}

class Uppercut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(60, 60),
      painter: _CustomPainter(Rect.fromLTWH(128, 0, 64, 64)),
    );
  }
}

class _CustomPainter extends CustomPainter {
  final Rect sourceRect;
  ui.Image image;
  bool shouldTriggerRepaint = false;

  _CustomPainter(this.sourceRect) {
    initialize();
  }

  void initialize() async {
    image = await Flame.images.load('markers.png');

    shouldTriggerRepaint = true;
  }

  @override
  void paint(Canvas c, Size size) {
    if (image == null) return;
    c.drawImageRect(
      image,
      sourceRect,
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint(),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    if (shouldTriggerRepaint) {
      shouldTriggerRepaint = false;
      return true;
    }
    return false;
  }
}
