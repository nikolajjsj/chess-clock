import 'dart:async';
import 'package:chessclock/misc/models/clock_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'add_clock_event.dart';
part 'add_clock_state.dart';

class AddClockBloc extends HydratedBloc<AddClockEvent, AddClockState> {
  AddClockBloc() : super(NoCustomClocks());

  @override
  AddClockState fromJson(Map<String, dynamic> json) {
    if (json['timers'].isEmpty) return NoCustomClocks();
    List<ChessClock> _clocks = <ChessClock>[];
    for (var json in json['timers']) _clocks.add(ChessClock.fromJson(json));
    return CustomClocksLoaded(timers: _clocks);
  }

  @override
  Map<String, dynamic>? toJson(AddClockState state) {
    if (state is CustomClocksLoaded) {
      return {'timers': state.timers!.map((clock) => clock!.toJson()).toList()};
    }
    return null;
  }

  @override
  Stream<AddClockState> mapEventToState(
    AddClockEvent event,
  ) async* {
    final AddClockState oldState = state;

    if (event is AddCustomClock) {
      yield NoCustomClocks();
      if (oldState is CustomClocksLoaded) {
        List<ChessClock?> _timers = oldState.timers!;
        _timers.add(event.chessClock);
        yield CustomClocksLoaded(timers: _timers);
        return;
      }
      yield CustomClocksLoaded(timers: [event.chessClock]);
    } else if (event is RemoveCustomClock) {
      yield NoCustomClocks();
      if (oldState is CustomClocksLoaded) {
        List<ChessClock?> _timers = oldState.timers!;
        _timers.removeAt(event.index!);
        yield CustomClocksLoaded(timers: _timers);
        return;
      }
      yield CustomClocksLoaded(timers: []);
    }
  }
}
