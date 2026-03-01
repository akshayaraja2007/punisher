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
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "VIOLATION",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              const SizedBox(height: 20),
              Text(
                "LEVEL ${state.violationCount}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Text(
                "$reps PUSHUPS",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text("COMPLETED"),
              )
            ],
          ),
        ),
      ),
    );
  }
}