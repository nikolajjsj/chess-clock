import 'package:chessclock/misc/preferences/bloc/theme_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatefulWidget {
  static Route route() {
    return CupertinoPageRoute(builder: (context) => SettingsScreen());
  }

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings'), centerTitle: true),
      body: ListView(
        children: [
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return SwitchListTile(
                title: Text('Follow system theme'),
                value: state.followSystem,
                onChanged: (val) => context
                    .read<ThemeBloc>()
                    .add(ChangeTheme(light: state.light, followSystem: val)),
              );
            },
          ),
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return SwitchListTile(
                title: Text('Light theme'),
                value: state.light,
                onChanged: state.followSystem
                    ? null
                    : (val) => context.read<ThemeBloc>().add(ChangeTheme(
                        followSystem: state.followSystem, light: val)),
              );
            },
          ),
        ],
      ),
    );
  }
}
