import 'package:flutter/material.dart';

import '../resources/dimension.dart';

// ignore: must_be_immutable
class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overFlow;
  BigText({
    Key? key,
    this.color = const Color(0xff091125),
    this.size = 0,
    required this.text,
    this.overFlow = TextOverflow.ellipsis,
    // required String
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overFlow,
      style: TextStyle(
          color: color,
          fontSize: size == 0 ? Dimension.font20 : size,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400),
    );
  }
}
