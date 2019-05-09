import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class Audio {
  static Soundpool bgmPool = Soundpool(streamType: StreamType.music);
  static Soundpool sfxPool = Soundpool(streamType: StreamType.notification, maxStreams: 10);
  static int bgm;
  static List<int> swish;

  static Future<void> preload() async {
    bgm = await rootBundle.load('assets/audio/bgm.ogg').then((ByteData soundData) => bgmPool.load(soundData));
    swish = List<int>();
    for (int i = 1; i <= 13; i++) {
      swish.add(await rootBundle.load('assets/audio/swish-' + i.toString() + '.ogg').then((ByteData soundData) => sfxPool.load(soundData)));
    }
  }
}
