import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late int _seconds;
  late bool _isRunning;
  Timer? _timer;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _isRunning = false;
    _seconds = 0;
    _initializeNotifications();
  }

  void _resetTimer() {
    if (_isRunning) {
      setState(() {
        _isRunning = false;
        _timer?.cancel();
        _seconds = 0;
      });
    } else {
      setState(() {
        _seconds = 0;
      });
    }
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _isRunning = true;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _timer?.cancel();
          _isRunning = false;
          _showNotification();
          _playAlarm();
        }
      });
    });
  }

  void _stopTimer() {
    setState(() {
      _isRunning = false;
      _timer?.cancel();
    });
  }

  void _editTime() {
    _stopTimer();
    int hours = _seconds ~/ 3600;
    int remainingSeconds = _seconds % 3600;
    int minutes = remainingSeconds ~/ 60;
    int secs = remainingSeconds % 60;

    TextEditingController hoursController = TextEditingController(text: hours.toString().padLeft(2, '0'));
    TextEditingController minutesController = TextEditingController(text: minutes.toString().padLeft(2, '0'));
    TextEditingController secondsController = TextEditingController(text: secs.toString().padLeft(2, '0'));

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Definir Tempo'),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTimeField(hoursController, 'hrs'),
            Text(':'),
            _buildTimeField(minutesController, 'min'),
            Text(':'),
            _buildTimeField(secondsController, 'seg'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                int newHours = int.tryParse(hoursController.text) ?? 0;
                int newMinutes = int.tryParse(minutesController.text) ?? 0;
                int newSeconds = int.tryParse(secondsController.text) ?? 0;
                _seconds = newHours * 3600 + newMinutes * 60 + newSeconds;
              });
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeField(TextEditingController controller, String label) {
    return Container(
      width: 50,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: '00',
          labelText: label,
        ),
      ),
    );
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

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'timer_channel',
      'Timer Notifications',
      channelDescription: 'Notification channel for timer',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Timer',
      'O tempo acabou!',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  void _playAlarm() {
    audioPlayer.play(AssetSource('alarm.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Timer', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: Icon(Icons.hourglass_top, color: Colors.white,),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _editTime,
                child: Text(
                  _formatDuration(_seconds),
                  style: GoogleFonts.quicksand(fontSize: 48.0, color: Colors.white),
                ),
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
                    onPressed: _isRunning ? _stopTimer : null,
                    child: Text('Parar'),
                  ),
                  SizedBox(width: 20),
                  if (_isRunning)
                    ElevatedButton(
                      onPressed: _resetTimer,
                      child: Text('Resetar'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
