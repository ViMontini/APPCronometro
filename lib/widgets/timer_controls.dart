import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/timer_cubit.dart';
import '../models/timer_state.dart';

class TimerControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerCubit, TimerState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                if (state.isRunning) {
                  context.read<TimerCubit>().stopTimer();
                } else {
                  context.read<TimerCubit>().startTimer();
                }
              },
              child: Text(state.isRunning ? 'Pausar' : 'Iniciar'),
            ),
            SizedBox(width: 20),
            if (!state.isRunning)
              ElevatedButton(
                onPressed: () {
                  context.read<TimerCubit>().resetTimer();
                },
                child: Text('Resetar'),
              ),
            if (state.isRunning)
              SizedBox(width: 20),
            if (state.isRunning)
              ElevatedButton(
                onPressed: () {
                  context.read<TimerCubit>().recordTime();
                },
                child: Text('Gravar'),
              ),
          ],
        );
      },
    );
  }
}
