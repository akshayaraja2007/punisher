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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Discipline Score: ${state.disciplineScore}",
              style: const TextStyle(color: Colors.white, fontSize: 22),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ScrollScreen(state: state),
                  ),
                ).then((_) => setState(() {
                      state = HiveService.loadState();
                    }));
              },
              child: const Text("Start Scroll Mode"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DashboardScreen(),
                  ),
                ).then((_) => setState(() {
                      state = HiveService.loadState();
                    }));
              },
              child: const Text("Dashboard"),
            ),
          ],
        ),
      ),
    );
  }
}