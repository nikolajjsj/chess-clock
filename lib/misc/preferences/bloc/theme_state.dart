part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final int? id;
  final ThemeData? themeData;
  final bool? followSystem;

  const ThemeState({this.id, this.themeData, this.followSystem});

  @override
  List<Object?> get props => [id, themeData, followSystem];
}
