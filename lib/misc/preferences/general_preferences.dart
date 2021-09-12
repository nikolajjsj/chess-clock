import 'package:chessclock/misc/preferences/preferences.dart';
import 'package:chessclock/misc/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeneralPreferences {
  final SharedPreferences? prefs = app<AppPreferences>().preferences;

  /// Animation speed:
  ///   0 = none
  ///   ranges up to 1000 milliseconds (1 second)
  int get animationDuration => prefs!.getInt('animationDuration') ?? 300;
  set animationDuration(int val) => prefs!.setInt('animationDuration', val);

  void setDefaults() {
    animationDuration = 300;
  }
}
