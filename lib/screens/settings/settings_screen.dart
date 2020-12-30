import 'package:chessclock/misc/message_service/message_service.dart';
import 'package:chessclock/misc/preferences/bloc/theme_bloc.dart';
import 'package:chessclock/misc/preferences/preferences.dart';
import 'package:chessclock/misc/service_locator.dart';
import 'package:chessclock/widgets/settings/settings_header.dart';
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
    final compact = app<AppPreferences>().compact;

    return Scaffold(
      appBar: AppBar(title: Text('Settings'), centerTitle: true),
      body: ListView(
        children: [
          SettingsHeader(title: 'Layout'),
          SwitchListTile(
            title: Text('Compact clock cards'),
            value: compact,
            onChanged: (val) {
              app<AppPreferences>().compact = val;
              setState(() {});
              app<MessageService>().show('Please restart app');
            },
          ),
          SettingsHeader(title: 'Theming'),
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
