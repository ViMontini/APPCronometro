import 'package:bloc/bloc.dart';
import 'dart:async';
import '../models/timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(TimerState.initial());

  Timer? _timer;

  void startTimer() {
    if (state.isRunning) return;

    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      final newDuration = state.duration + 10;
      emit(state.copyWith(duration: newDuration));
    });

    emit(state.copyWith(isRunning: true));
  }

  void stopTimer() {
    _timer?.cancel();
    emit(state.copyWith(isRunning: false));
  }

  void resetTimer() {
    _timer?.cancel();
    emit(TimerState.initial());
  }

  void recordTime() {
    final newRecordedTimes = List<int>.from(state.recordedTimes)..add(state.duration);
    emit(state.copyWith(recordedTimes: newRecordedTimes));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
