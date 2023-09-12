import 'package:flutter/material.dart';

class RecommendedView extends StatelessWidget {
  final int column, items;
  final double ratio, heights, widths, top, bottom, left, right;
  final direction, itemBuilder;
  const RecommendedView({
    Key? key,
    required this.column,
    required this.items,
    required this.ratio,
    this.direction,
    required this.heights,
    required this.widths,
    this.itemBuilder,
    required this.top,
    required this.bottom,
    required this.left,
    required this.right,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heights,
      width: widths,
      color: Colors.white,
      margin: EdgeInsets.only(
        top: top,
        bottom: bottom,
        left: left,
        right: right,
      ),
      child: GridView.builder(
        scrollDirection: direction,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: column,
          childAspectRatio: ratio,
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 0.0,
        ),
        itemCount: items,
        itemBuilder: itemBuilder,
      ),
    );
  }
}
