import 'package:chessclock/misc/preferences/preferences.dart';
import 'package:chessclock/misc/service_locator.dart';

class LayoutPreferences {
  final AppPreferences prefs = app<AppPreferences>();

  /// follow system theme
  bool get followSystemTheme =>
      prefs.preferences.getBool('followSystemTheme') ?? false;
  set followSystemTheme(bool value) =>
      prefs.preferences.setBool('followSystemTheme', value);

  /// Light theme
  bool get lightTheme => prefs.preferences.getBool('lightTheme') ?? false;
  set lightTheme(bool value) => prefs.preferences.setBool('lightTheme', value);

  void defaultSettings() {
    lightTheme = false;
    followSystemTheme = false;
  }
}
