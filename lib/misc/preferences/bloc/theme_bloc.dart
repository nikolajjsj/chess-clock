import 'dart:async';
import 'package:chessclock/misc/preferences/models/app_theme.dart';
import 'package:chessclock/misc/preferences/models/default_themes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(
          id: 0,
          themeData: predefinedThemes[0].data,
          followSystem: false,
        ));

  @override
  ThemeState fromJson(Map<String, dynamic> json) {
    int themeId = json['theme'] as int ?? 0;
    bool followSystem = json['followSystem'] ?? false;
    return ThemeState(
      id: themeId,
      themeData: themes[themeId].data,
      followSystem: followSystem,
    );
  }

  @override
  Map<String, dynamic> toJson(ThemeState state) {
    return {
      'theme': state.id,
      'followSystem': state.followSystem,
    };
  }

  List<AppTheme> themes = predefinedThemes;

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ChangeTheme) {
      yield ThemeState(
        id: event.id,
        themeData: themes[event.id].data,
        followSystem: event.followSystem ?? true,
      );
    }
  }
}
