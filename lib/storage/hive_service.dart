import 'package:hive_flutter/hive_flutter.dart';
import '../core/discipline_state.dart';

class HiveService {
  static const boxName = "disciplineBox";

  static Future init() async {
    await Hive.initFlutter();
    await Hive.openBox(boxName);
  }

  static DisciplineState loadState() {
    final box = Hive.box(boxName);
    final data = box.get("state");

    DisciplineState state;

    if (data == null) {
      state = DisciplineState(
        violationCount: 0,
        totalPunishments: 0,
        totalPushupsDone: 0,
        waterIntake: 0,
        dailyWaterTarget: 3000,
        hardcoreMode: false,
        lastReset: DateTime.now(),
      );
    } else {
      state =
          DisciplineState.fromMap(Map<String, dynamic>.from(data));
    }

    // Daily reset for hydration
    if (DateTime.now().difference(state.lastReset).inDays >= 1) {
      state.waterIntake = 0;
      state.lastReset = DateTime.now();
      saveState(state);
    }

    return state;
  }

  static Future saveState(DisciplineState state) async {
    final box = Hive.box(boxName);
    await box.put("state", state.toMap());
  }
}