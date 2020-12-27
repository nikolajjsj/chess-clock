part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final bool light;
  final bool followSystem;

  const ThemeState({this.light, this.followSystem});

  @override
  List<Object> get props => [light, followSystem];
}
