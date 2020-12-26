import 'package:chessclock/misc/models/timer_model.dart';
import 'package:flutter/material.dart';

class ChessClock {
  final String name;
  final ChessTimer white;
  final ChessTimer black;

  const ChessClock({
    @required this.name,
    @required this.white,
    @required this.black,
  });

  ChessClock.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        white = ChessTimer.fromJson(json['white']),
        black = ChessTimer.fromJson(json['black']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'white': white,
        'black': black,
      };
}
