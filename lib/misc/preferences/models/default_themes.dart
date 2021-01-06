import 'package:chessclock/misc/preferences/models/app_theme.dart';
import 'package:chessclock/misc/preferences/models/theme_model.dart';

/// A list of [Theme]s
final List<AppTheme> predefinedThemes = <AppTheme>[
  AppTheme.fromData(_default),
  AppTheme.fromData(light),
  AppTheme.fromData(amoled),
  AppTheme.fromData(shadowStone),
  AppTheme.fromData(darkBlueberry),
  AppTheme.fromData(blackYellow),
  AppTheme.fromData(halloween),
  AppTheme.fromData(pastel),
  AppTheme.fromData(darkRed),
  AppTheme.fromData(minimalist),
  AppTheme.fromData(darkTeal),
];

final AppThemeModel _default = AppThemeModel()
  ..name = 'Default'
  ..primaryColour = 0xff143d59
  ..accentColor = 0xfff4b41a;

final AppThemeModel light = AppThemeModel()
  ..name = 'Light'
  ..primaryColour = 0xfff5f5f5
  ..accentColor = 0xff333333;

final AppThemeModel amoled = AppThemeModel()
  ..name = 'Amoled'
  ..primaryColour = 0xff000000
  ..accentColor = 0xffffffff;

final AppThemeModel shadowStone = AppThemeModel()
  ..name = 'Shadow Stone'
  ..primaryColour = 0xff2a3132
  ..accentColor = 0xff336b87;

final AppThemeModel darkBlueberry = AppThemeModel()
  ..name = 'Dark Blueberry'
  ..primaryColour = 0xff011a27
  ..accentColor = 0xffffffff;

final AppThemeModel blackYellow = AppThemeModel()
  ..name = 'Blackened Yellow'
  ..primaryColour = 0xff121212
  ..accentColor = 0xffffe01b;

final AppThemeModel halloween = AppThemeModel()
  ..name = 'Halloween'
  ..primaryColour = 0xff121212
  ..accentColor = 0xffff6600;

final AppThemeModel pastel = AppThemeModel()
  ..name = 'Pastel'
  ..primaryColour = 0xffe6ebff
  ..accentColor = 0xffff89ff;

final AppThemeModel darkRed = AppThemeModel()
  ..name = 'Darkest Red'
  ..primaryColour = 0xff121212
  ..accentColor = 0xffb20000;

final AppThemeModel minimalist = AppThemeModel()
  ..name = 'Minimalist'
  ..primaryColour = 0xff293345
  ..accentColor = 0xfff95f7f;

final AppThemeModel darkTeal = AppThemeModel()
  ..name = 'Nightly Teal'
  ..primaryColour = 0xff121212
  ..accentColor = 0xff03dac6;
