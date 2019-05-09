import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shadow_training/shadow-training.dart';

class ShadowTrainingUI extends StatefulWidget {
  final ShadowTrainingUIState state = ShadowTrainingUIState();

  State<StatefulWidget> createState() => state;
}

class ShadowTrainingUIState extends State<ShadowTrainingUI> with WidgetsBindingObserver {
  ShadowTraining game;
  UIScreen currentScreen = UIScreen.home;
  bool isBGMEnabled = true;
  bool isSFXEnabled = true;
  int score = 0;
  int highScore = 0;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void update() {
    setState(() {});
  }

  Widget spacer({int size}) {
    return Expanded(
      flex: size ?? 100,
      child: Center(),
    );
  }

  Widget bgmControlButton() {
    return Ink(
      decoration: ShapeDecoration(
        shape: CircleBorder(),
      ),
      child: IconButton(
        color: isBGMEnabled ? Colors.white : Colors.grey,
        icon: Icon(
          isBGMEnabled ? Icons.music_note : Icons.music_video,
        ),
        onPressed: () {
          isBGMEnabled = !isBGMEnabled;
          update();
        },
      ),
    );
  }

  Widget sfxControlButton() {
    return Ink(
      decoration: ShapeDecoration(
        shape: CircleBorder(),
      ),
      child: IconButton(
        color: isSFXEnabled ? Colors.white : Colors.grey,
        icon: Icon(
          isSFXEnabled ? Icons.volume_up : Icons.volume_off,
        ),
        onPressed: () {
          isSFXEnabled = !isSFXEnabled;
          update();
        },
      ),
    );
  }

  Widget helpButton() {
    return Ink(
      decoration: ShapeDecoration(
        shape: CircleBorder(),
      ),
      child: IconButton(
        color: Colors.white,
        icon: Icon(
          Icons.help_outline,
        ),
        onPressed: () {
          currentScreen = currentScreen == UIScreen.help ? UIScreen.home : UIScreen.help;
          update();
        },
      ),
    );
  }

  Widget creditsButton() {
    return Ink(
      decoration: ShapeDecoration(
        shape: CircleBorder(),
      ),
      child: IconButton(
        color: Colors.white,
        icon: Icon(
          Icons.nature_people,
        ),
        onPressed: () {
          currentScreen = currentScreen == UIScreen.credits ? UIScreen.home : UIScreen.credits;
          update();
        },
      ),
    );
  }

  Widget highScoreDisplay() {
    return Text(
      'High-score: ' + highScore.toStringAsFixed(0),
      style: TextStyle(
        fontSize: 24,
        color: Colors.white,
      ),
    );
  }

  Widget topControls() {
    return Padding(
      padding: EdgeInsets.only(top: 5, left: 5, right: 15),
      child: Row(
        children: <Widget>[
          bgmControlButton(),
          sfxControlButton(),
          helpButton(),
          creditsButton(),
          spacer(),
          highScoreDisplay(),
        ],
      ),
    );
  }

  Widget scoreDisplay() {
    return Text(
      score.toString(),
      style: TextStyle(
        fontSize: 150,
        color: Colors.green,
        shadows: <Shadow>[
          Shadow(
            color: Color(0x88000000),
            blurRadius: 10,
            offset: Offset(2, 2),
          ),
        ],
      ),
    );
  }

  Widget buildScreenHome() {
    return Positioned.fill(
      child: Column(
        children: <Widget>[
          spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: Center(
              child: RaisedButton(
                child: Text(
                  'Start Training!',
                  style: TextStyle(fontSize: 30),
                ),
                padding: EdgeInsets.all(20),
                onPressed: () {
                  currentScreen = UIScreen.playing;
                  game.start();
                  update();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildScreenPlaying() {
    double iconSize = 64;
    return Positioned.fill(
      child: Column(
        children: <Widget>[
          spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: Row(
              children: <Widget>[
                spacer(),
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.adjust),
                  iconSize: iconSize,
                  padding: EdgeInsets.zero,
                  onPressed: () => game.boxer.punchLeft(),
                ),
                spacer(),
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.adjust),
                  iconSize: iconSize,
                  padding: EdgeInsets.zero,
                  onPressed: () => game.boxer.upperCut(),
                ),
                spacer(),
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.adjust),
                  iconSize: iconSize,
                  padding: EdgeInsets.zero,
                  onPressed: () => game.boxer.punchRight(),
                ),
                spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildScreenLost() {
    return Positioned.fill(
      child: Column(
        children: <Widget>[
          SimpleDialog(
            backgroundColor: Color(0xaaffffff),
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      'You got tired.',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Effective punches thrown:',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          score.toString(),
                          style: TextStyle(fontSize: 40),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'New High-Score!',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 20),
                    child: RaisedButton(
                      child: Text('Train Again!'),
                      onPressed: () {
                        currentScreen = UIScreen.playing;
                        game.start();
                        update();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          spacer(),
        ],
      ),
    );
  }

  Widget buildScreenHelp() {
    return Positioned.fill(
      child: Column(
        children: <Widget>[
          SimpleDialog(
            backgroundColor: Color(0xaaffffff),
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'How to Train',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: RaisedButton(
                      child: Text('Got it. Let\'s go!'),
                      onPressed: () {
                        currentScreen = UIScreen.home;
                        update();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          spacer(),
        ],
      ),
    );
  }

  Widget buildScreenCredits() {
    return Positioned.fill(
      child: Column(
        children: <Widget>[
          SimpleDialog(
            backgroundColor: Color(0xaaffffff),
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'The Team',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: RaisedButton(
                      child: Text('OK Cool!'),
                      onPressed: () {
                        currentScreen = UIScreen.home;
                        update();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          spacer(),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        topControls(),
        Expanded(
          child: IndexedStack(
            sizing: StackFit.expand,
            children: <Widget>[
              buildScreenHome(),
              buildScreenPlaying(),
              buildScreenLost(),
              buildScreenHelp(),
              buildScreenCredits(),
            ],
            index: currentScreen.index,
          ),
        ),
      ],
    );
  }

  void didChangeMetrics() {
    game.resize(window.physicalSize / window.devicePixelRatio);
  }
}

enum UIScreen {
  home,
  playing,
  lost,
  help,
  credits,
}
