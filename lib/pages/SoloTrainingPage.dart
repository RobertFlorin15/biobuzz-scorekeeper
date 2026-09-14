import 'package:flutter/material.dart';

class SoloTrainingPage extends StatefulWidget {
  const SoloTrainingPage({super.key});

  @override
  State<SoloTrainingPage> createState() => _SoloTrainingPageState();
}

class _SoloTrainingPageState extends State<SoloTrainingPage> {
  int _totalScore = 0;

  bool _autoLeave = false;
  bool _autoPark = false;
  int _autoHiveTips = 0;
  int _autoGardenElements = 0;

  int _teleopHiveTips = 0;
  int _teleopGardenElements = 0;
  bool _teleopBottomNectar = false;
  bool _teleopFlowerOwner = false;
  int _teleopFlowerElements = 0;

  int _postMatchCellElements = 0;
  bool _postMatchPark = false;

  void _calculateTotalScore() {
    setState(() {
      _totalScore = 0;
      if (_autoLeave) _totalScore += 3;
      if (_autoPark) _totalScore += 5;
      _totalScore += _autoHiveTips * 20;
      _totalScore += _autoGardenElements * 1;

      _totalScore += _teleopHiveTips * 20;
      _totalScore += _teleopGardenElements * 1;
      if (_teleopBottomNectar) _totalScore += 5;
      _totalScore += _teleopFlowerElements * 2;

      _totalScore += _postMatchCellElements * 2;
      if (_postMatchPark) _totalScore += 5;
    });
  }

  void _resetScores() {
    setState(() {
      _totalScore = 0;

      _autoLeave = false;
      _autoPark = false;
      _autoHiveTips = 0;
      _autoGardenElements = 0;

      _teleopHiveTips = 0;
      _teleopGardenElements = 0;
      _teleopBottomNectar = false;
      _teleopFlowerOwner = false;
      _teleopFlowerElements = 0;

      _postMatchCellElements = 0;
      _postMatchPark = false;
    });
  }

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
                _resetScores();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildCounterItem(
    String label,
    int count,
    VoidCallback onIncrement,
    VoidCallback onDecrement,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: onDecrement,
            ),
            Text(
              count.toString(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: onIncrement,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCheckboxItem(
    String label,
    bool value,
    ValueChanged<bool?> onChanged,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        Checkbox(value: value, onChanged: onChanged),
      ],
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
                  '$_totalScore',
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
                _buildCheckboxItem('LEAVE (3 pts)', _autoLeave, (val) {
                  setState(() => _autoLeave = val ?? false);
                  _calculateTotalScore();
                }),
                _buildCheckboxItem('PARK (5 pts)', _autoPark, (val) {
                  setState(() => _autoPark = val ?? false);
                  _calculateTotalScore();
                }),
                _buildCounterItem(
                  'HIVE TIPS (20 pts)',
                  _autoHiveTips,
                  () {
                    setState(() => _autoHiveTips++);
                    _calculateTotalScore();
                  },
                  () {
                    if (_autoHiveTips > 0) setState(() => _autoHiveTips--);
                    _calculateTotalScore();
                  },
                ),
                _buildCounterItem(
                  'GARDEN Elements (1 pt)',
                  _autoGardenElements,
                  () {
                    setState(() => _autoGardenElements++);
                    _calculateTotalScore();
                  },
                  () {
                    if (_autoGardenElements > 0)
                      setState(() => _autoGardenElements--);
                    _calculateTotalScore();
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
                _buildCounterItem(
                  'HIVE TIPS (20 pts)',
                  _teleopHiveTips,
                  () {
                    setState(() => _teleopHiveTips++);
                    _calculateTotalScore();
                  },
                  () {
                    if (_teleopHiveTips > 0) setState(() => _teleopHiveTips--);
                    _calculateTotalScore();
                  },
                ),
                _buildCounterItem(
                  'GARDEN Elements (1 pt)',
                  _teleopGardenElements,
                  () {
                    setState(() => _teleopGardenElements++);
                    _calculateTotalScore();
                  },
                  () {
                    if (_teleopGardenElements > 0)
                      setState(() => _teleopGardenElements--);
                    _calculateTotalScore();
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
                _buildCheckboxItem(
                  'Bottom NECTAR Bonus (5 pts)',
                  _teleopBottomNectar,
                  (val) {
                    setState(() => _teleopBottomNectar = val ?? false);
                    _calculateTotalScore();
                  },
                ),
                _buildCheckboxItem(
                  'FLOWER Owner (Required for score)',
                  _teleopFlowerOwner,
                  (val) {
                    setState(() => _teleopFlowerOwner = val ?? false);
                  },
                ),
                _buildCounterItem(
                  'FLOWER Elements (2 pts)',
                  _teleopFlowerElements,
                  () {
                    setState(() => _teleopFlowerElements++);
                    _calculateTotalScore();
                  },
                  () {
                    if (_teleopFlowerElements > 0)
                      setState(() => _teleopFlowerElements--);
                    _calculateTotalScore();
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
                _buildCounterItem(
                  'CELL Elements (2 pts)',
                  _postMatchCellElements,
                  () {
                    setState(() => _postMatchCellElements++);
                    _calculateTotalScore();
                  },
                  () {
                    if (_postMatchCellElements > 0)
                      setState(() => _postMatchCellElements--);
                    _calculateTotalScore();
                  },
                ),
                _buildCheckboxItem('PARK (5 pts)', _postMatchPark, (val) {
                  setState(() => _postMatchPark = val ?? false);
                  _calculateTotalScore();
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
