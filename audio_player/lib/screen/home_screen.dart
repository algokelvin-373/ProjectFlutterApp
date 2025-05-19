import 'package:audio_player/widget/audio_controller_widget.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/audio_notifier.dart';
import '../utils/utils.dart';
import '../widget/buffer_slider_controller_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final AudioPlayer audioPlayer;
  late final Source audioSource;

  @override
  void initState() {
    final provider = context.read<AudioNotifier>();

    audioPlayer = AudioPlayer();
    audioSource = AssetSource("sample_music.mp3");
    audioPlayer.setSource(audioSource);

    audioPlayer.onPlayerStateChanged.listen((state) {
      provider.isPlay = state == PlayerState.playing;

      if (state == PlayerState.stopped) {
        provider.position = Duration.zero;
      }
    });

    audioPlayer.onDurationChanged.listen((duration) {
      provider.duration = duration;
    });

    audioPlayer.onPositionChanged.listen((position) {
      provider.position = position;
    });

    audioPlayer.onPlayerComplete.listen((_) {
      provider.position = Duration.zero;
      provider.isPlay = false;
    });

    super.initState();
  }

  Widget _mainPage(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const Text(
                  "Summertime Sadness",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: NetworkImage(
                        "https://i.pravatar.cc/100",
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      "Lana Del Rey",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Consumer<AudioNotifier>(
                  builder: (context, provider, child) {
                    final bool isPlay = provider.isPlay;
                    return GestureDetector(
                      onTap: () {
                        isPlay
                            ? audioPlayer.pause()
                            : audioPlayer.play(audioSource);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(
                          isPlay ? Icons.pause : Icons.play_arrow,
                          size: 48,
                          color: Color(0xFFA3C16F),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 40),
                Consumer<AudioNotifier>(
                  builder: (context, provider, child) {
                    final duration = provider.duration;
                    final position = provider.position;

                    return BufferSliderControllerWidget(
                      maxValue: duration.inSeconds.toDouble(),
                      currentValue: position.inSeconds.toDouble(),
                      minText: durationToTimeString(position),
                      maxText: durationToTimeString(duration),
                      onChanged: (value) async {
                        final newPosition = Duration(seconds: value.toInt());
                        await audioPlayer.seek(newPosition);
                        await audioPlayer.resume();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA3C16F), // latar hijau muda
      body: _mainPage(context),
    );
  }
}
