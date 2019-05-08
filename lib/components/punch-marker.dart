import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:shadow_training/shadow-training.dart';

class PunchMarker {
  final ShadowTraining game;
  final PunchMarkerType type;
  bool isExpired = false;
  bool isHit = false;
  Rect rect;
  Sprite sprite;

  PunchMarker(this.game, this.type) {
    rect = Rect.fromLTWH(10, -(game.screenHeight - 1.8), 1, 1);
    if (type == PunchMarkerType.left) sprite = Sprite('markers.png', height: 64, width: 64);
    if (type == PunchMarkerType.right) sprite = Sprite('markers.png', height: 64, width: 64, x: 64);
    if (type == PunchMarkerType.up) sprite = Sprite('markers.png', height: 64, width: 64, x: 128);
  }

  void hit(double percentage) {
    isHit = true;
    double y = percentage < 1 ? 128 : 64;
    if (type == PunchMarkerType.left) sprite = Sprite('markers.png', height: 64, width: 64, y: y);
    if (type == PunchMarkerType.right) sprite = Sprite('markers.png', height: 64, width: 64, y: y, x: 64);
    if (type == PunchMarkerType.up) sprite = Sprite('markers.png', height: 64, width: 64, y: y, x: 128);
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void update(double t) {
    rect = rect.translate(game.gameSpeed * -t, 0);
    if (rect.left < -2) {
      if (!isHit) {
        game.addFatigue(.25);
      }
      isExpired = true;
    }
  }
}

enum PunchMarkerType {
  left,
  right,
  up,
}
