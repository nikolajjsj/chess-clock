import 'package:chessclock/misc/default/default_clocks.dart';
import 'package:chessclock/widgets/clock_cards/clock_card.dart';
import 'package:flutter/material.dart';

class DefaultScreen extends StatelessWidget {
  const DefaultScreen();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: predefinedClocks.length,
      itemBuilder: (context, index) {
        return ClockCard(chessClock: predefinedClocks[index]);
      },
    );
  }
}
