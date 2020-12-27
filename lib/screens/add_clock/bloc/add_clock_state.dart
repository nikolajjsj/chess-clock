part of 'add_clock_bloc.dart';

abstract class AddClockState extends Equatable {
  const AddClockState();

  @override
  List<Object> get props => [];
}

class LoadingCustomClocks extends AddClockState {}

class CustomClocksLoaded extends AddClockState {
  final List<ChessClock> timers;

  const CustomClocksLoaded({this.timers});

  @override
  List<Object> get props => [timers];
}
