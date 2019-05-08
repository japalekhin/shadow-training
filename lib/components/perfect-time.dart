import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:shadow_training/shadow-training.dart';

class PerfectTime {
  final ShadowTraining game;
  Rect rect;
  Sprite sprite;

  PerfectTime(this.game) {
    rect = Rect.fromLTWH(2, -(game.screenHeight - 1.55), 4, 1.5);
    sprite = Sprite('perfect-time.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }
}
