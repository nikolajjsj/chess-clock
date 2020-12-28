import 'package:chessclock/misc/utils/time_utils.dart';
import 'package:flutter/material.dart';

class TimeDialog extends StatefulWidget {
  final Function(double) onChanged;

  const TimeDialog({
    Key key,
    @required this.onChanged,
  }) : super(key: key);

  @override
  _TimeDialogState createState() => _TimeDialogState();
}

class _TimeDialogState extends State<TimeDialog> {
  double _hours = 0.0;
  double _minutes = 0.0;
  double _seconds = 0.0;

  double getReturnValue() => (_hours * 3600) + (_minutes * 60) + _seconds;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(getTimeStringFromDouble(getReturnValue())),
      actions: [
        FlatButton(
          child: Text('CONFIRM'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Hours'),
          Slider(
            value: _hours,
            min: 0,
            max: 10,
            divisions: 10,
            label: _hours.toStringAsFixed(0),
            inactiveColor: Theme.of(context).primaryColor,
            activeColor: Theme.of(context).accentColor,
            onChanged: (val) {
              setState(() => _hours = val);
              widget.onChanged.call(getReturnValue());
            },
          ),
          Text('Minutes'),
          Slider(
            value: _minutes,
            min: 0,
            max: 60,
            divisions: 60,
            label: _minutes.toStringAsFixed(0),
            inactiveColor: Theme.of(context).primaryColor,
            activeColor: Theme.of(context).accentColor,
            onChanged: (val) {
              setState(() => _minutes = val);
              widget.onChanged.call(getReturnValue());
            },
          ),
          Text('Seconds'),
          Slider(
            value: _seconds,
            min: 0,
            max: 60,
            divisions: 60,
            label: _seconds.toStringAsFixed(0),
            inactiveColor: Theme.of(context).primaryColor,
            activeColor: Theme.of(context).accentColor,
            onChanged: (val) {
              setState(() => _seconds = val);
              widget.onChanged.call(getReturnValue());
            },
          ),
        ],
      ),
    );
  }
}
