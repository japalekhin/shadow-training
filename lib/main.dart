import 'package:flame/flame.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:shadow_training/shadow-training-ui.dart';
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
    'markers/left.png',
    'markers/right.png',
    'markers/up.png',
  ]);

  ShadowTrainingUI gameUI = ShadowTrainingUI();
  ShadowTraining game = ShadowTraining(gameUI.state);
  gameUI.state.game = game;

  runApp(
    MaterialApp(
      title: 'Shadow Training',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapDown: game.onTapDown,
                child: game.widget,
              ),
            ),
            Center(
              child: gameUI,
            ),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
