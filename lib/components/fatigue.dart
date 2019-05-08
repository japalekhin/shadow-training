import 'dart:ui';

import 'package:shadow_training/shadow-training.dart';

class Fatigue {
  final ShadowTraining game;
  Rect barRect;
  Paint barPaint;
  Rect holderRect;
  Paint holderPaint;

  Fatigue(this.game) {
    barPaint = Paint();
    holderPaint = Paint();
    holderPaint.color = Color(0x88ffffff);
  }

  void render(Canvas c) {
    if (barRect == null) return;
    c.drawRect(holderRect, holderPaint);
    c.drawRect(barRect, barPaint);
  }

  void update(double t) {
    holderRect ??= Rect.fromLTWH(0, -(game.screenHeight - 2.1875), 9, .25);
    barRect = Rect.fromLTWH(
      0,
      -(game.screenHeight - 2.1875),
      9 * game.fatigueValue,
      .25,
    );
    barPaint.color = Color.fromRGBO(
      255,
      0,
      0,
      (game.fatigueValue * .5) + .4,
    );
  }
}
