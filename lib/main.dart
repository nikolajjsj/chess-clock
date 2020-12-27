import 'package:chessclock/misc/preferences/layout_preferences.dart';
import 'package:chessclock/misc/preferences/preferences.dart';
import 'package:chessclock/misc/service_locator.dart';
import 'package:chessclock/screens/home_screen.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // setup Get_it and SharedPreferences
  setupServiceLocator();
  await app<AppPreferences>().initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _followSystemTheme = app<LayoutPreferences>().followSystemTheme;
    final _showLight = app<LayoutPreferences>().lightTheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _followSystemTheme ? ThemeMode.system : ThemeMode.light,
      darkTheme: _showLight ? ThemeData.light() : ThemeData.dark(),
      theme: _showLight ? ThemeData.light() : ThemeData.dark(),
      title: 'Chess Clock',
      home: const HomeScreen(),
    );
  }
}
