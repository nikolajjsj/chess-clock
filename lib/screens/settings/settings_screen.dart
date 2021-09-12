import 'package:chessclock/misc/preferences/bloc/theme_bloc.dart';
import 'package:chessclock/misc/preferences/general_preferences.dart';
import 'package:chessclock/misc/service_locator.dart';
import 'package:chessclock/screens/settings/theme_selector.dart';
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
    final textTheme = Theme.of(context).textTheme;
    final _duration = app<GeneralPreferences>().animationDuration;

    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsHeader(title: 'Timer animation duration'),
          Center(
            child: Text(
              _duration == 0 ? 'Instant' : '$_duration milliseconds',
              style: textTheme.bodyText2,
            ),
          ),
          Slider(
            value: _duration.toDouble(),
            min: 0,
            max: 1000,
            divisions: 10,
            onChanged: (val) {
              app<GeneralPreferences>().animationDuration = val.toInt();
              setState(() {});
            },
          ),
          SettingsHeader(title: 'Theming'),
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return SwitchListTile(
                title: Text('Follow system theme', style: textTheme.bodyText2),
                value: state.followSystem!,
                onChanged: (val) => context
                    .read<ThemeBloc>()
                    .add(ChangeTheme(id: state.id, followSystem: val)),
              );
            },
          ),
          const ThemeSelector(),
        ],
      ),
    );
  }
}
