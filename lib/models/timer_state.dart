import 'package:equatable/equatable.dart';

class TimerState extends Equatable {
  final int duration; // Duration in milliseconds
  final bool isRunning;
  final List<int> recordedTimes;

  const TimerState({required this.duration, required this.isRunning, required this.recordedTimes});

  factory TimerState.initial() {
    return TimerState(duration: 0, isRunning: false, recordedTimes: []);
  }

  @override
  List<Object> get props => [duration, isRunning, recordedTimes];

  TimerState copyWith({int? duration, bool? isRunning, List<int>? recordedTimes}) {
    return TimerState(
      duration: duration ?? this.duration,
      isRunning: isRunning ?? this.isRunning,
      recordedTimes: recordedTimes ?? this.recordedTimes,
    );
  }
}
