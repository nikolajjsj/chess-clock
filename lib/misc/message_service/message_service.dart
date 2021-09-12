import 'package:chessclock/misc/message_service/message_widget.dart';
import 'package:flutter/material.dart';

class MessageService {
  MessageWidgetState? get messageState => MessageWidget.globalKey.currentState;

  /// Deliver global [SnackBar]
  void show(String message, [SnackBarAction? action]) =>
      messageState!.show(message, action);
}
