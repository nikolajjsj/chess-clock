import 'dart:async';
import 'package:chessclock/misc/models/clock_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'add_clock_event.dart';
part 'add_clock_state.dart';

class AddClockBloc extends HydratedBloc<AddClockEvent, AddClockState> {
  AddClockBloc() : super(LoadingCustomClocks());

  @override
  AddClockState fromJson(Map<String, dynamic> json) {
    if (json['timers'].isEmpty) return LoadingCustomClocks();
    return CustomClocksLoaded(
      timers: json['timers'].map((json) => ChessClock.fromJson(json)).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson(AddClockState state) {
    if (state is CustomClocksLoaded) {
      return {'timers': state.timers.map((timer) => timer.toJson()).toList()};
    }
    return null;
  }

  @override
  Stream<AddClockState> mapEventToState(
    AddClockEvent event,
  ) async* {
    final oldState = state;

    if (event is AddCustomClock) {
      yield LoadingCustomClocks();
      if (oldState is CustomClocksLoaded) {
        List<ChessClock> _timers = oldState.timers;
        _timers.add(event.chessClock);
        yield CustomClocksLoaded(timers: _timers);
      }
      yield CustomClocksLoaded(timers: [event.chessClock]);
    } else if (event is RemoveCustomClock) {
      yield LoadingCustomClocks();
      if (oldState is CustomClocksLoaded) {
        List<ChessClock> _timers = oldState.timers;
        _timers.removeAt(event.index);
        yield CustomClocksLoaded(timers: _timers);
      }
      yield CustomClocksLoaded(timers: []);
    }
  }
}
