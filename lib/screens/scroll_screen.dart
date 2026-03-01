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
  bool triggered = false;
  late DateTime startTime;

  @override
  void initState() {
    super.initState();
    startTime = DateTime.now();
  }

  void triggerViolation() {
    if (triggered) return;
    triggered = true;

    widget.state.violationCount++;
    widget.state.totalPunishments++;

    HiveService.saveState(widget.state);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => PunishmentScreen(state: widget.state),
      ),
    );
  }

  void checkTimeLimit() {
    if (DateTime.now().difference(startTime).inMinutes >= 5) {
      triggerViolation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Scroll Mode"),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          checkTimeLimit();
          if (notification is ScrollUpdateNotification) {
            scrollCount++;
            if (scrollCount > 25) {
              triggerViolation();
            }
          }
          return true;
        },
        child: ListView.builder(
          itemCount: 60,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius:
                    BorderRadius.circular(14),
              ),
              child: Text(
                "Future You is watching.\nScroll $index",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16),
              ),
            );
          },
        ),
      ),
    );
  }
}