import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/timer_cubit.dart';
import '../models/timer_state.dart';
import '../widgets/timer_controls.dart';
import '../widgets/recorded_times.dart';

class TimerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Cronômetro', style: GoogleFonts.quicksand(color: Colors.white)),
        centerTitle: true,
        leading: Icon(Icons.timer_outlined, color: Colors.white,),
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<TimerCubit, TimerState>(
                  builder: (context, state) {
                    final milliseconds = state.duration % 1000;
                    final seconds = (state.duration ~/ 1000) % 60;
                    final minutes = (state.duration ~/ 60000) % 60;
                    final hours = (state.duration ~/ 3600000) % 24;
                    return Text(
                          '${minutes.toString().padLeft(2, '0')}:'
                          '${seconds.toString().padLeft(2, '0')}.'
                          '${(milliseconds ~/ 10).toString().padLeft(2, '0')}',
                      style: GoogleFonts.quicksand(fontSize: 48.0, color: Colors.white),
                    );
                  },
                ),
                SizedBox(height: 40),
                TimerControls(),
                SizedBox(height: 40),
                BlocBuilder<TimerCubit, TimerState>(
                  builder: (context, state) {
                    return RecordedTimes(recordedTimes: state.recordedTimes);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
