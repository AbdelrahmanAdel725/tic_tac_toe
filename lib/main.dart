import 'package:flutter/material.dart';
import 'package:tic_tac_toe/app_route.dart';
import 'package:tic_tac_toe/game_screen.dart';

void main() {
  runApp(const AppRoute());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GameScreen(),
    );
  }
}
