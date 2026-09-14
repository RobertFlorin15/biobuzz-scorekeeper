import 'package:flutter_riverpod/flutter_riverpod.dart';

class MatchScoreState {
  final int totalScore;

  final bool autoLeave;
  final bool autoPark;
  final int autoHiveTips;
  final int autoGardenElements;

  final int teleopHiveTips;
  final int teleopGardenElements;
  final bool teleopBottomNectar;
  final bool teleopFlowerOwner;
  final int teleopFlowerElements;

  final int postMatchCellElements;
  final bool postMatchPark;

  const MatchScoreState({
    this.totalScore = 0,
    this.autoLeave = false,
    this.autoPark = false,
    this.autoHiveTips = 0,
    this.autoGardenElements = 0,
    this.teleopHiveTips = 0,
    this.teleopGardenElements = 0,
    this.teleopBottomNectar = false,
    this.teleopFlowerOwner = false,
    this.teleopFlowerElements = 0,
    this.postMatchCellElements = 0,
    this.postMatchPark = false,
  });

  MatchScoreState copyWith({
    int? totalScore,
    bool? autoLeave,
    bool? autoPark,
    int? autoHiveTips,
    int? autoGardenElements,
    int? teleopHiveTips,
    int? teleopGardenElements,
    bool? teleopBottomNectar,
    bool? teleopFlowerOwner,
    int? teleopFlowerElements,
    int? postMatchCellElements,
    bool? postMatchPark,
  }) {
    return MatchScoreState(
      totalScore: totalScore ?? this.totalScore,
      autoLeave: autoLeave ?? this.autoLeave,
      autoPark: autoPark ?? this.autoPark,
      autoHiveTips: autoHiveTips ?? this.autoHiveTips,
      autoGardenElements: autoGardenElements ?? this.autoGardenElements,
      teleopHiveTips: teleopHiveTips ?? this.teleopHiveTips,
      teleopGardenElements: teleopGardenElements ?? this.teleopGardenElements,
      teleopBottomNectar: teleopBottomNectar ?? this.teleopBottomNectar,
      teleopFlowerOwner: teleopFlowerOwner ?? this.teleopFlowerOwner,
      teleopFlowerElements: teleopFlowerElements ?? this.teleopFlowerElements,
      postMatchCellElements:
          postMatchCellElements ?? this.postMatchCellElements,
      postMatchPark: postMatchPark ?? this.postMatchPark,
    );
  }
}

class ScoreNotifier extends Notifier<MatchScoreState> {
  @override
  MatchScoreState build() => const MatchScoreState();

  void _updateScore(MatchScoreState newState) {
    int newTotal = 0;

    // AUTO
    if (newState.autoLeave) newTotal += 3;
    if (newState.autoPark) newTotal += 5;
    newTotal += newState.autoHiveTips * 20;
    newTotal += newState.autoGardenElements * 1;

    // TELEOP
    newTotal += newState.teleopHiveTips * 20;
    newTotal += newState.teleopGardenElements * 1;
    if (newState.teleopBottomNectar) newTotal += 5;

    // FLOWER
    if (newState.teleopFlowerOwner) {
      newTotal += newState.teleopFlowerElements * 2;
    }

    newTotal += newState.postMatchCellElements * 2;
    if (newState.postMatchPark) newTotal += 5;

    state = newState.copyWith(totalScore: newTotal);
  }

  void toggleAutoLeave(bool value) =>
      _updateScore(state.copyWith(autoLeave: value));
  void toggleAutoPark(bool value) =>
      _updateScore(state.copyWith(autoPark: value));
  void incrementAutoHiveTips() =>
      _updateScore(state.copyWith(autoHiveTips: state.autoHiveTips + 1));
  void decrementAutoHiveTips() {
    if (state.autoHiveTips > 0)
      _updateScore(state.copyWith(autoHiveTips: state.autoHiveTips - 1));
  }

  void incrementAutoGardenElements() => _updateScore(
    state.copyWith(autoGardenElements: state.autoGardenElements + 1),
  );
  void decrementAutoGardenElements() {
    if (state.autoGardenElements > 0)
      _updateScore(
        state.copyWith(autoGardenElements: state.autoGardenElements - 1),
      );
  }

  void incrementTeleopHiveTips() =>
      _updateScore(state.copyWith(teleopHiveTips: state.teleopHiveTips + 1));
  void decrementTeleopHiveTips() {
    if (state.teleopHiveTips > 0)
      _updateScore(state.copyWith(teleopHiveTips: state.teleopHiveTips - 1));
  }

  void incrementTeleopGardenElements() => _updateScore(
    state.copyWith(teleopGardenElements: state.teleopGardenElements + 1),
  );
  void decrementTeleopGardenElements() {
    if (state.teleopGardenElements > 0)
      _updateScore(
        state.copyWith(teleopGardenElements: state.teleopGardenElements - 1),
      );
  }

  void toggleTeleopBottomNectar(bool value) =>
      _updateScore(state.copyWith(teleopBottomNectar: value));
  void toggleTeleopFlowerOwner(bool value) =>
      _updateScore(state.copyWith(teleopFlowerOwner: value));
  void incrementTeleopFlowerElements() => _updateScore(
    state.copyWith(teleopFlowerElements: state.teleopFlowerElements + 1),
  );
  void decrementTeleopFlowerElements() {
    if (state.teleopFlowerElements > 0)
      _updateScore(
        state.copyWith(teleopFlowerElements: state.teleopFlowerElements - 1),
      );
  }

  void incrementPostMatchCellElements() => _updateScore(
    state.copyWith(postMatchCellElements: state.postMatchCellElements + 1),
  );
  void decrementPostMatchCellElements() {
    if (state.postMatchCellElements > 0)
      _updateScore(
        state.copyWith(postMatchCellElements: state.postMatchCellElements - 1),
      );
  }

  void togglePostMatchPark(bool value) =>
      _updateScore(state.copyWith(postMatchPark: value));

  void resetScores() {
    state = const MatchScoreState();
  }
}

final scoreProvider = NotifierProvider<ScoreNotifier, MatchScoreState>(() {
  return ScoreNotifier();
});
