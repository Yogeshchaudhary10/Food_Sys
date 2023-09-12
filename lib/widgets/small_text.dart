import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;
  SmallText({
    Key? key,
    this.color = const Color(0xff718380),
    this.size = 12,
    this.height = 1.2,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.clip,
      style: TextStyle(
          color: color,
          fontSize: size,
          height: height,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400),
    );
  }
}
