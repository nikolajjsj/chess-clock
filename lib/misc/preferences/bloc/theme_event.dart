part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ChangeTheme extends ThemeEvent {
  final int id;
  final bool followSystem;

  const ChangeTheme({this.id, this.followSystem = false});

  @override
  List<Object> get props => [id, followSystem];
}
