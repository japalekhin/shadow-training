import 'package:basic_structure/speed-training.dart';
import 'package:flame/flame.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

void main() async {
  await Flame.util.fullScreen();
  await Flame.util.setOrientation(DeviceOrientation.portraitUp);

  await Flame.images.loadAll(<String>[
    'background.png',
  ]);

  SpeedTraining game = SpeedTraining();
  runApp(game.widget);
}
