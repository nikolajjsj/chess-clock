import 'package:chessclock/misc/models/clock_model.dart';
import 'package:chessclock/misc/models/timer_model.dart';

final List<ChessClock> predefinedClocks = <ChessClock>[
  ChessClock(
    name: 'Bullet',
    white: ChessTimer(time: 60),
    black: ChessTimer(time: 60),
  ),
  ChessClock(
    name: 'Bullet',
    white: ChessTimer(time: 60, increment: 1),
    black: ChessTimer(time: 60, increment: 1),
  ),
  ChessClock(
    name: 'Bullet',
    white: ChessTimer(time: 120, increment: 1),
    black: ChessTimer(time: 120, increment: 1),
  ),
  ChessClock(
    name: 'Blitz',
    white: ChessTimer(time: 180),
    black: ChessTimer(time: 180),
  ),
  ChessClock(
    name: 'Blitz',
    white: ChessTimer(time: 180, increment: 2),
    black: ChessTimer(time: 180, increment: 2),
  ),
  ChessClock(
    name: 'Blitz',
    white: ChessTimer(time: 300),
    black: ChessTimer(time: 300),
  ),
  ChessClock(
    name: 'Blitz',
    white: ChessTimer(time: 300, increment: 5),
    black: ChessTimer(time: 300, increment: 5),
  ),
  ChessClock(
    name: 'Rapid',
    white: ChessTimer(time: 600),
    black: ChessTimer(time: 600),
  ),
  ChessClock(
    name: 'Rapid',
    white: ChessTimer(time: 600, increment: 2),
    black: ChessTimer(time: 600, increment: 2),
  ),
  ChessClock(
    name: 'Classical',
    white: ChessTimer(time: 900, increment: 10),
    black: ChessTimer(time: 900, increment: 10),
  ),
];
