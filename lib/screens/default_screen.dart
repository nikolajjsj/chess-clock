import 'package:chessclock/misc/default/default_clocks.dart';
import 'package:chessclock/misc/preferences/preferences.dart';
import 'package:chessclock/misc/service_locator.dart';
import 'package:chessclock/widgets/clock_cards/clock_card.dart';
import 'package:chessclock/widgets/clock_cards/compact_clock_card.dart';
import 'package:flutter/material.dart';

class DefaultScreen extends StatelessWidget {
  const DefaultScreen();

  @override
  Widget build(BuildContext context) {
    if (app<AppPreferences>().compact) {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: predefinedClocks.length,
        itemBuilder: (context, index) {
          return CompactClockCard(chessClock: predefinedClocks[index]);
        },
      );
    } else {
      return ListView.builder(
        itemCount: predefinedClocks.length,
        itemBuilder: (context, index) {
          return ClockCard(chessClock: predefinedClocks[index]);
        },
      );
    }
  }
}
