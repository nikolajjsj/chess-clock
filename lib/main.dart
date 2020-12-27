import 'package:chessclock/misc/preferences/bloc/theme_bloc.dart';
import 'package:chessclock/misc/preferences/preferences.dart';
import 'package:chessclock/misc/service_locator.dart';
import 'package:chessclock/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await hydrated bloc storage
  HydratedBloc.storage = await HydratedStorage.build();

  // setup Get_it and SharedPreferences
  setupServiceLocator();
  await app<AppPreferences>().initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: state.followSystem ? ThemeMode.system : ThemeMode.light,
          darkTheme: state.followSystem
              ? ThemeData.dark()
              : state.light
                  ? ThemeData.light()
                  : ThemeData.dark(),
          theme: state.followSystem
              ? ThemeData.light()
              : state.light
                  ? ThemeData.light()
                  : ThemeData.dark(),
          title: 'Chess Clock',
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
