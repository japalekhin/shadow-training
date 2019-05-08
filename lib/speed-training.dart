import 'dart:ui';
import 'package:basic_structure/components/background.dart';
import 'package:flame/game.dart';

class SpeedTraining extends Game {
  Background background;
  Size screen;
  double screenScale;
  double screenHeight;

  SpeedTraining() {
    background = Background(this);
  }

  void render(Canvas c) {
    if (screen == null) return;
    c.save();
    c.scale(screenScale);
    c.translate(0, screenHeight);

    background.render(c);

    c.restore();
  }

  void update(double t) {}

  void resize(Size s) {
    screen = s;
    screenScale = screen.width / 9;
    screenHeight = screen.height / screenScale;
  }
}
