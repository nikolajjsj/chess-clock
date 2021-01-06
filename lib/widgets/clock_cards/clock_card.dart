import 'package:chessclock/misc/models/clock_model.dart';
import 'package:chessclock/misc/utils/time_utils.dart';
import 'package:chessclock/screens/clock/clock_screen.dart';
import 'package:chessclock/widgets/clock_detail_cards/detail_card.dart';
import 'package:flutter/material.dart';

class ClockCard extends StatelessWidget {
  final ChessClock chessClock;

  const ClockCard({Key key, @required this.chessClock}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: InkWell(
        onTap: () => Navigator.of(context).push(ClockScreen.route(chessClock)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                chessClock.name,
                style: textTheme.bodyText2.copyWith(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Column(
                children: [
                  DetailCard(
                    iconData: Icons.alarm,
                    detail: getTimeStringFromDouble(
                      chessClock.white.time,
                      showDecimal: false,
                    ),
                    showSeconds: false,
                  ),
                  DetailCard(
                    forWhite: false,
                    iconData: Icons.alarm,
                    detail: getTimeStringFromDouble(
                      chessClock.black.time,
                      showDecimal: false,
                    ),
                    showSeconds: false,
                  ),
                ],
              ),
              if (chessClock.white.increment != null)
                Column(
                  children: [
                    DetailCard(
                      iconData: Icons.arrow_upward_rounded,
                      detail: chessClock.white.increment.toStringAsFixed(0),
                    ),
                    DetailCard(
                      forWhite: false,
                      iconData: Icons.arrow_upward_rounded,
                      detail: chessClock.black.increment.toStringAsFixed(0),
                    ),
                  ],
                ),
              if (chessClock.white.delay != null)
                Column(
                  children: [
                    DetailCard(
                      iconData: Icons.timer_rounded,
                      detail: chessClock.white.delay.toStringAsFixed(0),
                    ),
                    DetailCard(
                      forWhite: false,
                      iconData: Icons.timer_rounded,
                      detail: chessClock.black.delay.toStringAsFixed(0),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
