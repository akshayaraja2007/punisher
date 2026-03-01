class DisciplineState {
  int violationCount;
  int totalPunishments;
  bool hardcoreMode;

  DisciplineState({
    required this.violationCount,
    required this.totalPunishments,
    required this.hardcoreMode,
  });

  int get disciplineScore {
    int score = 100 - (violationCount * 2);
    return score < 0 ? 0 : score;
  }

  Map<String, dynamic> toMap() {
    return {
      'violationCount': violationCount,
      'totalPunishments': totalPunishments,
      'hardcoreMode': hardcoreMode,
    };
  }

  factory DisciplineState.fromMap(Map<String, dynamic> map) {
    return DisciplineState(
      violationCount: map['violationCount'] ?? 0,
      totalPunishments: map['totalPunishments'] ?? 0,
      hardcoreMode: map['hardcoreMode'] ?? false,
    );
  }
}