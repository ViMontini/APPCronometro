import 'package:flutter/material.dart';

class RecordedTimes extends StatelessWidget {
  final List<int> recordedTimes;

  RecordedTimes({required this.recordedTimes});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: recordedTimes.asMap().entries.map((entry) {
        int index = entry.key;
        int time = entry.value;
        final milliseconds = time % 1000;
        final seconds = (time ~/ 1000) % 60;
        final minutes = (time ~/ 60000) % 60;
        final hours = (time ~/ 3600000) % 24;
        return Text(
          '${index + 1}º - '
              '${minutes.toString().padLeft(2, '0')}:'
              '${seconds.toString().padLeft(2, '0')}:'
              '${(milliseconds ~/ 10).toString().padLeft(2, '0')}',
          style: TextStyle(fontSize: 24.0),
        );
      }).toList(),
    );
  }
}
