import 'package:flutter/material.dart';
import 'package:food_ordering_app/resources/color_manager.dart';
import 'package:food_ordering_app/resources/dimension.dart';
import 'package:food_ordering_app/resources/routes_manager.dart';
import 'package:food_ordering_app/widgets/app_icon.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imgPath;
  const NoDataPage(
      {Key? key,
      required this.text,
      this.imgPath = "assets/images/empty_cart.png"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 50),
            color: AppColors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // navigate to home page or as per wish
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, Routes.homeScreen);
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.black,
                    background: AppColors.colorBlue,
                    iconSize: Dimension.iconSize24,
                  ),
                ),
                // SizedBox(width: Dimension.width20 * 5),
                // // navigate to home page
                // GestureDetector(
                //   onTap: () {
                //     // navigate to home page
                //     Navigator.pushReplacementNamed(context, Routes.homeScreen);
                //   },
                //   child: AppIcon(
                //     icon: Icons.home_outlined,
                //     iconColor: Colors.black,
                //     background: AppColors.colorBlue,
                //     iconSize: Dimension.iconSize24,
                //   ),
                // ),
                // AppIcon(
                //   icon: Icons.shopping_cart,
                //   iconColor: Colors.black,
                //   background: AppColors.colorBlue,
                //   iconSize: Dimension.iconSize24,
                // )
              ],
            ),
          ),
          SizedBox(
            height: Dimension.height45,
          ),
          Container(
            child: Column(
              children: [
                Image.asset(
                  imgPath,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
