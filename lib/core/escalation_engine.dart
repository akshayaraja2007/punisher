import 'discipline_state.dart';

class EscalationEngine {
  static int calculatePushups(DisciplineState state) {
    int base = 20;
    int multiplier = state.hardcoreMode ? 10 : 5;

    if (state.waterProgress < 1) {
      multiplier += 2; // penalty if hydration incomplete
    }

    return base + (state.violationCount * multiplier);
  }
}