import 'package:chessclock/misc/preferences/layout_preferences.dart';
import 'package:chessclock/misc/preferences/preferences.dart';
import 'package:get_it/get_it.dart';

final GetIt app = GetIt.instance;

// setting the services for the app instance
void setupServiceLocator() {
  app

    /// preferences
    ..registerLazySingleton<AppPreferences>(() => AppPreferences())
    ..registerLazySingleton<LayoutPreferences>(() => LayoutPreferences());
}
