import 'dart:ui';
import 'package:basic_structure/components/background.dart';
import 'package:flame/game.dart';

class SpeedTraining extends Game {
  Background background;
  Size screen;
  double screenHeight;

  SpeedTraining() {
    background = Background(this);
  }

  void render(Canvas c) {
    if (screen == null) return;
    c.save();
    c.scale(screen.width / 9);
    c.translate(0, screenHeight);

    background.render(c);

    c.restore();
  }

  void update(double t) {}

  void resize(Size s) {
    screen = s;
    screenHeight = screen.height / (screen.width / 9);
  }
}
