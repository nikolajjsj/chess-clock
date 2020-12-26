import 'package:chessclock/misc/utils/color_utils.dart';
import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  final String detail;
  final IconData iconData;
  final Color backgroundColor;

  const DetailCard({
    Key key,
    @required this.detail,
    @required this.iconData,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor ?? Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Row(
          children: [
            Icon(
              iconData,
              size: 18.0,
              color: backgroundColor != null
                  ? getContrastColor(backgroundColor)
                  : null,
            ),
            const SizedBox(width: 4.0),
            Text(
              detail + (double.parse(detail) >= 60 ? '' : 's'),
              style: TextStyle(
                color: backgroundColor != null
                    ? getContrastColor(backgroundColor)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
