import 'package:chessclock/misc/default/default_clocks.dart';
import 'package:chessclock/screens/settings/settings_screen.dart';
import 'package:chessclock/widgets/clock_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();

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
      body: ListView.builder(
        itemCount: predefinedClocks.length,
        itemBuilder: (context, index) =>
            ClockCard(chessClock: predefinedClocks[index]),
      ),
    );
  }
}
