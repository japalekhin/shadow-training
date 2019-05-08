import 'dart:ui';
import 'package:basic_structure/speed-training.dart';
import 'package:flame/sprite.dart';

class Background {
  final SpeedTraining game;
  Rect rect;
  Sprite sprite;

  Background(this.game) {
    rect = Rect.fromLTWH(0, -22, 9, 22);
    sprite = Sprite('background.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }
}
