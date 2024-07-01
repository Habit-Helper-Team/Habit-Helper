import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:habit_helper/habit-settings.dart';

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
  Habit(this.title, this.target);
  void addProgress() {
    progress += 1;
  }

  bool isComplete() {
    return progress >= target;
  }
}

class _HabitsState extends State<Habits> {
  List<Habit> habitsList = [];

  @override
  void initState() {
    super.initState();
    habitsList.addAll(
        [Habit('Something', 1), Habit('Anything 2', 2), Habit('5 clicks', 5)]);
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
                                        fontSize: 30,
                                        color: !habit.isComplete()
                                            ? Colors.purpleAccent[100]
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
        backgroundColor: Colors.green,
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