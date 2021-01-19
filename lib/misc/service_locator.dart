import 'package:chessclock/misc/message_service/message_service.dart';
import 'package:chessclock/misc/preferences/general_preferences.dart';
import 'package:chessclock/misc/preferences/preferences.dart';
import 'package:get_it/get_it.dart';

final GetIt app = GetIt.instance;

// setting the services for the app instance
void setupServiceLocator() {
  app
    ..registerLazySingleton<MessageService>(() => MessageService())
    ..registerLazySingleton<AppPreferences>(() => AppPreferences())
    ..registerLazySingleton<GeneralPreferences>(() => GeneralPreferences());
}
