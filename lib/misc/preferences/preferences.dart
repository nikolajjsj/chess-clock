import 'package:shared_preferences/shared_preferences.dart';

/// Wraps the [SharedPreferences].
class AppPreferences {
  SharedPreferences _preferences;

  SharedPreferences get preferences => _preferences;

  // Initializes the [_preferences] instance.
  Future<void> initialize() async {
    print('initializing preferences');
    _preferences = await SharedPreferences.getInstance();
    print('initialized preferences');
  }
}
