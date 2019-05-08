import 'package:flutter/material.dart';

class ShadowTrainingUI extends StatefulWidget {
  final ShadowTrainingUIState state = ShadowTrainingUIState();

  State<StatefulWidget> createState() => state;
}

class ShadowTrainingUIState extends State<ShadowTrainingUI> {
  bool isBGMEnabled = true;
  bool isSFXEnabled = true;
  double highScore = 0;

  void update() {
    setState(() {});
  }

  Widget spacer() {
    return Expanded(
      flex: 1,
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

  Widget bottomControls() {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: RaisedButton(
        child: Text(
          'Start Training!',
          style: TextStyle(fontSize: 30),
        ),
        padding: EdgeInsets.all(20),
        onPressed: () {},
      ),
    );
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        topControls(),
        spacer(),
        bottomControls(),
      ],
    );
  }
}
