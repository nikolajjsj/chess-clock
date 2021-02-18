import 'package:chessclock/misc/models/clock_model.dart';
import 'package:chessclock/misc/models/player_enum.dart';
import 'package:chessclock/misc/models/timer_model.dart';
import 'package:chessclock/misc/preferences/general_preferences.dart';
import 'package:chessclock/misc/service_locator.dart';
import 'package:chessclock/misc/utils/time_utils.dart';
import 'package:chessclock/widgets/clock_detail_cards/detail_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'dart:async';

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
  bool _gameOver = false;

  // Sound players for sound effect
  final AssetsAudioPlayer tapPlayer = AssetsAudioPlayer.newPlayer()
    ..open(
      Audio('assets/sounds/tap.wav'),
      autoStart: false,
      respectSilentMode: false,
    );
  final AssetsAudioPlayer overPlayer = AssetsAudioPlayer.newPlayer()
    ..open(
      Audio('assets/sounds/gameover.wav'),
      autoStart: false,
      respectSilentMode: false,
    );

  // delay timer
  Timer _delayTimer;

  Future<void> startTimer() async {
    _isPlaying = true;
    _whiteTimer?.cancel();
    _blackTimer?.cancel();
    _delayTimer?.cancel();
    bool isWhite = _currentPlayer == CurrentPlayer.White;

    _delayTimer = Timer(
      Duration(
        seconds: isWhite
            ? widget.chessClock.white.delay ?? 0
            : widget.chessClock.black.delay ?? 0,
      ),
      () {
        if (isWhite) {
          _whiteTimer = Timer.periodic(
            const Duration(milliseconds: 100),
            (Timer timer) => setState(
              () {
                if (_whiteStart <= 0.0 || _blackStart <= 0.0) {
                  timer.cancel();
                  _gameOver = true;
                  AssetsAudioPlayer.newPlayer().open(
                    Audio('assets/sounds/gameover.mp3'),
                    autoStart: true,
                  );
                } else {
                  if (isWhite) {
                    _whiteStart -= 0.1;
                  } else {
                    _blackStart -= 0.1;
                  }
                }
              },
            ),
          );
        } else {
          _blackTimer = Timer.periodic(
            const Duration(milliseconds: 100),
            (Timer timer) => setState(
              () {
                if (_whiteStart <= 0.0 || _blackStart <= 0.0) {
                  timer.cancel();
                  _gameOver = true;
                  AssetsAudioPlayer.newPlayer().open(
                    Audio('assets/sounds/gameover.mp3'),
                    autoStart: true,
                  );
                } else {
                  if (isWhite) {
                    _whiteStart -= 0.1;
                  } else {
                    _blackStart -= 0.1;
                  }
                }
              },
            ),
          );
        }
      },
    );
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
      tapPlayer.stop();
      tapPlayer.play();
      increment();
      _currentPlayer == CurrentPlayer.White
          ? _currentPlayer = CurrentPlayer.Black
          : _currentPlayer = CurrentPlayer.White;
    }
    startTimer();
    setState(() {});
  }

  void reset() {
    _gameOver = false;
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
    SystemChrome.setEnabledSystemUIOverlays([]);
    _whiteStart = widget.chessClock.white.time;
    _blackStart = widget.chessClock.black.time;
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    _whiteTimer?.cancel();
    _blackTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final _timesOut = _whiteStart <= 0 || _blackStart <= 0;

    return Scaffold(
      body: Stack(
        children: [
          IgnorePointer(
            ignoring: _gameOver,
            child: Column(
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
          ),
          AnimatedSwitcher(
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: animation,
              child: FadeTransition(opacity: animation, child: child),
            ),
            duration: const Duration(milliseconds: 150),
            child: !_isPlaying || _gameOver
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
    final _blackColor = Colors.grey[900];
    final _whiteColor = Colors.white;
    final _sHeight = MediaQuery.of(context).size.height;
    final bool isCurrent = currentPlayer == CurrentPlayer.White
        ? isWhite
            ? true
            : false
        : isWhite
            ? false
            : true;

    return InkWell(
      onTap: () => isCurrent && isPlaying ? playFunction.call() : null,
      child: RotatedBox(
        quarterTurns: isWhite ? 0 : 2,
        child: AnimatedContainer(
          color: isWhite ? _whiteColor : _blackColor,
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          height: isPlaying
              ? isCurrent
                  ? (_sHeight * .75)
                  : (_sHeight * .25)
              : (_sHeight * .5),
          duration: Duration(
            milliseconds: app<GeneralPreferences>().animationDuration,
          ),
          curve: Curves.easeOutCubic,
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
                          color: isWhite ? _blackColor : _whiteColor,
                          fontSize: 52.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          if (chessTimer.increment != null)
                            DetailCard(
                              forWhite: isWhite,
                              iconData: Icons.arrow_upward_rounded,
                              detail: chessTimer.increment.toString(),
                            ),
                          if (chessTimer.delay != null)
                            DetailCard(
                              forWhite: isWhite,
                              iconData: Icons.timer_rounded,
                              detail: chessTimer.delay.toString(),
                            ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 150),
                    child: isPlaying && isCurrent && !(time <= 0)
                        ? FloatingActionButton(
                            backgroundColor: Colors.red,
                            child:
                                Icon(Icons.pause_rounded, color: Colors.white),
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
    );
  }
}
