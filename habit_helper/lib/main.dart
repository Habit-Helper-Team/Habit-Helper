import 'package:flutter/material.dart';
import 'package:habit_helper/screens/habits_screen.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black45,
      ),
      home: Habits(),
      debugShowCheckedModeBanner: false,
    ));}


// import 'package:flutter/material.dart';
// import 'package:habit_helper/Notificationservice.dart';
// import 'package:habit_helper/screens/habits_screen.dart';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('app_icon');

//   final InitializationSettings initializationSettings =
//       InitializationSettings(
//     android: initializationSettingsAndroid,
//   );

//   await flutterLocalNotificationsPlugin.initialize(initializationSettings);

//   runApp(
//     MaterialApp(
//       theme: ThemeData(
//         primaryColor: Colors.black45,
//       ),
//       home: Habits(),
//       debugShowCheckedModeBanner: false,
//     ));
// }