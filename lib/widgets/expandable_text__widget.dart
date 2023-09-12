import 'package:flutter/material.dart';
import 'package:food_ordering_app/resources/color_manager.dart';
import 'package:food_ordering_app/resources/dimension.dart';
import 'package:food_ordering_app/widgets/small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableTextWidget> {
  late String firstHalf; // we use late to initalize them later
  late String secondHalf;

  bool hiddenText = true;

  double textHeight = Dimension.screenHeight / 5.63;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight.toInt()) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
      print(secondHalf);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(
              height: 1.8,
              color: AppColors.smallTextColor,
              size: Dimension.font16,
              text: firstHalf)
          : Column(children: [
              SmallText(
                  height: 1.8,
                  color: AppColors.smallTextColor,
                  size: Dimension.font16,
                  text: hiddenText
                      ? ("$firstHalf ...")
                      : (firstHalf + secondHalf)),
              InkWell(
                onTap: () {
                  setState(() {
                    hiddenText = !hiddenText;
                  });
                },
                child: Row(
                  children: [
                    SmallText(
                      text: "Show more",
                      color: AppColors.colorBlue,
                    ),
                    Icon(
                      hiddenText ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                      color: AppColors.colorBlue,
                    )
                  ],
                ),
              ),
            ]),
    );
  }
}
