import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scorekeeper_biobuzz/widgets/CheckboxWidget.dart';
import 'package:scorekeeper_biobuzz/widgets/CounterWidget.dart';
import 'package:scorekeeper_biobuzz/util/ScoreProvider.dart';

class DuoTrainingPage extends ConsumerWidget {
  const DuoTrainingPage({super.key});

  Future<void> _showResetConfirmationDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Score reset'),
          content: const Text(
            'This will reset all scores to 0. Are you sure you want to continue?',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('RESET', style: TextStyle(color: Colors.red)),
              onPressed: () {
                ref.read(scoreProvider.notifier).resetScores();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scoreState = ref.watch(scoreProvider);
    final scoreNotifier = ref.read(scoreProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('DUO TRAINING'),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset score',
            onPressed: () => _showResetConfirmationDialog(context, ref),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
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
                  label: 'LEAVE (R1) (3 pts)',
                  value: scoreState.autoLeaveR1,
                  onChanged: (val) =>
                      scoreNotifier.toggleAutoLeaveR1(val ?? false),
                ),
                CheckboxWidget(
                  label: 'LEAVE (R2) (3 pts)',
                  value: scoreState.autoLeaveR2,
                  onChanged: (val) =>
                      scoreNotifier.toggleAutoLeaveR2(val ?? false),
                ),
                CheckboxWidget(
                  label: 'PARK (R1) (5 pts)',
                  value: scoreState.autoParkR1,
                  onChanged: (val) =>
                      scoreNotifier.toggleAutoParkR1(val ?? false),
                ),
                CheckboxWidget(
                  label: 'PARK (R2) (5 pts)',
                  value: scoreState.autoParkR2,
                  onChanged: (val) =>
                      scoreNotifier.toggleAutoParkR2(val ?? false),
                ),
                CounterWidget(
                  label: 'HIVE TIPS (20 pts)',
                  count: scoreState.autoHiveTips,
                  onIncrement: () => scoreNotifier.incrementAutoHiveTips(),
                  onDecrement: () => scoreNotifier.decrementAutoHiveTips(),
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
                  onIncrement: () => scoreNotifier.incrementTeleopHiveTips(),
                  onDecrement: () => scoreNotifier.decrementTeleopHiveTips(),
                ),
                CounterWidget(
                  label: 'GARDEN Elements (1 pt)',
                  count: scoreState.teleopGardenElements,
                  onIncrement: () =>
                      scoreNotifier.incrementTeleopGardenElements(),
                  onDecrement: () =>
                      scoreNotifier.decrementTeleopGardenElements(),
                ),

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
                  onChanged: (val) =>
                      scoreNotifier.toggleTeleopBottomNectar(val ?? false),
                ),
                CheckboxWidget(
                  label: 'FLOWER Owner (Required for score)',
                  value: scoreState.teleopFlowerOwner,
                  onChanged: (val) =>
                      scoreNotifier.toggleTeleopFlowerOwner(val ?? false),
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
                  label: 'PARK (R1) (5 pts)',
                  value: scoreState.postMatchParkR1,
                  onChanged: (val) =>
                      scoreNotifier.togglePostMatchParkR1(val ?? false),
                ),
                CheckboxWidget(
                  label: 'PARK (R2) (5 pts)',
                  value: scoreState.postMatchParkR2,
                  onChanged: (val) =>
                      scoreNotifier.togglePostMatchParkR2(val ?? false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
