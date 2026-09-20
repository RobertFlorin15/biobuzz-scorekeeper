import 'package:flutter_riverpod/flutter_riverpod.dart';

class MatchScoreState {
  final int totalScore;

  final bool autoLeaveR1;
  final bool autoLeaveR2;
  final bool autoParkR1;
  final bool autoParkR2;
  final int autoHiveTips;
  final int autoGardenElements;

  final int teleopHiveTips;
  final int teleopGardenElements;
  final bool teleopBottomNectar;
  final bool teleopFlowerOwner;
  final int teleopFlowerElements;

  final int postMatchCellElements;
  final bool postMatchParkR1;
  final bool postMatchParkR2;

  const MatchScoreState({
    this.totalScore = 0,
    this.autoLeaveR1 = false,
    this.autoLeaveR2 = false,
    this.autoParkR1 = false,
    this.autoParkR2 = false,
    this.autoHiveTips = 0,
    this.autoGardenElements = 0,
    this.teleopHiveTips = 0,
    this.teleopGardenElements = 0,
    this.teleopBottomNectar = false,
    this.teleopFlowerOwner = false,
    this.teleopFlowerElements = 0,
    this.postMatchCellElements = 0,
    this.postMatchParkR1 = false,
    this.postMatchParkR2 = false,
  });

  MatchScoreState copyWith({
    int? totalScore,
    bool? autoLeaveR1,
    bool? autoLeaveR2,
    bool? autoParkR1,
    bool? autoParkR2,
    int? autoHiveTips,
    int? autoGardenElements,
    int? teleopHiveTips,
    int? teleopGardenElements,
    bool? teleopBottomNectar,
    bool? teleopFlowerOwner,
    int? teleopFlowerElements,
    int? postMatchCellElements,
    bool? postMatchParkR1,
    bool? postMatchParkR2,
  }) {
    return MatchScoreState(
      totalScore: totalScore ?? this.totalScore,
      autoLeaveR1: autoLeaveR1 ?? this.autoLeaveR1,
      autoLeaveR2: autoLeaveR2 ?? this.autoLeaveR2,
      autoParkR1: autoParkR1 ?? this.autoParkR1,
      autoParkR2: autoParkR2 ?? this.autoParkR2,
      autoHiveTips: autoHiveTips ?? this.autoHiveTips,
      autoGardenElements: autoGardenElements ?? this.autoGardenElements,
      teleopHiveTips: teleopHiveTips ?? this.teleopHiveTips,
      teleopGardenElements: teleopGardenElements ?? this.teleopGardenElements,
      teleopBottomNectar: teleopBottomNectar ?? this.teleopBottomNectar,
      teleopFlowerOwner: teleopFlowerOwner ?? this.teleopFlowerOwner,
      teleopFlowerElements: teleopFlowerElements ?? this.teleopFlowerElements,
      postMatchCellElements:
          postMatchCellElements ?? this.postMatchCellElements,
      postMatchParkR1: postMatchParkR1 ?? this.postMatchParkR1,
      postMatchParkR2: postMatchParkR2 ?? this.postMatchParkR2,
    );
  }
}

class ScoreNotifier extends Notifier<MatchScoreState> {
  @override
  MatchScoreState build() => const MatchScoreState();

  void _updateScore(MatchScoreState newState) {
    int newTotal = 0;

    // AUTO
    if (newState.autoLeaveR1) newTotal += 3;
    if (newState.autoLeaveR2) newTotal += 3;
    if (newState.autoParkR1) newTotal += 5;
    if (newState.autoParkR2) newTotal += 5;
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
    if (newState.postMatchParkR1) newTotal += 5;
    if (newState.postMatchParkR2) newTotal += 5;

    state = newState.copyWith(totalScore: newTotal);
  }

  void toggleAutoLeaveR1(bool value) =>
      _updateScore(state.copyWith(autoLeaveR1: value));
  void toggleAutoParkR1(bool value) =>
      _updateScore(state.copyWith(autoParkR1: value));
  void toggleAutoLeaveR2(bool value) =>
      _updateScore(state.copyWith(autoLeaveR2: value));
  void toggleAutoParkR2(bool value) =>
      _updateScore(state.copyWith(autoParkR2: value));
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

  void togglePostMatchParkR1(bool value) =>
      _updateScore(state.copyWith(postMatchParkR1: value));

  void togglePostMatchParkR2(bool value) =>
      _updateScore(state.copyWith(postMatchParkR2: value));

  void resetScores() {
    state = const MatchScoreState();
  }
}

final scoreProvider = NotifierProvider<ScoreNotifier, MatchScoreState>(() {
  return ScoreNotifier();
});
