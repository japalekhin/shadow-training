import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:shadow_training/shadow-training.dart';

class Title {
  final ShadowTraining game;
  Rect rect;
  Sprite sprite;

  Title(this.game) {
    sprite = Sprite('title.png');
    layout();
  }

  void layout() {
    if (game.screenHeight == null) return;
    rect = Rect.fromLTWH(1, game.screenHeight * -.775, 7, 3);
  }

  void render(Canvas c) {
    if (rect == null) return;
    sprite.renderRect(c, rect);
  }
}
