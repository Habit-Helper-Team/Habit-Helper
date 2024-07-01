import 'package:flutter/material.dart';
import 'package:habits_helper/screens/habits_screen.dart';
import 'package:habits_helper/screens/home_screen.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
    primaryColor: Colors.black45,
  ),
  home: Habits(),
));
