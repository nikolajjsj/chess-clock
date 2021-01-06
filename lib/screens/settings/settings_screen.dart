import 'package:chessclock/misc/preferences/bloc/theme_bloc.dart';
import 'package:chessclock/screens/settings/theme_screen.dart';
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
    return Scaffold(
      appBar: AppBar(title: Text('Settings'), centerTitle: true),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.brush_rounded),
            title: Text('Theming options'),
            onTap: () => Navigator.of(context).push(ThemesScreen.route()),
          ),
        ],
      ),
    );
  }
}
