import 'dart:math';
import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:shadow_training/components/background.dart';
import 'package:shadow_training/components/boxer.dart';

class ShadowTraining extends Game {
  Random rnd;
  Size screen;
  double screenScale;
  double screenHeight;

  // components
  Background background;
  Boxer boxer;

  ShadowTraining() {
    background = Background(this);
    boxer = Boxer(this);
  }

  void render(Canvas c) {
    if (screen == null) return;
    c.save();
    c.scale(screenScale);
    c.translate(0, screenHeight);

    background.render(c);
    boxer.render(c);

    c.restore();
  }

  void update(double t) {
    boxer.update(t);
  }

  void resize(Size s) {
    screen = s;
    screenScale = screen.width / 9;
    screenHeight = screen.height / screenScale;
  }

  void onTapDown(TapDownDetails d) {}
}
