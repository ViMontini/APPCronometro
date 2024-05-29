import 'dart:async';
import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late int _seconds;
  late bool _isRunning;

  @override
  void initState() {
    super.initState();
    _isRunning = false;
    _seconds = 0;
  }

  void _startTimer() {
    setState(() {
      _isRunning = true;
    });

    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _stopTimer() {
    setState(() {
      _isRunning = false;
    });
  }

  String _formatDuration(int seconds) {
    int hours = seconds ~/ 3600;
    int remainingSeconds = seconds % 3600;
    int minutes = remainingSeconds ~/ 60;
    int secs = remainingSeconds % 60;

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secsStr = secs.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secsStr';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _isRunning
                ? GestureDetector(
              onTap: () {
                if (_isRunning) {
                  _stopTimer();
                } else {
                  _startTimer();
                }
              },
              child: Text(
                _formatDuration(_seconds),
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            )
                : Text(
              '00:00:00',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isRunning ? null : _startTimer,
                  child: Text('Iniciar'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _stopTimer,
                  child: Text('Parar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
