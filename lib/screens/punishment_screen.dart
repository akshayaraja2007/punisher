import 'package:flutter/material.dart';
import '../core/discipline_state.dart';
import '../core/escalation_engine.dart';

class PunishmentScreen extends StatelessWidget {
  final DisciplineState state;

  const PunishmentScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    int reps = EscalationEngine.calculatePushups(state);

    return Scaffold(
      backgroundColor: Colors.red[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "LEVEL ${state.violationCount}",
              style: const TextStyle(
                  color: Colors.white, fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(
              "$reps PUSHUPS",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text("Completed"),
            )
          ],
        ),
      ),
    );
  }
}