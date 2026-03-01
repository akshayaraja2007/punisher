import 'package:flutter/material.dart';
import '../storage/hive_service.dart';
import '../core/discipline_state.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState
    extends State<DashboardScreen> {
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
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text("Violations: ${state.violationCount}",
                style: const TextStyle(
                    color: Colors.white)),
            const SizedBox(height: 10),
            Text(
                "Total Punishments: ${state.totalPunishments}",
                style: const TextStyle(
                    color: Colors.white)),
            const SizedBox(height: 10),
            Text(
                "Total Pushups Done: ${state.totalPushupsDone}",
                style: const TextStyle(
                    color: Colors.white)),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text("Hardcore Mode",
                  style: TextStyle(
                      color: Colors.white)),
              value: state.hardcoreMode,
              onChanged: (val) async {
                state.hardcoreMode = val;
                await HiveService.saveState(state);
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}