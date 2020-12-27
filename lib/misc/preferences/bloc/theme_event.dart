part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ChangeTheme extends ThemeEvent {
  final bool light;
  final bool followSystem;

  const ChangeTheme({this.light, this.followSystem = false});

  @override
  List<Object> get props => [light, followSystem];
}
