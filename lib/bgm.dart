import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class BGM {
  static AudioCache player;
  static bool isPaused = false;
  static bool isInitialized = false;

  static Future<void> preload() async {
    player = AudioCache(prefix: 'audio/', fixedPlayer: AudioPlayer());
    await player.load('bgm.ogg');
    await player.fixedPlayer.setReleaseMode(ReleaseMode.LOOP);
    isInitialized = true;
  }

  static Future<void> _update() async {
    if (!isInitialized) return;
    bool shouldPlay = !isPaused;
    if (shouldPlay) {
      await player.fixedPlayer.resume();
    } else {
      await player.fixedPlayer.pause();
    }
  }

  static Future<void> play() async {
    await player.loop('bgm.ogg', volume: .5);
    _update();
  }

  static void pause() {
    isPaused = true;
    _update();
  }

  static void resume() {
    isPaused = false;
    _update();
  }
}
