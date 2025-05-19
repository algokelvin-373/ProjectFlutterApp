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
    audioSource = AssetSource("cricket.wav");
    audioPlayer.setSource(audioSource);

    /// todo-05-url-01: if audio source from url
    // audioSource = UrlSource("https://github.com/dicodingacademy/assets/raw/main/flutter_intermediate_academy/bensound_ukulele.mp3");
    // audioPlayer.setSource(audioSource);

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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

        Consumer<AudioNotifier>(
          builder: (context, provider, child) {
            final bool isPlay = provider.isPlay;
            return AudioControllerWidget(
              onPlayTapped: () {
                audioPlayer.play(audioSource);
              },
              onPauseTapped: () {
                audioPlayer.pause();
              },
              onStopTapped: () {
                audioPlayer.stop();
              },
              isPlay: isPlay,
            );
          },
        ),
      ],
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
      appBar: AppBar(title: const Text("Audio Player Project")),
      body: _mainPage(context),
    );
  }
}
