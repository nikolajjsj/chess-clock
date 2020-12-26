import 'package:chessclock/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chess Clock'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.of(context).push(SettingsScreen.route()),
          )
        ],
      ),
      body: Center(child: Text('Chess!')),
    );
  }
}
