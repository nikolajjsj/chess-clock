import 'package:chessclock/misc/preferences/bloc/theme_bloc.dart';
import 'package:chessclock/misc/preferences/models/default_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemesScreen extends StatelessWidget {
  static Route<dynamic> route() {
    return CupertinoPageRoute(builder: (context) => ThemesScreen());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text("Select your ♥️ theme")),
      body: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) => Column(
          children: [
            SwitchListTile(
              title: Text('Follow system theme', style: textTheme.bodyText2),
              value: state.followSystem,
              onChanged: (val) => context
                  .read<ThemeBloc>()
                  .add(ChangeTheme(id: state.id, followSystem: val)),
            ),
            state.followSystem
                ? const SizedBox()
                : Expanded(child: const ThemeSelectionGrid()),
          ],
        ),
      ),
    );
  }
}

/// A theme selectior choosing between the [predefinedThemes]
class ThemeSelectionGrid extends StatelessWidget {
  const ThemeSelectionGrid();

  @override
  Widget build(BuildContext context) {
    final ScrollController _controller = ScrollController();

    return GridView.builder(
      controller: _controller,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      itemCount: predefinedThemes.length,
      itemBuilder: (context, index) {
        final _theme = predefinedThemes[index];

        return GestureDetector(
          onTap: () => context.read<ThemeBloc>().add(ChangeTheme(id: index)),
          child: Column(
            children: [
              Text(_theme.name, style: Theme.of(context).textTheme.bodyText1),
              const SizedBox(height: 8.0),
              Container(
                height: 75.0,
                width: 75.0,
                decoration: BoxDecoration(
                  border: Border.all(color: _theme.accentColor, width: 8.0),
                  color: _theme.primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
