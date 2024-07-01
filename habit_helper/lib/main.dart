import 'package:flutter/material.dart';
import 'package:habit_helper/screens/habits_screen.dart';
import 'package:habit_helper/screens/home_screen.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black45,
      ),
      home: Habits(),
    ));
