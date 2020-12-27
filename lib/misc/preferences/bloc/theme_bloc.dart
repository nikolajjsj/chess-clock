import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(light: false, followSystem: false));

  @override
  ThemeState fromJson(Map<String, dynamic> json) {
    bool light = json['light'] as bool;
    bool followSystem = json['followSystem'] as bool;

    return ThemeState(
      light: light ?? false,
      followSystem: followSystem ?? false,
    );
  }

  @override
  Map<String, dynamic> toJson(ThemeState state) {
    return {
      'light': state.light,
      'followSystem': state.followSystem,
    };
  }

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ChangeTheme) {
      yield ThemeState(
        light: event.light ?? false,
        followSystem: event.followSystem ?? false,
      );
    }
  }
}
