import 'package:flutter/material.dart';
import 'package:scorekeeper_biobuzz/widgets/CheckboxWidget.dart';
import 'package:scorekeeper_biobuzz/widgets/CounterWidget.dart';
import 'package:scorekeeper_biobuzz/ScoreController.dart';

class SoloTrainingPage extends StatefulWidget {
  const SoloTrainingPage({super.key});

  @override
  State<SoloTrainingPage> createState() => _SoloTrainingPageState();
}

class _SoloTrainingPageState extends State<SoloTrainingPage> {
  final ScoreController _scoreController = ScoreController();

  Future<void> _showResetConfirmationDialog() async {
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
                setState(() {
                  _scoreController.resetScores();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SOLO TRAINING'),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset score',
            onPressed: _showResetConfirmationDialog,
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
                  '${_scoreController.totalScore}',
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
                  label: 'LEAVE (3 pts)',
                  value: _scoreController.autoLeave,
                  onChanged: (val) {
                    setState(() {
                      _scoreController.toggleAutoLeave(val ?? false);
                    });
                  },
                ),
                CheckboxWidget(
                  label: 'PARK (5 pts)',
                  value: _scoreController.autoPark,
                  onChanged: (val) {
                    setState(() {
                      _scoreController.toggleAutoPark(val ?? false);
                    });
                  },
                ),
                CounterWidget(
                  label: 'HIVE TIPS (20 pts)',
                  count: _scoreController.autoHiveTips,
                  onIncrement: () {
                    setState(() {
                      _scoreController.incrementAutoHiveTips();
                    });
                  },
                  onDecrement: () {
                    setState(() {
                      _scoreController.decrementAutoHiveTips();
                    });
                  },
                ),
                CounterWidget(
                  label: 'GARDEN Elements (1 pt)',
                  count: _scoreController.autoGardenElements,
                  onIncrement: () {
                    setState(() {
                      _scoreController.incrementAutoGardenElements();
                    });
                  },
                  onDecrement: () {
                    setState(() {
                      _scoreController.decrementAutoGardenElements();
                    });
                  },
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
                  count: _scoreController.teleopHiveTips,
                  onIncrement: () {
                    setState(() {
                      _scoreController.incrementTeleopHiveTips();
                    });
                  },
                  onDecrement: () {
                    setState(() {
                      _scoreController.decrementTeleopHiveTips();
                    });
                  },
                ),
                CounterWidget(
                  label: 'GARDEN Elements (1 pt)',
                  count: _scoreController.teleopGardenElements,
                  onIncrement: () {
                    setState(() {
                      _scoreController.incrementTeleopGardenElements();
                    });
                  },
                  onDecrement: () {
                    setState(() {
                      _scoreController.decrementTeleopGardenElements();
                    });
                  },
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
                  value: _scoreController.teleopBottomNectar,
                  onChanged: (val) {
                    setState(() {
                      _scoreController.toggleTeleopBottomNectar(val ?? false);
                    });
                  },
                ),
                CheckboxWidget(
                  label: 'FLOWER Owner (Required for score)',
                  value: _scoreController.teleopFlowerOwner,
                  onChanged: (val) {
                    setState(() {
                      _scoreController.toggleTeleopFlowerOwner(val ?? false);
                    });
                  },
                ),
                CounterWidget(
                  label: 'FLOWER Elements (2 pts)',
                  count: _scoreController.teleopFlowerElements,
                  onIncrement: () {
                    setState(() {
                      _scoreController.incrementTeleopFlowerElements();
                    });
                  },
                  onDecrement: () {
                    setState(() {
                      _scoreController.decrementTeleopFlowerElements();
                    });
                  },
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
                  count: _scoreController.postMatchCellElements,
                  onIncrement: () {
                    setState(() {
                      _scoreController.incrementPostMatchCellElements();
                    });
                  },
                  onDecrement: () {
                    setState(() {
                      _scoreController.decrementPostMatchCellElements();
                    });
                  },
                ),
                CheckboxWidget(
                  label: 'PARK (5 pts)',
                  value: _scoreController.postMatchPark,
                  onChanged: (val) {
                    setState(() {
                      _scoreController.togglePostMatchPark(val ?? false);
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
