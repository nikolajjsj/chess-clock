import 'package:flutter/material.dart';

class SettingsHeader extends StatelessWidget {
  final String title;

  const SettingsHeader({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: _theme.textTheme.bodyText2.copyWith(
          fontWeight: FontWeight.bold,
          color: _theme.accentColor,
        ),
      ),
    );
  }
}
