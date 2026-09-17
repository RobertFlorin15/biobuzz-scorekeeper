import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';

enum MatchPhase { idle, preMatch, autonomous, transition, teleop, finished }

class MatchTimerState {
  final MatchPhase phase;
  final int timeRemaining;

  MatchTimerState({required this.phase, required this.timeRemaining});

  bool get isEndgame => phase == MatchPhase.teleop && timeRemaining <= 60;
}

class TimerNotifier extends Notifier<MatchTimerState> {
  Timer? _timer;

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  MatchTimerState build() {
    return MatchTimerState(phase: MatchPhase.idle, timeRemaining: 0);
  }

  void startMatch() {
    _timer?.cancel();

    _playSound('sounds/3-2-1-go.mp3');

    state = MatchTimerState(phase: MatchPhase.preMatch, timeRemaining: 3);
    _timer = Timer.periodic(const Duration(seconds: 1), _tick);
  }

  void _tick(Timer timer) {
    if (state.timeRemaining > 1) {
      if (state.phase == MatchPhase.teleop && state.timeRemaining == 61) {
        _playSound('sounds/endgame.mp3');
      }

      if (state.phase == MatchPhase.teleop && state.timeRemaining == 21) {
        _playSound('sounds/endgame.mp3');
      }

      state = MatchTimerState(
        phase: state.phase,
        timeRemaining: state.timeRemaining - 1,
      );
    } else {
      _advancePhase();
    }
  }

  void _advancePhase() {
    switch (state.phase) {
      case MatchPhase.preMatch:
        state = MatchTimerState(
          phase: MatchPhase.autonomous,
          timeRemaining: 30,
        );
        break;

      case MatchPhase.autonomous:
        _playSound('sounds/8s_pause.mp3');
        state = MatchTimerState(phase: MatchPhase.transition, timeRemaining: 8);
        break;

      case MatchPhase.transition:
        state = MatchTimerState(phase: MatchPhase.teleop, timeRemaining: 120);
        break;

      case MatchPhase.teleop:
        _playSound('sounds/final.mp3');
        state = MatchTimerState(phase: MatchPhase.finished, timeRemaining: 0);
        _timer?.cancel();
        break;

      default:
        _timer?.cancel();
    }
  }

  void resetTimer() {
    _timer?.cancel();
    _audioPlayer.stop();
    state = MatchTimerState(phase: MatchPhase.idle, timeRemaining: 0);
  }

  Future<void> _playSound(String path) async {
    await _audioPlayer.play(AssetSource(path));
  }
}

final timerProvider = NotifierProvider<TimerNotifier, MatchTimerState>(() {
  return TimerNotifier();
});
