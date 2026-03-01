import 'package:flutter/material.dart';
import '../storage/hive_service.dart';
import '../core/discipline_state.dart';
import 'scroll_screen.dart';
import 'dashboard_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DisciplineState state;

  @override
  void initState() {
    super.initState();
    state = HiveService.loadState();
  }

  void refresh() {
    setState(() {
      state = HiveService.loadState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "PUNISHER",
              style: TextStyle(
                color: Colors.red,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "Discipline Score: ${state.disciplineScore}",
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 30),
            LinearProgressIndicator(
              value: state.waterProgress > 1
                  ? 1
                  : state.waterProgress,
              backgroundColor: Colors.grey[800],
              color: Colors.blue,
              minHeight: 10,
            ),
            const SizedBox(height: 10),
            Text(
              "Water: ${state.waterIntake}ml / ${state.dailyWaterTarget}ml",
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                state.waterIntake += 250;
                await HiveService.saveState(state);
                refresh();
              },
              child: const Text("+250ml"),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize:
                      const Size(double.infinity, 50)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          ScrollScreen(state: state)),
                ).then((_) => refresh());
              },
              child: const Text("ENTER SCROLL MODE"),
            ),
            const SizedBox(height: 15),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  minimumSize:
                      const Size(double.infinity, 50)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          const DashboardScreen()),
                ).then((_) => refresh());
              },
              child: const Text("DASHBOARD"),
            ),
          ],
        ),
      ),
    );
  }
}