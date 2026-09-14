import 'package:flutter/material.dart';
import 'package:scorekeeper_biobuzz/pages/SoloTrainingPage.dart';
import 'package:scorekeeper_biobuzz/pages/SoloTrainingTimerPage.dart';
import 'package:scorekeeper_biobuzz/widgets/ElevatedButtonStartPage.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/background_dark.png', fit: BoxFit.cover),
          Container(color: Colors.black.withValues(alpha: 0.4)),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 48.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),

                  const ElevatedButtonStartPage(
                    text: 'TRAINING SOLO TIMER',
                    destinationPage: SoloTrainingTimerPage(),
                  ),

                  const SizedBox(height: 16),

                  const ElevatedButtonStartPage(
                    text: 'TRAINING SOLO',
                    destinationPage: SoloTrainingPage(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
