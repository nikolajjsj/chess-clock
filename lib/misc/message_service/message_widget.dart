import 'package:chessclock/misc/utils/color_utils.dart';
import 'package:flutter/material.dart';

/// Message Widget to show [SnackBar]s in the app using a [globalKey].
class MessageWidget extends StatefulWidget {
  static final GlobalKey<MessageWidgetState> globalKey =
      GlobalKey<MessageWidgetState>();

  final Widget child;
  MessageWidget({@required this.child}) : super(key: globalKey);

  @override
  MessageWidgetState createState() => MessageWidgetState();
}

class MessageWidgetState extends State<MessageWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void show(String message, [SnackBarAction action]) {
    final _theme = Theme.of(context);
    final _contrast = getContrastColor(_theme.accentColor);
    final _textStyle = _theme.textTheme.bodyText2.copyWith(color: _contrast);

    _scaffoldKey.currentState.hideCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message, style: _textStyle),
        backgroundColor: _theme.accentColor,
        action: action,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffoldKey, body: widget.child);
  }
}
