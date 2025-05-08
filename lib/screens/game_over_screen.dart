import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import 'menu_screen.dart';
import 'game_screen.dart';

class GameOverScreen extends StatelessWidget {
  final int score;

  const GameOverScreen({super.key, required this.score});

  Future<void> _saveHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    int currentHigh = prefs.getInt('highscore') ?? 0;
    if (score > currentHigh) {
      await prefs.setInt('highscore', score);
    }
  }

  @override
  Widget build(BuildContext context) {
    _saveHighScore();

    return Scaffold(
      backgroundColor: const Color.fromARGB(182, 132, 4, 211),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 32),
            const Text(
              'Game Over!',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Center(
              child: Column(
                children: [
                  Text(
                    'Your Score: $score',
                    style: const TextStyle(fontSize: 32, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const GameScreen()),
                      );
                    },
                    icon: const Icon(Icons.refresh),
                    iconSize: 80,
                    color: Colors.white,
                    tooltip: 'Restart',
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const MenuScreen()),
                      );
                    },
                    icon: const Icon(Icons.home),
                    label: const Text('Menu'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 43, 40, 40),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 24),
                  IconButton(
                    onPressed: () {
                      Share.share(
                        'I just got $score points in White Tile! 🧠🎮 You need to try this game!',
                        subject: 'White Tile Score',
                      );
                    },
                    icon: const Icon(Icons.share),
                    tooltip: 'Share',
                    iconSize: 32,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
