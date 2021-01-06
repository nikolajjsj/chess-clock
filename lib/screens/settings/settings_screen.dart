import 'package:chessclock/screens/settings/theme_screen.dart';
import 'package:chessclock/widgets/settings/settings_header.dart';
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
    final _theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          SettingsHeader(title: 'Theming options'),
          ListTile(
            leading: Icon(Icons.brush_rounded),
            title: Text('Themes', style: _theme.textTheme.bodyText2),
            onTap: () => Navigator.of(context).push(ThemesScreen.route()),
          ),
        ],
      ),
    );
  }
}
