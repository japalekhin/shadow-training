import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shadow_training/shadow-training.dart';

void main() async {
  await Flame.util.fullScreen();
  await Flame.util.setOrientation(DeviceOrientation.portraitUp);

  await Flame.images.loadAll(<String>[
    'background.png',
    'boxer/dizzy.png',
    'boxer/idle.png',
    'boxer/punch-left.png',
    'boxer/punch-right.png',
    'boxer/punch-up.png',
  ]);

  ShadowTraining game = ShadowTraining();
  runApp(game.widget);

  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  Flame.util.addGestureRecognizer(tapper);
}
