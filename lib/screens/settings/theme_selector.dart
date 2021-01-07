import 'package:chessclock/misc/preferences/bloc/theme_bloc.dart';
import 'package:chessclock/misc/preferences/models/app_theme.dart';
import 'package:chessclock/misc/preferences/models/default_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeSelector extends StatelessWidget {
  static Route<dynamic> route() {
    return CupertinoPageRoute(builder: (context) => ThemeSelector());
  }

  const ThemeSelector();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) => Expanded(
        child: ListView.builder(
          itemCount: predefinedThemes.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final AppTheme _theme = predefinedThemes[index];

            return GestureDetector(
              onTap: () =>
                  context.read<ThemeBloc>().add(ChangeTheme(id: index)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(_theme.name, style: textTheme.bodyText1),
                    const SizedBox(height: 8.0),
                    Container(
                      height: 80.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _theme.accentColor,
                          width: 8.0,
                        ),
                        color: _theme.primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
