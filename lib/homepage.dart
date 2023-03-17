import 'dart:async';

import 'package:flutter/material.dart';

import 'package:habit_tracker/utils/habit_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List habitList = [
    ['Running', false, 0, 01],
    ['Workout', false, 0, 30],
    ['Meditate', false, 0, 15],
    ['Music', false, 0, 20],
    ['Coding', false, 0, 60],
    ['Cricket', false, 0, 02]
  ];

  void habitStared(int index) {
    var startTime = DateTime.now();

    int elapsedTime = habitList[index][2];

    setState(() {
      habitList[index][1] = !habitList[index][1];
    });

    if (habitList[index][1]) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (habitList[index][1] == false) {
            timer.cancel();
          }

          var currentTime = DateTime.now();
          habitList[index][2] = currentTime.second -
              startTime.second +
              60 * (currentTime.minute - startTime.minute) +
              60 * 60 * (currentTime.hour - startTime.hour);
        });
      });
    }
  }

  void settingsOpened(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: const Icon(Icons.lightbulb_outline),
        backgroundColor: Colors.grey[900],
        title: const Text('Just do it.'),
      ),
      body: ListView.builder(
        itemCount: habitList.length,
        itemBuilder: (context, index) {
          return HabitTile(
            habitName: habitList[index][0],
            onTap: () {
              habitStared(index);
            },
            settingsTapped: () {
              settingsOpened(index);
            },
            habitStarted: habitList[index][1],
            timeSpend: habitList[index][2],
            timeGoal: habitList[index][3],
          );
        },
      ),
    );
  }
}
