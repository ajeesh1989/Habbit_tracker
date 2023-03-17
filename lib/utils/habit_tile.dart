import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final VoidCallback onTap;
  final VoidCallback settingsTapped;
  final int timeSpend;
  final int timeGoal;
  final bool habitStarted;

  const HabitTile(
      {super.key,
      required this.habitName,
      required this.onTap,
      required this.settingsTapped,
      required this.timeGoal,
      required this.timeSpend,
      required this.habitStarted});

  String formatToMinSec(int totalSeconds) {
    String secs = (totalSeconds % 60).toString();
    String mins = (totalSeconds / 60).toStringAsFixed(5);
    if (secs.length == 1) {
      secs = '0' + secs;
    }

    if (mins[1] == '.') {
      mins = mins.substring(0, 1);
    }
    return mins + ':' + secs;
  }

  double percentCompleted() {
    return timeSpend / (timeGoal * 60);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Stack(
                      children: [
                        CircularPercentIndicator(
                          radius: 50,
                          percent:
                              percentCompleted() < 1 ? percentCompleted() : 1,
                          progressColor: percentCompleted() > 0.5
                              ? (percentCompleted() > 0.75
                                  ? Colors.green
                                  : Colors.orange)
                              : Colors.red,
                        ),
                        Center(
                            child: Icon(
                                habitStarted ? Icons.pause : Icons.play_arrow))
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      habitName,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      formatToMinSec(timeSpend) +
                          '  /  ' +
                          timeGoal.toString() +
                          ' = ' +
                          (percentCompleted() * 100).toStringAsFixed(0) +
                          '%',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ],
            ),
            GestureDetector(onTap: settingsTapped, child: Icon(Icons.settings))
          ],
        ),
      ),
    );
  }
}
