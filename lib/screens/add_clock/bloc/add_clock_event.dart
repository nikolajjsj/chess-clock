part of 'add_clock_bloc.dart';

abstract class AddClockEvent extends Equatable {
  const AddClockEvent();

  @override
  List<Object?> get props => [];
}

class AddCustomClock extends AddClockEvent {
  final ChessClock? chessClock;

  const AddCustomClock({this.chessClock});

  @override
  List<Object?> get props => [chessClock];
}

class RemoveCustomClock extends AddClockEvent {
  final int? index;

  const RemoveCustomClock({this.index});

  @override
  List<Object?> get props => [index];
}
