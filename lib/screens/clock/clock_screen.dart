import 'dart:async';
import 'package:chessclock/misc/models/clock_model.dart';
import 'package:chessclock/misc/models/player_enum.dart';
import 'package:chessclock/misc/models/timer_model.dart';
import 'package:chessclock/misc/utils/time_utils.dart';
import 'package:chessclock/widgets/detail_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClockScreen extends StatefulWidget {
  static Route route(ChessClock chessClock) {
    return CupertinoPageRoute(
      builder: (context) => ClockScreen(chessClock: chessClock),
    );
  }

  final ChessClock chessClock;

  const ClockScreen({
    Key key,
    @required this.chessClock,
  }) : super(key: key);

  @override
  _ClockScreenState createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  CurrentPlayer _currentPlayer = CurrentPlayer.Black;
  Timer _whiteTimer;
  Timer _blackTimer;
  double _whiteStart;
  double _blackStart;
  bool _isPlaying = false;
  bool _shouldSwitchPlayer = true;

  // delay timer
  Timer _delayTimer;

  Future<void> startTimer() async {
    _isPlaying = true;
    _whiteTimer?.cancel();
    _blackTimer?.cancel();
    _delayTimer?.cancel();

    if (_currentPlayer == CurrentPlayer.White) {
      _delayTimer = Timer(
        Duration(seconds: widget.chessClock.white.delay ?? 0),
        () => _whiteTimer = Timer.periodic(
          const Duration(milliseconds: 100),
          (Timer timer) => setState(
            () => _whiteStart <= 0
                ? timer.cancel()
                : _whiteStart = _whiteStart - 0.1,
          ),
        ),
      );
    } else {
      _delayTimer = Timer(
        Duration(seconds: widget.chessClock.black.delay ?? 0),
        () => _blackTimer = Timer.periodic(
          const Duration(milliseconds: 100),
          (Timer timer) => setState(
            () => _blackStart <= 0
                ? timer.cancel()
                : _blackStart = _blackStart - 0.1,
          ),
        ),
      );
    }
    _shouldSwitchPlayer = true;
  }

  void pauseTimer() {
    _isPlaying = false;
    _shouldSwitchPlayer = false;
    _whiteTimer?.cancel();
    _blackTimer?.cancel();
    setState(() {});
  }

  void play() {
    if (_shouldSwitchPlayer) {
      increment();
      _currentPlayer == CurrentPlayer.White
          ? _currentPlayer = CurrentPlayer.Black
          : _currentPlayer = CurrentPlayer.White;
    }
    startTimer();
    setState(() {});
  }

  void reset() {
    _currentPlayer = CurrentPlayer.White;
    pauseTimer();
    _whiteStart = widget.chessClock.white.time;
    _blackStart = widget.chessClock.black.time;
    setState(() {});
  }

  void increment() {
    bool white = _currentPlayer == CurrentPlayer.White;
    if (widget.chessClock.white.time == _whiteStart && white) return;
    if (widget.chessClock.black.time == _blackStart && !white) return;
    if (widget.chessClock.black.increment != null && !white) {
      _blackStart = _blackStart + widget.chessClock.black.increment;
    } else if (widget.chessClock.white.increment != null && white) {
      _whiteStart = _whiteStart + widget.chessClock.white.increment;
    }
  }

  @override
  void initState() {
    super.initState();
    _whiteStart = widget.chessClock.white.time;
    _blackStart = widget.chessClock.black.time;
  }

  @override
  void dispose() {
    _whiteTimer?.cancel();
    _blackTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _timesOut = _whiteStart <= 0 || _blackStart <= 0;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              ChessPlayerWidget(
                chessTimer: widget.chessClock.black,
                time: _blackStart,
                isWhite: false,
                currentPlayer: _currentPlayer,
                isPlaying: _isPlaying,
                playFunction: play,
                pauseFunction: pauseTimer,
              ),
              ChessPlayerWidget(
                chessTimer: widget.chessClock.white,
                time: _whiteStart,
                isWhite: true,
                currentPlayer: _currentPlayer,
                isPlaying: _isPlaying,
                playFunction: play,
                pauseFunction: pauseTimer,
              ),
            ],
          ),
          AnimatedSwitcher(
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: animation,
              child: FadeTransition(opacity: animation, child: child),
            ),
            duration: const Duration(milliseconds: 150),
            child: !_isPlaying
                ? Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                          heroTag: null,
                          backgroundColor: Colors.red[800],
                          child:
                              Icon(Icons.replay_rounded, color: Colors.white),
                          onPressed: () => reset(),
                        ),
                        const SizedBox(width: 12.0),
                        if (!_timesOut)
                          FloatingActionButton(
                            heroTag: null,
                            backgroundColor: Colors.red,
                            child: Icon(Icons.play_arrow_rounded,
                                color: Colors.white),
                            onPressed: () => play(),
                          ),
                        const SizedBox(width: 12.0),
                        FloatingActionButton(
                          heroTag: null,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.close_rounded, color: Colors.black),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}

class ChessPlayerWidget extends StatelessWidget {
  final ChessTimer chessTimer;
  final double time;
  final bool isWhite;
  final CurrentPlayer currentPlayer;
  final bool isPlaying;
  final Function playFunction;
  final Function pauseFunction;

  const ChessPlayerWidget({
    Key key,
    @required this.chessTimer,
    @required this.time,
    @required this.isWhite,
    @required this.currentPlayer,
    @required this.isPlaying,
    @required this.playFunction,
    @required this.pauseFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timesOut = time <= 0;
    final bool isCurrent = currentPlayer == CurrentPlayer.White
        ? isWhite
            ? true
            : false
        : isWhite
            ? false
            : true;
    final List<Widget> _details = [
      if (chessTimer.increment != null)
        DetailCard(
          iconData: Icons.arrow_upward_rounded,
          detail: chessTimer.increment.toString(),
        ),
      if (chessTimer.delay != null)
        DetailCard(
          iconData: Icons.timer_rounded,
          detail: chessTimer.delay.toString(),
        ),
    ];

    return Expanded(
      flex: isPlaying && isCurrent ? 4 : 1,
      child: InkWell(
        onTap: () => isCurrent && isPlaying ? playFunction.call() : null,
        child: RotatedBox(
          quarterTurns: isWhite ? 0 : 2,
          child: Container(
            color: isWhite ? Colors.white : Colors.grey,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getTimeStringFromDouble(time),
                          style: TextStyle(
                            color: isWhite ? Colors.grey : Colors.white,
                            fontSize: 52.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(children: _details),
                      ],
                    ),
                    const Spacer(),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 150),
                      child: isPlaying && isCurrent && !timesOut
                          ? FloatingActionButton(
                              backgroundColor: Colors.red,
                              child: Icon(Icons.pause_rounded,
                                  color: Colors.white),
                              onPressed: () => pauseFunction.call(),
                            )
                          : const SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
