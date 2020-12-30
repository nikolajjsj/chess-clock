import 'package:chessclock/misc/models/clock_model.dart';
import 'package:chessclock/misc/utils/time_utils.dart';
import 'package:chessclock/screens/clock/clock_screen.dart';
import 'package:chessclock/widgets/clock_detail_cards/detail_card.dart';
import 'package:flutter/material.dart';

class CompactClockCard extends StatelessWidget {
  final ChessClock chessClock;

  const CompactClockCard({
    Key key,
    @required this.chessClock,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _whiteTime =
        getTimeStringFromDouble(chessClock.white.time, showDecimal: false);
    final _whiteInc = chessClock.white?.increment?.toStringAsFixed(0) ?? '';

    return Card(
      child: InkWell(
        onTap: () => Navigator.of(context).push(ClockScreen.route(chessClock)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                chessClock.name,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
              ),
              DetailCard(
                detail: _whiteTime,
                forWhite: false,
                showSeconds: false,
                iconData: Icons.alarm_rounded,
              ),
              if (_whiteInc != '')
                DetailCard(
                  detail: _whiteInc,
                  showSeconds: false,
                  iconData: Icons.arrow_upward_rounded,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
