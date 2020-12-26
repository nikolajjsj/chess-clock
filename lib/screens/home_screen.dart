import 'package:chessclock/misc/default/default_clocks.dart';
import 'package:chessclock/misc/models/clock_model.dart';
import 'package:chessclock/screens/clock/clock_screen.dart';
import 'package:chessclock/screens/settings/settings_screen.dart';
import 'package:chessclock/widgets/detail_card.dart';
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
      body: ListView.builder(
        itemCount: predefinedClocks.length,
        itemBuilder: (context, index) {
          return ClockCard(chessClock: predefinedClocks[index]);
        },
      ),
    );
  }
}

class ClockCard extends StatelessWidget {
  final ChessClock chessClock;

  const ClockCard({Key key, @required this.chessClock}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.of(context).push(ClockScreen.route(chessClock)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                chessClock.name,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Column(
                children: [
                  DetailCard(
                    iconData: Icons.alarm,
                    detail: chessClock.white.time.toStringAsFixed(0),
                  ),
                  DetailCard(
                    backgroundColor: Colors.grey[500],
                    iconData: Icons.alarm,
                    detail: chessClock.black.time.toStringAsFixed(0),
                  ),
                ],
              ),
              if (chessClock.white.increment != null)
                Column(
                  children: [
                    DetailCard(
                      iconData: Icons.arrow_upward_rounded,
                      detail: chessClock.white.increment.toStringAsFixed(0),
                    ),
                    DetailCard(
                      backgroundColor: Colors.grey[500],
                      iconData: Icons.arrow_upward_rounded,
                      detail: chessClock.black.increment.toStringAsFixed(0),
                    ),
                  ],
                ),
              if (chessClock.white.delay != null)
                Column(
                  children: [
                    DetailCard(
                      iconData: Icons.timer_rounded,
                      detail: chessClock.white.delay.toStringAsFixed(0),
                    ),
                    DetailCard(
                      backgroundColor: Colors.grey[500],
                      iconData: Icons.timer_rounded,
                      detail: chessClock.black.delay.toStringAsFixed(0),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
