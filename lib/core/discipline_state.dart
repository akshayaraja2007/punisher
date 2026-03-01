class DisciplineState {
  int violationCount;
  int totalPunishments;
  int totalPushupsDone;
  int waterIntake; // in ml
  int dailyWaterTarget;
  bool hardcoreMode;
  DateTime lastReset;

  DisciplineState({
    required this.violationCount,
    required this.totalPunishments,
    required this.totalPushupsDone,
    required this.waterIntake,
    required this.dailyWaterTarget,
    required this.hardcoreMode,
    required this.lastReset,
  });

  int get disciplineScore {
    int score = 100 - (violationCount * 2);
    return score < 0 ? 0 : score;
  }

  double get waterProgress =>
      dailyWaterTarget == 0 ? 0 : waterIntake / dailyWaterTarget;

  Map<String, dynamic> toMap() {
    return {
      'violationCount': violationCount,
      'totalPunishments': totalPunishments,
      'totalPushupsDone': totalPushupsDone,
      'waterIntake': waterIntake,
      'dailyWaterTarget': dailyWaterTarget,
      'hardcoreMode': hardcoreMode,
      'lastReset': lastReset.toIso8601String(),
    };
  }

  factory DisciplineState.fromMap(Map<String, dynamic> map) {
    return DisciplineState(
      violationCount: map['violationCount'] ?? 0,
      totalPunishments: map['totalPunishments'] ?? 0,
      totalPushupsDone: map['totalPushupsDone'] ?? 0,
      waterIntake: map['waterIntake'] ?? 0,
      dailyWaterTarget: map['dailyWaterTarget'] ?? 3000,
      hardcoreMode: map['hardcoreMode'] ?? false,
      lastReset: map['lastReset'] != null
          ? DateTime.parse(map['lastReset'])
          : DateTime.now(),
    );
  }
}