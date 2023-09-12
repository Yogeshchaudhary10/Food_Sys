import 'package:flutter/material.dart';
import 'package:food_ordering_app/widgets/small_text.dart';
import '../resources/color_manager.dart';
import '../resources/dimension.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimension.font26,
          // String: null,
        ),
        const SizedBox(
          height: 10,
        ),
        Flexible(
          child: Row(
            children: [
              Wrap(
                  children: List.generate(5, (index) {
                // ignore: prefer_const_constructors
                return Icon(
                  Icons.star,
                  color: AppColors.colorBlue,
                  size: Dimension.font20,
                );
              })),
              const SizedBox(
                width: 10,
              ),
              SmallText(text: "4.5"),
              const SizedBox(
                width: 10,
              ),
              SmallText(text: "1237"),
              const SizedBox(
                width: 10,
              ),
              SmallText(text: "comments")
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            IconAndText(
              icon: Icons.circle_sharp,
              // iconColor: AppColors.blackColor,
              text: "Normal",
            ),
            IconAndText(
              icon: Icons.location_on,
              // iconColor: AppColors.colorRose,
              text: "1.7km",
            ),
            IconAndText(
              icon: Icons.access_time_rounded,
              // iconColor: AppColors.blackColor,
              text: "32min",
            )
          ],
        )
      ],
    );
  }
}
