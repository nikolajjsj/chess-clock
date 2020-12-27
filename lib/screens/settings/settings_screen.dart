import 'package:chessclock/misc/preferences/layout_preferences.dart';
import 'package:chessclock/misc/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    final _followSystem = app<LayoutPreferences>().followSystemTheme;
    final _lightTheme = app<LayoutPreferences>().lightTheme;

    return Scaffold(
      appBar: AppBar(title: Text('Settings'), centerTitle: true),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Follow system theme'),
            value: _followSystem,
            onChanged: (val) {
              app<LayoutPreferences>().followSystemTheme = val;
              setState(() {});
            },
          ),
          SwitchListTile(
            title: Text('Light theme'),
            value: _lightTheme,
            onChanged: _followSystem
                ? null
                : (val) {
                    app<LayoutPreferences>().lightTheme = val;
                    setState(() {});
                  },
          ),
        ],
      ),
    );
  }
}
