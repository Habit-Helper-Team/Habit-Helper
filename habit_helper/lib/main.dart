import 'package:flutter/material.dart';
import 'package:habit_helper/screens/habits_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: HabitsHelperApp()));
}

class HabitsHelperApp extends StatelessWidget {
  const HabitsHelperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Helper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Habits(),
    );
  }
}
