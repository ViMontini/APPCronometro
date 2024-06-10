import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LocalClockPage extends StatefulWidget {
  @override
  _LocalClockPageState createState() => _LocalClockPageState();
}

class _LocalClockPageState extends State<LocalClockPage> {
  late String _currentTime;

  @override
  void initState() {
    super.initState();
    _updateTime();
    Timer.periodic(Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  void _updateTime() {
    setState(() {
      _currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Horário Local', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: Icon(Icons.access_time, color: Colors.white,),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.lightBlueAccent],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                _currentTime,
                style: TextStyle(fontSize: 48, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
