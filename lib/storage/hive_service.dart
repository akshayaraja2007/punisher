import 'package:hive_flutter/hive_flutter.dart';
import '../core/discipline_state.dart';

class HiveService {
  static const String boxName = "disciplineBox";

  static Future init() async {
    await Hive.initFlutter();
    await Hive.openBox(boxName);
  }

  static Future saveState(DisciplineState state) async {
    final box = Hive.box(boxName);
    await box.put("state", state.toMap());
  }

  static DisciplineState loadState() {
    final box = Hive.box(boxName);
    final data = box.get("state");

    if (data == null) {
      return DisciplineState(
        violationCount: 0,
        totalPunishments: 0,
        hardcoreMode: false,
      );
    }

    return DisciplineState.fromMap(Map<String, dynamic>.from(data));
  }
}