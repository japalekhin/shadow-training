import 'dart:math';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class SFX {
  static Soundpool sfxPool = Soundpool(streamType: StreamType.music, maxStreams: 10);
  static List<int> swishTrail = <int>[-1, -1, -1];
  static List<int> swish;
  static Random random = Random();

  static Future<void> preload() async {
    swish = List<int>();
    for (int i = 1; i <= 13; i++) {
      swish.add(await rootBundle.load('assets/audio/swish-' + i.toString() + '.ogg').then((ByteData soundData) => sfxPool.load(soundData)));
    }
  }

  static void playRandomPunch() {
    if (swish == null) return;
    if (swish.length < 4) return;

    int index;
    do {
      index = random.nextInt(swish.length);
    } while (swishTrail.contains(index));

    sfxPool.play(
      swish[random.nextInt(swish.length)],
    );

    swishTrail[0] = swishTrail[1];
    swishTrail[1] = swishTrail[2];
    swishTrail[2] = index;
  }
}
