import 'dart:ui';

import 'package:shadow_training/shadow-training.dart';

class Fatigue {
  final ShadowTraining game;
  Rect rect;
  Paint paint;

  Fatigue(this.game) {
    paint = Paint();
  }

  void render(Canvas c) {
    if (rect == null) return;
    c.drawRect(rect, paint);
  }

  void update(double t) {
    rect = Rect.fromLTWH(
      1,
      -(game.screenHeight - 2.1875),
      7 * game.fatigueValue,
      .25,
    );
    paint.color = Color.fromRGBO(
      255,
      0,
      0,
      (game.fatigueValue * .5) + .4,
    );
  }
}
