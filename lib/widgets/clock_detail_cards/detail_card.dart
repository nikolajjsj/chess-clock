import 'package:chessclock/misc/utils/color_utils.dart';
import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  final String detail;
  final IconData iconData;
  final bool forWhite;
  final bool showSeconds;

  const DetailCard({
    Key key,
    @required this.detail,
    @required this.iconData,
    this.forWhite = true,
    this.showSeconds = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = forWhite ? Colors.grey[300] : Colors.grey[900];
    final contrastColor = getContrastColor(color);
    final textTheme = Theme.of(context).textTheme;

    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Row(
          children: [
            Icon(iconData, size: 18.0, color: contrastColor),
            const SizedBox(width: 4.0),
            Text(
              detail + (showSeconds ? 's' : ''),
              style: textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.w600,
                color: contrastColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
