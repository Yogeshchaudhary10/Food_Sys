import 'package:flutter/material.dart';
import 'package:food_ordering_app/resources/color_manager.dart';

class EmptySection extends StatelessWidget {
  final String emptyImg, emptyMsg;
  const EmptySection({
    Key? key,
    required this.emptyImg,
    required this.emptyMsg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(emptyImg),
            height: 150.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              emptyMsg,
              style: const TextStyle(
                fontSize: 20.0,
                color: AppColors.blackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
