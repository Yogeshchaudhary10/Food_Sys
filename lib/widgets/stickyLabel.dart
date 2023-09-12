import 'package:flutter/material.dart';
import 'package:food_ordering_app/resources/dimension.dart';

class StickyLabel extends StatelessWidget {
  final String text;
  final Color textColor;
  const StickyLabel({
    Key? key,
    required this.text,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(
        left: Dimension.width10 * 2.4,
        top: Dimension.height10 * 1.6,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: Dimension.font20,
        ),
      ),
    );
  }
}
