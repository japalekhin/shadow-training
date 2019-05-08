import 'dart:math';
import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/painting.dart';
import 'package:shadow_training/components/background.dart';
import 'package:shadow_training/components/boxer.dart';
import 'package:shadow_training/components/fatigue.dart';
import 'package:shadow_training/components/perfect-time.dart';
import 'package:shadow_training/components/punch-marker.dart';
import 'package:shadow_training/shadow-training-ui.dart';

class ShadowTraining extends Game {
  final ShadowTrainingUIState ui;
  Random rnd;
  Size screen;
  double screenScale;
  double screenHeight;
  double fps;
  TextPainter fpsT;
  TextStyle fpsS;

  // constants
  final double minNextSpawn = .3;
  final double maxNextSpawn = 3;
  final double nextSpawnReductionFactor = .95;
  final double maxSpeed = 10;
  final double initialSpeed = 5;
  final double speedIncrement = .05;

  // game status
  double gameSpeed = 0;
  double nextSpawn = 0;
  double runningSpawn = 0;
  double fatigueValue = 0;

  // components
  Background background;
  Boxer boxer;
  List<PunchMarker> markers;
  PerfectTime perfectTime;
  Fatigue fatigueBar;

  ShadowTraining(this.ui) {
    fpsS = TextStyle(
      fontSize: 25,
      color: Color(0xffff0000),
    );
    fpsT = TextPainter(
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );

    rnd = Random();

    // components
    background = Background(this);
    boxer = Boxer(this);
    markers = List<PunchMarker>();
    fatigueBar = Fatigue(this);
  }

  void start() {
    perfectTime ??= PerfectTime(this);
    gameSpeed = initialSpeed;
    nextSpawn = maxNextSpawn;
    runningSpawn = nextSpawn;
    fatigueValue = 0;
    boxer.setStatus(BoxerStatus.idle);
    markers.clear();
  }

  void spawnMarker() {
    PunchMarkerType type;
    int r = rnd.nextInt(3);
    if (r == 0) type = PunchMarkerType.left;
    if (r == 1) type = PunchMarkerType.right;
    if (r == 2) type = PunchMarkerType.up;
    markers.add(PunchMarker(this, type));
  }

  void addFatigue(double fat) {
    fatigueValue = max(0, fatigueValue + fat);
    if (fatigueValue >= 1) {
      ui.hasLost = true;
      ui.isTraining = false;
      ui.update();
      boxer.setStatus(BoxerStatus.dizzy, howLong: 2);
    }
  }

  void render(Canvas c) {
    if (screen == null) return;
    c.save();
    c.scale(screenScale);
    c.translate(0, screenHeight);

    background.render(c);
    boxer.render(c);
    if (ui.isTraining) {
      markers.forEach((PunchMarker m) => m.render(c));
      perfectTime.render(c);
      fatigueBar.render(c);
    }

    c.restore();

    fpsT.paint(c, Offset.zero);
  }

  void update(double t) {
    boxer.update(t);
    markers.forEach((PunchMarker m) => m.update(t));
    markers.removeWhere((PunchMarker m) => m.isExpired);

    if (ui.isTraining) {
      runningSpawn -= t;
      if (runningSpawn <= 0) {
        nextSpawn = max(minNextSpawn, nextSpawn * nextSpawnReductionFactor);
        runningSpawn = nextSpawn;
        spawnMarker();
      }
      if (gameSpeed < maxSpeed) {
        gameSpeed += speedIncrement * t;
        if (gameSpeed > maxSpeed) {
          gameSpeed = maxSpeed;
        }
      }
      addFatigue(.01 * t);
      fatigueBar.update(t);
    }

    fps = 1 / t;
    fpsT.text = TextSpan(text: fps.toString(), style: fpsS);
    fpsT.layout();
  }

  void resize(Size s) {
    screen = s;
    screenScale = screen.width / 9;
    screenHeight = screen.height / screenScale;
  }

  void onTapDown(TapDownDetails d) {
    if (!ui.isTraining) {
      boxer.randomPunch();
    }
  }
}
