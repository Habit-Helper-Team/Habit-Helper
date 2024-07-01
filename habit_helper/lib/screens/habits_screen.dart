import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:habit_helper/habit-settings.dart';

import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:percent_indicator/percent_indicator.dart';
class Habits extends StatefulWidget {
  const Habits({super.key});
  @override
  State<Habits> createState() => _HabitsState();
}

class Habit {
  String title = "";
  double progress = 0;
  int target = 0;
  Habit({this.title = "", this.target = 0, this.progress = 0});
  void addProgress() {
    progress += 1;
  }

  bool isComplete() {
    return progress >= target;
  }

  toJson() {
    return {
      "title": title,
      "progress": progress,
      "target": target,
    };
  }

  fromJson(jsonData) {
    return Habit(
        title: jsonData['title'],
        progress: jsonData['progress'],
        target: jsonData['target']);
  }
}

class _HabitsState extends State<Habits> {
  List<Habit> habitsList = [];

  @override
  void initState() {
    super.initState();
    // setupHabit();
    habitsList.addAll([
      Habit(title: 'Something', target: 1),
      Habit(title: 'Anything 2', target: 2),
      Habit(title: '5 clicks', target: 5)
    ]);
  }

  late SharedPreferences prefs;
  List habits = [];
  setupHabit() async {
    prefs = await SharedPreferences.getInstance();
    String? stringHabit = await prefs.getString('habits');
    List habitList = jsonDecode(stringHabit ?? '');
    for (var todo in habitList) {
      setState(() {
        habits.add(Habit().fromJson(todo));
      });
    }
  }

  void saveHabit() {
    List items = habits.map((e) => e.toJson()).toList();
    prefs.setString('habits', jsonEncode(items));
  }

  void addHabit() async {
    Habit t = Habit(title: '', target: 0, progress: 0);
    setState(() {
      habits.add(t);
    });
    saveHabit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Habit Helper'),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        backgroundColor: const Color.fromARGB(255, 67, 67, 67),
        centerTitle: true,
      ),
      body: Container(
          color: Color(0xFF1A1F24),
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 16, vertical: 0),
          child: ListView.builder(
            itemCount: habitsList.length,
            itemBuilder: (BuildContext context, int index) {
              var habit = habitsList[index];
              return Column(children: [
                const SizedBox(
                  height: 12,
                ),
                AnimatedContainer(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      color:
                          !habit.isComplete() ? Colors.grey[800] : Colors.green,
                    ),
                    width: 400,
                    height: 80,
                    duration: const Duration(milliseconds: 200),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 270,
                                child: TextButton(
                                  onPressed: () {
                                    /*
                                          Put code to go and
                                          EDIT
                                          */
                                  },
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      habit.title,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: !habit.isComplete()
                                            ? FontWeight.normal
                                            : FontWeight.bold,
                                        fontSize: 24,
                                        color: !habit.isComplete()
                                            ? Colors.white
                                            : Colors.grey[800],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                  iconSize: 40,
                                  onPressed: () {
                                    if (!habit.isComplete()) {
                                      setState(() {
                                        habit.addProgress();
                                      });
                                    } else {
                                      return;
                                    }
                                  },
                                  icon: Icon(
                                    !habit.isComplete()
                                        ? Icons.check_circle
                                        : Icons.check_circle_outline,
                                    color: !habit.isComplete()
                                        ? Colors.grey[700]
                                        : Colors.lightGreenAccent,
                                  )),
                            ]),
                        SizedBox(
                          width: 500,
                          child: LinearProgressIndicator(
                            value: habit.progress / habit.target,
                            backgroundColor: Colors.grey[700],
                            color: Colors.lightGreenAccent,
                            borderRadius:
                                const BorderRadius.all(Radius.elliptical(5, 3)),
                            minHeight: 10,
                          ),
                        )
                      ],
                    )),
              ]);
            },
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF02B732),
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HabitSettingsPage()),
          );
        },
        shape: CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
