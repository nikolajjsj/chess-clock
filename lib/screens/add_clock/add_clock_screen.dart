import 'package:chessclock/misc/message_service/message_service.dart';
import 'package:chessclock/misc/models/clock_model.dart';
import 'package:chessclock/misc/models/timer_model.dart';
import 'package:chessclock/misc/utils/time_utils.dart';
import 'package:chessclock/screens/add_clock/bloc/add_clock_bloc.dart';
import 'package:chessclock/widgets/dialog/time_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chessclock/misc/service_locator.dart';

class AddClockScreen extends StatefulWidget {
  static Route route({ChessClock chessClock}) {
    return CupertinoPageRoute(
      builder: (context) => AddClockScreen(chessClock: chessClock),
    );
  }

  final ChessClock chessClock;

  const AddClockScreen({Key key, this.chessClock}) : super(key: key);

  @override
  _AddClockScreenState createState() => _AddClockScreenState();
}

class _AddClockScreenState extends State<AddClockScreen> {
  TextEditingController _textController = TextEditingController();
  double whiteTime;
  double blackTime;
  double whiteIncrement;
  double blackIncrement;
  double whiteDelay;
  double blackDelay;

  void changeWhiteTime(double val) => setState(() => whiteTime = val);
  void changeBlackTime(double val) => setState(() => blackTime = val);
  void changeWhiteInc(double val) => setState(() => whiteIncrement = val);
  void changeBlackInc(double val) => setState(() => blackIncrement = val);
  void changeWhiteDelay(double val) => setState(() => whiteDelay = val);
  void changeBlackDelay(double val) => setState(() => blackDelay = val);

  ChessClock getChessClock() => ChessClock(
        name: _textController.text,
        white: ChessTimer(
          time: whiteTime,
          increment: whiteIncrement == 0.0 ? null : whiteIncrement.toInt(),
          delay: whiteDelay == 0.0 ? null : whiteDelay.toInt(),
        ),
        black: ChessTimer(
          time: blackTime,
          increment: blackIncrement == 0.0 ? null : blackIncrement.toInt(),
          delay: blackDelay == 0.0 ? null : blackDelay.toInt(),
        ),
      );

  addChessClock() {
    if (whiteTime == 0.0 || blackTime == 0.0) {
      return app<MessageService>().show(
        'Whites and blacks time should be at least 1 second',
      );
    } else if (_textController.text == '') {
      return app<MessageService>().show('Clock title is missing');
    } else {
      BlocProvider.of<AddClockBloc>(context)
          .add(AddCustomClock(chessClock: getChessClock()));
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    _textController.text = widget.chessClock?.name ?? '';
    whiteTime = widget.chessClock?.white?.time ?? 0.0;
    blackTime = widget.chessClock?.black?.time ?? 0.0;
    whiteIncrement = widget.chessClock?.white?.increment?.toDouble() ?? 0.0;
    blackIncrement = widget.chessClock?.black?.increment?.toDouble() ?? 0.0;
    whiteDelay = widget.chessClock?.white?.delay?.toDouble() ?? 0.0;
    blackDelay = widget.chessClock?.black?.delay?.toDouble() ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Clock'), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check_rounded),
        onPressed: () => addChessClock(),
      ),
      body: ListView(
        children: [
          Card(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Clock title',
              ),
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          ClockCreationCard(
            title: 'Time',
            white: whiteTime,
            black: blackTime,
            changeWhite: changeWhiteTime,
            changeBlack: changeBlackTime,
          ),
          ClockCreationCard(
            title: 'Increment',
            white: whiteIncrement,
            black: blackIncrement,
            changeWhite: changeWhiteInc,
            changeBlack: changeBlackInc,
          ),
          ClockCreationCard(
            title: 'Delay',
            white: whiteDelay,
            black: blackDelay,
            changeWhite: changeWhiteDelay,
            changeBlack: changeBlackDelay,
          ),
        ],
      ),
    );
  }
}

class ClockCreationCard extends StatefulWidget {
  final String title;
  final double white;
  final double black;
  final Function changeWhite;
  final Function changeBlack;

  ClockCreationCard({
    Key key,
    @required this.title,
    @required this.white,
    @required this.black,
    @required this.changeWhite,
    @required this.changeBlack,
  }) : super(key: key);

  @override
  _ClockCreationCardState createState() => _ClockCreationCardState();
}

class _ClockCreationCardState extends State<ClockCreationCard> {
  bool isComparing = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              widget.title,
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 12.0),
            Row(
              children: [
                const SizedBox(height: 24.0),
                RaisedButton(
                  child: Icon(
                    Icons.compare_arrows_rounded,
                    color: isComparing ? Colors.white : Colors.red,
                  ),
                  color: isComparing ? Colors.green : Colors.white,
                  onPressed: () => setState(() => isComparing = !isComparing),
                ),
                const SizedBox(width: 24.0),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RaisedButton(
                        child: Text(
                          getTimeStringFromDouble(widget.white),
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w900,
                            fontSize: 20.0,
                          ),
                        ),
                        color: Colors.grey[200],
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => TimeDialog(
                            onChanged: (val) {
                              widget.changeWhite(val);
                              if (isComparing) widget.changeBlack(val);
                            },
                          ),
                        ),
                      ),
                      RaisedButton(
                        child: Text(
                          getTimeStringFromDouble(widget.black),
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w900,
                            fontSize: 20.0,
                          ),
                        ),
                        color: Colors.grey[900],
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => TimeDialog(
                            onChanged: (val) {
                              widget.changeBlack(val);
                              if (isComparing) widget.changeWhite(val);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
