import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _habitsKey = 'habitsKey';
  /*Future<void> saveHabits(List<Habit> someList) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setIntList(_habitsKey, someList.map((e) => e.title).toList());
  }

  Future<double> getHabits() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_habitsKey);
  }
  */
}

class Habit {
  String title = "";
  double progress = 0;
  int target = 0;
  Habit(this.title, this.target);
}
