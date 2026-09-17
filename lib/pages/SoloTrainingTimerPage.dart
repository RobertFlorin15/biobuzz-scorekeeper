import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scorekeeper_biobuzz/util/ScoreProvider.dart';
import 'package:scorekeeper_biobuzz/util/TimerProvider.dart';
import 'package:scorekeeper_biobuzz/widgets/CheckboxWidget.dart';
import 'package:scorekeeper_biobuzz/widgets/CounterWidget.dart';

class SoloTrainingTimerPage extends ConsumerWidget {
  const SoloTrainingTimerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scoreState = ref.watch(scoreProvider);
    final scoreNotifier = ref.read(scoreProvider.notifier);

    final timerState = ref.watch(timerProvider);
    final timerNotifier = ref.read(timerProvider.notifier);

    final bool isIdleOrFinished =
        timerState.phase == MatchPhase.idle ||
        timerState.phase == MatchPhase.finished;

    final bool canEditAuto =
        isIdleOrFinished || timerState.phase == MatchPhase.autonomous;
    final bool canEditTeleop =
        isIdleOrFinished || timerState.phase == MatchPhase.teleop;
    final bool canEditEndgame = isIdleOrFinished || timerState.isEndgame;
    final bool canEditPostMatch = isIdleOrFinished;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SOLO TIMER'),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset match',
            onPressed: () {
              scoreNotifier.resetScores();
              timerNotifier.resetTimer();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.black87,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      timerState.phase.name.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    Text(
                      '${timerState.timeRemaining}s',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isIdleOrFinished
                        ? Colors.greenAccent
                        : Colors.redAccent,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    if (isIdleOrFinished) {
                      timerNotifier.startMatch();
                      scoreNotifier.resetScores();
                    } else {
                      timerNotifier.resetTimer();
                      scoreNotifier.resetScores();
                    }
                  },
                  child: Text(
                    isIdleOrFinished ? 'START MATCH' : 'ABORT THE MATCH',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'TOTAL SCORE: ',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${scoreState.totalScore}',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                IgnorePointer(
                  ignoring: !canEditAuto,
                  child: Opacity(
                    opacity: canEditAuto ? 1.0 : 0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'AUTONOMOUS',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                        const Divider(thickness: 2),
                        CheckboxWidget(
                          label: 'LEAVE (3 pts)',
                          value: scoreState.autoLeave,
                          onChanged: (val) =>
                              scoreNotifier.toggleAutoLeave(val ?? false),
                        ),
                        CheckboxWidget(
                          label: 'PARK (5 pts)',
                          value: scoreState.autoPark,
                          onChanged: (val) =>
                              scoreNotifier.toggleAutoPark(val ?? false),
                        ),
                        CounterWidget(
                          label: 'HIVE TIPS (20 pts)',
                          count: scoreState.autoHiveTips,
                          onIncrement: () =>
                              scoreNotifier.incrementAutoHiveTips(),
                          onDecrement: () =>
                              scoreNotifier.decrementAutoHiveTips(),
                        ),
                        CounterWidget(
                          label: 'GARDEN Elements (1 pt)',
                          count: scoreState.autoGardenElements,
                          onIncrement: () =>
                              scoreNotifier.incrementAutoGardenElements(),
                          onDecrement: () =>
                              scoreNotifier.decrementAutoGardenElements(),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),

                IgnorePointer(
                  ignoring: !canEditTeleop,
                  child: Opacity(
                    opacity: canEditTeleop ? 1.0 : 0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'TELEOP',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        const Divider(thickness: 2),
                        CounterWidget(
                          label: 'HIVE TIPS (20 pts)',
                          count: scoreState.teleopHiveTips,
                          onIncrement: () =>
                              scoreNotifier.incrementTeleopHiveTips(),
                          onDecrement: () =>
                              scoreNotifier.decrementTeleopHiveTips(),
                        ),
                        CounterWidget(
                          label: 'GARDEN Elements (1 pt)',
                          count: scoreState.teleopGardenElements,
                          onIncrement: () =>
                              scoreNotifier.incrementTeleopGardenElements(),
                          onDecrement: () =>
                              scoreNotifier.decrementTeleopGardenElements(),
                        ),
                      ],
                    ),
                  ),
                ),

                IgnorePointer(
                  ignoring: !canEditEndgame,
                  child: Opacity(
                    opacity: canEditEndgame ? 1.0 : 0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                          child: Text(
                            'ENDGAME (Last 60s)',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                        CheckboxWidget(
                          label: 'Bottom NECTAR Bonus (5 pts)',
                          value: scoreState.teleopBottomNectar,
                          onChanged: (val) => scoreNotifier
                              .toggleTeleopBottomNectar(val ?? false),
                        ),
                        CheckboxWidget(
                          label: 'FLOWER Owner',
                          value: scoreState.teleopFlowerOwner,
                          onChanged: (val) => scoreNotifier
                              .toggleTeleopFlowerOwner(val ?? false),
                        ),
                        CounterWidget(
                          label: 'FLOWER Elements (2 pts)',
                          count: scoreState.teleopFlowerElements,
                          onIncrement: () =>
                              scoreNotifier.incrementTeleopFlowerElements(),
                          onDecrement: () =>
                              scoreNotifier.decrementTeleopFlowerElements(),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),

                IgnorePointer(
                  ignoring: !canEditPostMatch,
                  child: Opacity(
                    opacity: canEditPostMatch ? 1.0 : 0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'POST-MATCH',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const Divider(thickness: 2),
                        CounterWidget(
                          label: 'CELL Elements (2 pts)',
                          count: scoreState.postMatchCellElements,
                          onIncrement: () =>
                              scoreNotifier.incrementPostMatchCellElements(),
                          onDecrement: () =>
                              scoreNotifier.decrementPostMatchCellElements(),
                        ),
                        CheckboxWidget(
                          label: 'PARK (5 pts)',
                          value: scoreState.postMatchPark,
                          onChanged: (val) =>
                              scoreNotifier.togglePostMatchPark(val ?? false),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
