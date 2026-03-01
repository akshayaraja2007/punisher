import 'discipline_state.dart';

class EscalationEngine {
  static int calculatePushups(DisciplineState state) {
    int base = 20;
    int multiplier = state.hardcoreMode ? 10 : 5;
    return base + (state.violationCount * multiplier);
  }
}