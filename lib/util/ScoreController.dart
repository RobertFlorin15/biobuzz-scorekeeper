class ScoreController {
  int totalScore = 0;

  bool autoLeave = false;
  bool autoPark = false;
  int autoHiveTips = 0;
  int autoGardenElements = 0;

  int teleopHiveTips = 0;
  int teleopGardenElements = 0;
  bool teleopBottomNectar = false;
  bool teleopFlowerOwner = false;
  int teleopFlowerElements = 0;

  int postMatchCellElements = 0;
  bool postMatchPark = false;

  void _calculateTotalScore() {
    totalScore = 0;

    if (autoLeave) totalScore += 3;
    if (autoPark) totalScore += 5;
    totalScore += autoHiveTips * 20;
    totalScore += autoGardenElements * 1;

    totalScore += teleopHiveTips * 20;
    totalScore += teleopGardenElements * 1;
    if (teleopBottomNectar) totalScore += 5;
    if (teleopFlowerOwner) totalScore += teleopFlowerElements * 2;

    totalScore += postMatchCellElements * 2;
    if (postMatchPark) totalScore += 5;
  }

  void toggleAutoLeave(bool value) {
    autoLeave = value;
    _calculateTotalScore();
  }

  void toggleAutoPark(bool value) {
    autoPark = value;
    _calculateTotalScore();
  }

  void incrementAutoHiveTips() {
    autoHiveTips++;
    _calculateTotalScore();
  }

  void decrementAutoHiveTips() {
    if (autoHiveTips > 0) {
      autoHiveTips--;
      _calculateTotalScore();
    }
  }

  void incrementAutoGardenElements() {
    autoGardenElements++;
    _calculateTotalScore();
  }

  void decrementAutoGardenElements() {
    if (autoGardenElements > 0) {
      autoGardenElements--;
      _calculateTotalScore();
    }
  }

  void incrementTeleopHiveTips() {
    teleopHiveTips++;
    _calculateTotalScore();
  }

  void decrementTeleopHiveTips() {
    if (teleopHiveTips > 0) {
      teleopHiveTips--;
      _calculateTotalScore();
    }
  }

  void incrementTeleopGardenElements() {
    teleopGardenElements++;
    _calculateTotalScore();
  }

  void decrementTeleopGardenElements() {
    if (teleopGardenElements > 0) {
      teleopGardenElements--;
      _calculateTotalScore();
    }
  }

  void toggleTeleopBottomNectar(bool value) {
    teleopBottomNectar = value;
    _calculateTotalScore();
  }

  void toggleTeleopFlowerOwner(bool value) {
    teleopFlowerOwner = value;
    _calculateTotalScore();
  }

  void incrementTeleopFlowerElements() {
    teleopFlowerElements++;
    _calculateTotalScore();
  }

  void decrementTeleopFlowerElements() {
    if (teleopFlowerElements > 0) {
      teleopFlowerElements--;
      _calculateTotalScore();
    }
  }

  void incrementPostMatchCellElements() {
    postMatchCellElements++;
    _calculateTotalScore();
  }

  void decrementPostMatchCellElements() {
    if (postMatchCellElements > 0) {
      postMatchCellElements--;
      _calculateTotalScore();
    }
  }

  void togglePostMatchPark(bool value) {
    postMatchPark = value;
    _calculateTotalScore();
  }

  void resetScores() {
    autoLeave = false;
    autoPark = false;
    autoHiveTips = 0;
    autoGardenElements = 0;

    teleopHiveTips = 0;
    teleopGardenElements = 0;
    teleopBottomNectar = false;
    teleopFlowerOwner = false;
    teleopFlowerElements = 0;

    postMatchCellElements = 0;
    postMatchPark = false;

    _calculateTotalScore();
  }
}
