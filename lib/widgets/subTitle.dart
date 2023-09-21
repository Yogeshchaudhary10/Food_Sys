import 'package:flutter/material.dart';
import 'package:food_ordering_app/resources/color_manager.dart';
import 'package:food_ordering_app/resources/dimension.dart';

class SubTitle extends StatelessWidget {
  final String subTitleText;
  const SubTitle({
    Key? key,
    required this.subTitleText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Text(
        subTitleText,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: Dimension.font16,
          color: AppColors.greyShade200,
        ),
      ),
    );
  }
}
