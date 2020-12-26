import 'package:flutter/material.dart';

class ChessTimer {
  final double time;
  final int delay;
  final int increment;

  const ChessTimer({
    @required this.time,
    this.delay,
    this.increment,
  });

  ChessTimer.fromJson(Map<String, dynamic> json)
      : time = double.parse(json['time']),
        delay = int.parse(json['delay']),
        increment = int.parse(json['increment']);

  Map<String, dynamic> toJson() => {
        'time': time,
        'delay': delay,
        'increment': increment,
      };
}
