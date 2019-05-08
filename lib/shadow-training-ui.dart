import 'package:flutter/material.dart';

class ShadowTrainingUI extends StatefulWidget {
  final ShadowTrainingUIState state = ShadowTrainingUIState();

  State<StatefulWidget> createState() => state;
}

class ShadowTrainingUIState extends State<ShadowTrainingUI> {
  bool isBGMEnabled = true;
  bool isSFXEnabled = true;
  double highScore = 500;

  Widget spacer() {
    return Expanded(
      flex: 1,
      child: Center(),
    );
  }

  Widget topControls() {
    return Padding(
      padding: EdgeInsets.only(top: 5, left: 15, right: 15),
      child: Row(
        children: <Widget>[
          Ink(
            decoration: ShapeDecoration(
              shape: CircleBorder(),
            ),
            child: IconButton(
              color: isBGMEnabled ? Colors.white : Colors.grey,
              icon: Icon(
                isBGMEnabled ? Icons.music_note : Icons.music_video,
              ),
              onPressed: () {
                highScore += 100;
                isBGMEnabled = !isBGMEnabled;
                setState(() {});
              },
            ),
          ),
          Ink(
            decoration: ShapeDecoration(
              shape: CircleBorder(),
            ),
            child: IconButton(
              color: isSFXEnabled ? Colors.white : Colors.grey,
              icon: Icon(
                isSFXEnabled ? Icons.volume_up : Icons.volume_off,
              ),
              onPressed: () {
                highScore -= 50;
                isSFXEnabled = !isSFXEnabled;
                setState(() {});
              },
            ),
          ),
          spacer(),
          Text('High-score: ' + highScore.toString()),
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
        onPressed: () => print('train!'),
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
