import 'package:flutter/material.dart';
import 'package:scorekeeper_biobuzz/pages/SoloTrainingPage.dart';
import 'package:scorekeeper_biobuzz/pages/SoloTrainingTimerPage.dart';
import 'package:scorekeeper_biobuzz/widgets/ElevatedButtonStartPage.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final isDesktop = size.width > size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            isDesktop
                ? 'assets/images/background_windows.png'
                : 'assets/images/background.png',
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withValues(alpha: 0.4)),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 48.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Center(
                      child: Image.asset(
                        'assets/images/white_logo_biobuzz.png',
                        width: 300,
                      ),
                    ),
                  ),

                  const ElevatedButtonStartPage(
                    text: 'SOLO TIMER',
                    destinationPage: SoloTrainingTimerPage(),
                  ),

                  const SizedBox(height: 16),

                  const ElevatedButtonStartPage(
                    text: 'SOLO',
                    destinationPage: SoloTrainingPage(),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Unofficial community app developed by Robert | 19061am 17962m 19075m 30324m. Not affiliated with FIRST or RTX.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
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
