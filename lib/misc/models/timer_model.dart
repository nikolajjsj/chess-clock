class ChessTimer {
  final double? time;
  final int? delay;
  final int? increment;

  const ChessTimer({
    required this.time,
    this.delay,
    this.increment,
  });

  ChessTimer.fromJson(Map<String, dynamic> json)
      : time = json['time'],
        delay = json['delay'],
        increment = json['increment'];

  Map<String, dynamic> toJson() => {
        'time': time,
        'delay': delay,
        'increment': increment,
      };
}
