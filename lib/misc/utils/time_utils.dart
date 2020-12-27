/// function to show time in appropriate format
String getTimeStringFromDouble(double value, {bool showDecimal = true}) {
  if (value < 0) return '00:00.0';

  String hours = (value / 3600).floor().toString().padLeft(2, '0');
  String minutes = ((value % 3600) / 60).floor().toString().padLeft(2, '0');
  String seconds = ((value % 3600) % 60).floor().toString().padLeft(2, '0');
  String decimal = (((value % 3600) % 60) % 1).toString().substring(2, 3);

  if (hours != '00') {
    return '$hours:$minutes:$seconds${showDecimal ? '.$decimal' : ''}';
  } else {
    return '$minutes:$seconds${showDecimal ? '.$decimal' : ''}';
  }
}
