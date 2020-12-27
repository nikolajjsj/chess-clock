import 'package:chessclock/screens/add_clock/add_clock_screen.dart';
import 'package:flutter/material.dart';

class HomeFAB extends StatelessWidget {
  const HomeFAB();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add_rounded),
      onPressed: () => Navigator.of(context).push(AddClockScreen.route()),
    );
  }
}
