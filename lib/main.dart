import 'package:flutter/material.dart';
import 'screens/menu_screen.dart';

void main() {
  runApp(const WhiteTileApp());
}

class WhiteTileApp extends StatelessWidget {
  const WhiteTileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'White Tile',
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const MenuScreen(),
    );
  }
}
