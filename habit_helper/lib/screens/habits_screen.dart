import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:habit_helper/Notificationservice.dart';
import 'package:habit_helper/habit-settings.dart';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
//import 'package:percent_indicator/percent_indicator.dart';
class Habits extends StatefulWidget {
  const Habits({super.key});
  @override
  State<Habits> createState() => _HabitsState();
}

class Habit {
  String title = "";
  int progress = 0;
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
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   @override
//   void initState() {
//     super.initState();
//     // Initialize the notification plugin
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon');
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//     );
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//     // Schedule the daily notification
//     _scheduleDailyNotification();
//   }
//   Future<void> _scheduleDailyNotification() async {
//     // Get the next instance of 10:00 AM
//     tz.TZDateTime scheduledDate = _nextInstanceOfTenAM();
//     // Define the notification details
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'daily notification channel id',
//       'daily notification channel name',
//       // 'daily notification description',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     // Schedule the notification
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       0,
//       'Title',
//       'Body',
//       scheduledDate,
//       platformChannelSpecifics,
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//     );
//   }
//   tz.TZDateTime _nextInstanceOfTenAM() {
//     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduledDate =
//         tz.TZDateTime(tz.local, now.year, now.month, now.day, 22, 0); // later
//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }
//     return scheduledDate;
//   }

  @override
  void initState() {
    super.initState();
    setupHabit();
  }

  late SharedPreferences prefs;
  List habits = [];
  Future setupHabit() async {
    String stringHabit = await fetchData();
    final habitList = jsonDecode(stringHabit);
    for (var todo in habitList) {
      setState(() {
        habits.add(Habit().fromJson(todo));
      });
    }
  }

  void saveHabit() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    List items = habits.map((e) => e.toJson()).toList();
    await prefs1.setString('habits', jsonEncode(items));
  }

  Future fetchData() async {
    final prefs1 = await SharedPreferences.getInstance();
    return prefs1.getString('habits') ?? '[]';
  }

  addHabit({String title = 'SLEEEP', int target = 1, int progress = 0}) async {
    Habit t = Habit(title: title, target: target, progress: progress);
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
            itemCount: habits.length,
            itemBuilder: (BuildContext context, int index) {
              var habit = habits[index];
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
                                      saveHabit();
                                    } else {
                                      setState(() {
                                        habits.remove(habit);
                                      });
                                      saveHabit();
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
                          height: 10,
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
          // addHabit();
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
