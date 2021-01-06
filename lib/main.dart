import 'package:chessclock/misc/message_service/message_widget.dart';
import 'package:chessclock/misc/preferences/bloc/theme_bloc.dart';
import 'package:chessclock/misc/preferences/models/default_themes.dart';
import 'package:chessclock/misc/preferences/preferences.dart';
import 'package:chessclock/misc/service_locator.dart';
import 'package:chessclock/screens/add_clock/bloc/add_clock_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider<AddClockBloc>(
          create: (context) => AddClockBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          final lightTheme = predefinedThemes[1].data;
          final darkTheme = predefinedThemes[2].data;

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.followSystem ? lightTheme : state.themeData,
            darkTheme: state.followSystem ? darkTheme : state.themeData,
            themeMode: state.followSystem ? ThemeMode.system : ThemeMode.light,
            title: 'Chess Clock',
            home: const HomeScreen(),
            builder: (context, child) => MessageWidget(child: child),
          );
        },
      ),
    );
  }
}
