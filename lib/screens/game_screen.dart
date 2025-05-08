import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'game_over_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final int numCols = 4;
  final int numRows = 6;
  double get tileHeight => MediaQuery.of(context).size.height / numRows;
  final Random _random = Random();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioPlayer _losePlayer = AudioPlayer();
  final AudioPlayer _wowPlayer = AudioPlayer();
  late List<List<Tile>> tileGrid;
  double offset = 0;
  late Timer gameTimer;
  double speed = 2.0;
  int score = 0;
  bool isGameOver = false;

  @override
  void initState() {
    super.initState();
    _generateInitialGrid();
    _startGameLoop();
  }

  void _generateInitialGrid() {
    tileGrid = List.generate(numRows, (_) {
      int blackIndex = _random.nextInt(numCols);
      return List.generate(numCols, (index) {
        return Tile(isBlack: index == blackIndex);
      });
    });
  }

  void _startGameLoop() {
    gameTimer = Timer.periodic(const Duration(milliseconds: 16), (_) {
      setState(() {
        offset += speed;
        if (offset >= tileHeight) {
          offset = 0;
          _moveTilesDown();
          speed += 0.05;
        }
      });
    });
  }

  void _showStreakMessage(int score) {
    final streakMessages = [
      'Streak!',
      'Amazing!',
      '$score in a row!',
      'Keep it up!',
      'Unstoppable!',
    ];
    final message = streakMessages[_random.nextInt(streakMessages.length)];

    _playWowSound();

    final overlay = OverlayEntry(
      builder: (context) => Positioned(
        top: 80,
        left: 0,
        right: 0,
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 32,
                color: Color.fromARGB(182, 132, 4, 211),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlay);

    Future.delayed(const Duration(seconds: 1), () {
      overlay.remove();
    });
  }

  void _moveTilesDown() {
    // verificam daca pe ultimul rand exista vreo piesa neagra netap-ta
    final lastRow = tileGrid.last;
    final blackNotTapped = lastRow.any((tile) => tile.isBlack && !tile.tapped);

    if (blackNotTapped) {
      _playLoseSound();
      _endGame();
      return;
    }

    tileGrid.removeLast();
    int blackIndex = _random.nextInt(numCols);
    tileGrid.insert(
      0,
      List.generate(numCols, (i) => Tile(isBlack: i == blackIndex)),
    );
  }

  void _handleTap(int row, int col) {
    if (isGameOver) return;

    final tile = tileGrid[row][col];
    if (tile.tapped) return;

    tile.tapped = true;

    if (tile.isBlack) {
      _playSound();
      setState(() {
        score++;
      });

      if (score > 0 && score % 10 == 0) {
        _showStreakMessage(score);
      }
    } else {
      _playLoseSound();
      _endGame();
    }
  }

  Future<void> _playSound() async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource('sounds/tap.mp3'));
    } catch (_) {
      // ignoram daca nu se poate reda
    }
  }

  Future<void> _playLoseSound() async {
    try {
      await _losePlayer.stop();
      await _losePlayer.play(AssetSource('sounds/lose.mp3'));
    } catch (_) {
      // ignoram daca nu se poate reda
    }
  }

  Future<void> _playWowSound() async {
    try {
      await _wowPlayer.stop();
      await _wowPlayer.play(AssetSource('sounds/wow2.mp3'));
    } catch (_) {}
  }

  void _endGame() {
    gameTimer.cancel();
    setState(() {
      isGameOver = true;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => GameOverScreen(score: score)),
      );
    });
  }

  @override
  void dispose() {
    gameTimer.cancel();
    _audioPlayer.dispose();
    _losePlayer.dispose();
    _wowPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set the background color of the Scaffold to black
      body: Container(
        color: Colors.black,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenHeight = constraints.maxHeight;
            final dynamicTileHeight = screenHeight / numRows;

            return Stack(
              children: [
                Transform.translate(
                  offset: Offset(0, offset - dynamicTileHeight),
                  child: Column(
                    children: List.generate(numRows, (row) {
                      return Row(
                        children: List.generate(numCols, (col) {
                          final tile = tileGrid[row][col];
                          final color =
                              tile.tapped
                                  ? Colors.grey
                                  : tile.isBlack
                                      ? Colors.black
                                      : Colors.white;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () => _handleTap(row, col),
                              child: Container(
                                height: dynamicTileHeight,
                                color: color,
                              ),
                            ),
                          );
                        }),
                      );
                    }),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Score: $score',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Color.fromARGB(182, 132, 4, 211),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class Tile {
  bool isBlack;
  bool tapped;

  Tile({required this.isBlack, this.tapped = false});
}