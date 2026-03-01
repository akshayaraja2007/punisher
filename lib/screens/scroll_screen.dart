import 'package:flutter/material.dart';
import '../core/discipline_state.dart';
import '../storage/hive_service.dart';
import 'punishment_screen.dart';

class ScrollScreen extends StatefulWidget {
  final DisciplineState state;

  const ScrollScreen({super.key, required this.state});

  @override
  State<ScrollScreen> createState() => _ScrollScreenState();
}

class _ScrollScreenState extends State<ScrollScreen> {
  int scrollCount = 0;

  void triggerViolation() {
    widget.state.violationCount++;
    widget.state.totalPunishments++;

    // Save without awaiting (cannot use async in onNotification)
    HiveService.saveState(widget.state);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => PunishmentScreen(state: widget.state),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            scrollCount++;

            if (scrollCount > 25) {
              triggerViolation();
            }
          }
          return true;
        },
        child: ListView.builder(
          itemCount: 50,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "Discipline > Distraction\nScroll $index",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}