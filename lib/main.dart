import 'package:flame/flame.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:shadow_training/audio.dart';
import 'package:shadow_training/shadow-training-ui.dart';
import 'package:shadow_training/shadow-training.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    'markers.png',
    'perfect-time.png',
  ]);
  Audio.preload();

  SharedPreferences storage = await SharedPreferences.getInstance();
  ShadowTrainingUI gameUI = ShadowTrainingUI();
  ShadowTraining game = ShadowTraining(gameUI.state);
  gameUI.state.storage = storage;
  gameUI.state.game = game;

  runApp(
    MaterialApp(
      title: 'Shadow Training',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapDown: game.onTapDown,
                child: game.widget,
              ),
            ),
            Positioned.fill(
              child: gameUI,
            ),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
