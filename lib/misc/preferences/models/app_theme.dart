import 'package:chessclock/misc/preferences/models/theme_model.dart';
import 'package:chessclock/misc/utils/color_utils.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme.fromData(AppThemeModel data) {
    name = data.name ?? '';
    fontSize = 15;
    bodyFont = 'OpenSans';
    primaryColor = Color(data.primaryColour!);
    accentColor = Color(data.accentColor ?? 0xff6b99ff);

    _calculateBrightness();
    _calculateButtonTextColor();
    _setupTextTheme();
    _setupThemeData();
  }

  late String name;
  double? fontSize;
  String? bodyFont;
  Color? primaryColor;
  Color? accentColor;
  Brightness? brightness;
  Color? buttonTextColor;
  TextTheme? textTheme;
  ThemeData? data;

  Color get backgroundComplimentaryColor =>
      brightness == Brightness.light ? Colors.black : Colors.white;

  void _calculateBrightness() {
    brightness = primaryColor!.computeLuminance() > .5
        ? Brightness.light
        : Brightness.dark;
  }

  /// Calculates the button text color, which is the [primaryColor] if it is not
  /// the same brightness as the button color, otherwise a complimentary color
  /// (white / black).
  void _calculateButtonTextColor() {
    final Brightness primaryColorBrightness =
        ThemeData.estimateBrightnessForColor(primaryColor!);

    if (brightness == Brightness.dark) {
      // button color is light
      buttonTextColor = primaryColorBrightness == Brightness.light
          ? Colors.black
          : primaryColor;
    } else {
      // button color is dark
      buttonTextColor = primaryColorBrightness == Brightness.dark
          ? Colors.white
          : primaryColor;
    }
  }

  void _setupTextTheme() {
    final Color textColor = backgroundComplimentaryColor;

    textTheme = Typography.englishLike2018.apply(fontFamily: bodyFont).copyWith(
          // headline
          headline1: TextStyle(
            fontSize: 64,
            letterSpacing: 6,
            fontFamily: bodyFont,
            fontWeight: FontWeight.w300,
            color: textColor,
          ),
          headline2: TextStyle(
            fontSize: 48,
            letterSpacing: 2,
            fontFamily: bodyFont,
            fontWeight: FontWeight.w300,
            color: textColor,
          ),
          headline3: TextStyle(
            fontFamily: bodyFont,
            color: textColor,
          ),
          headline4: TextStyle(
            fontSize: 18,
            letterSpacing: 2,
            fontFamily: bodyFont,
            fontWeight: FontWeight.w300,
            color: textColor.withOpacity(0.8),
          ),
          headline6: TextStyle(
            letterSpacing: 2,
            fontFamily: bodyFont,
            fontWeight: FontWeight.w300,
            color: textColor,
          ),

          // subtitle
          subtitle1: TextStyle(
            letterSpacing: 1,
            fontFamily: bodyFont,
            fontWeight: FontWeight.w300,
            color: textColor.withOpacity(0.9),
          ),
          subtitle2: TextStyle(
            height: 1.1,
            fontSize: 16,
            fontFamily: bodyFont,
            fontWeight: FontWeight.w300,
            color: textColor,
          ),

          // body
          bodyText2: TextStyle(
            fontSize: fontSize,
            fontFamily: bodyFont,
          ),
          bodyText1: TextStyle(
            fontSize: fontSize! - 2,
            fontFamily: bodyFont,
            color: textColor.withOpacity(0.7),
          ),

          button: TextStyle(
            fontSize: fontSize,
            letterSpacing: 1.2,
            fontFamily: bodyFont,
            color: buttonTextColor,
          ),
        );
  }

  void _setupThemeData() {
    final Color _complimentaryColor = backgroundComplimentaryColor;
    final Color? _lightenedColor = lighten(primaryColor, .05);

    data = ThemeData(
      brightness: brightness,
      textTheme: textTheme,
      primaryColor: primaryColor,
      dividerColor: brightness == Brightness.dark
          ? Colors.white.withOpacity(.2)
          : Colors.black.withOpacity(.2),
      primaryColorBrightness: brightness,
      cardColor: primaryColor,
      canvasColor: primaryColor,
      toggleableActiveColor: accentColor,
      appBarTheme: AppBarTheme(
        color: _lightenedColor,
        centerTitle: true,
        foregroundColor: getContrastColor(primaryColor!),
      ),
      dialogBackgroundColor: primaryColor,
      cardTheme: CardTheme(
        color: _lightenedColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: accentColor,
        inactiveTrackColor: _lightenedColor,
        thumbColor: accentColor,
        valueIndicatorColor: accentColor,
        activeTickMarkColor: accentColor,
        inactiveTickMarkColor: accentColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: _lightenedColor,
        selectedItemColor: accentColor,
        unselectedItemColor: _complimentaryColor.withOpacity(.5),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: textTheme!.bodyText2!.copyWith(
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: textTheme!.bodyText2!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: fontSize! - 1,
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: accentColor,
        cursorColor: accentColor,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _lightenedColor,
        foregroundColor: accentColor,
      ),
    );
  }
}
