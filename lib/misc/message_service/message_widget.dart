import 'package:flutter/material.dart';

/// Message Widget to show [SnackBar]s in the app using a [globalKey].
class MessageWidget extends StatefulWidget {
  static final GlobalKey<MessageWidgetState> globalKey =
      GlobalKey<MessageWidgetState>();

  final Widget? child;

  MessageWidget({required this.child}) : super(key: globalKey);

  @override
  MessageWidgetState createState() => MessageWidgetState();
}

class MessageWidgetState extends State<MessageWidget> {
  final GlobalKey<ScaffoldMessengerState> _messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  void show(String message, [SnackBarAction? action]) {
    _messengerKey.currentState!.hideCurrentSnackBar();
    _messengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(message),
        action: action,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _messengerKey,
      child: Scaffold(body: widget.child),
    );
  }
}
