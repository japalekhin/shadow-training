import 'package:flutter/material.dart';
import 'package:shadow_training/shadow-training.dart';

class ShadowTrainingUI extends StatefulWidget {
  final ShadowTrainingUIState state = ShadowTrainingUIState();

  State<StatefulWidget> createState() => state;
}

class ShadowTrainingUIState extends State<ShadowTrainingUI> {
  ShadowTraining game;
  bool isTraining = false;
  bool isBGMEnabled = true;
  bool isSFXEnabled = true;
  double highScore = 0;

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
      padding: EdgeInsets.only(top: 5, left: 15, right: 15),
      child: Row(
        children: <Widget>[
          bgmControlButton(),
          sfxControlButton(),
          spacer(),
          highScoreDisplay(),
        ],
      ),
    );
  }

  Widget scoreDisplay() {
    return Text(
      '0',
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

  Widget bottomNotTraining() {
    return Row(
      children: <Widget>[
        IconButton(
          color: Colors.white,
          iconSize: 48,
          icon: Icon(
            Icons.help_outline,
          ),
          onPressed: () {},
        ),
        spacer(),
        RaisedButton(
          child: Text(
            'Start Training!',
            style: TextStyle(fontSize: 30),
          ),
          padding: EdgeInsets.all(20),
          onPressed: () {
            isTraining = true;
            game.start();
            update();
          },
        ),
        spacer(),
        IconButton(
          color: Colors.white,
          iconSize: 48,
          icon: Icon(
            Icons.nature_people,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget bottomTraining() {
    double iconSize = 64;
    return Row(
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
    );
  }

  Widget bottomControls() {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: isTraining ? bottomTraining() : bottomNotTraining(),
    );
  }

  Widget build(BuildContext context) {
    List<Widget> controls = List<Widget>();
    controls.add(topControls());
    if (isTraining) {
      controls.add(spacer(size: 60));
      controls.add(scoreDisplay());
    }
    controls.add(spacer());
    controls.add(bottomControls());

    return Column(children: controls);
  }
}
