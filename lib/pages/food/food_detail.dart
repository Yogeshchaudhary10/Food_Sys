import 'package:flutter/material.dart';
import 'package:food_ordering_app/resources/app_strings_manager.dart';
import 'package:food_ordering_app/resources/routes_manager.dart';
import 'package:food_ordering_app/widgets/app_column.dart';
import 'package:food_ordering_app/widgets/expandable_text__widget.dart';

import '../../resources/color_manager.dart';
import '../../resources/dimension.dart';
import '../../widgets/big_text.dart';

class FoodDetail extends StatelessWidget {
  const FoodDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: AppColors.orange,

        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.homeScreen);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.blackColor,
          ),
        ),
        title: const Text(
          "Cart Page",
          style: TextStyle(color: AppColors.blackColor),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, Routes.settingPage);
              },
              icon: const Icon(
                Icons.settings,
                color: AppColors.blackColor,
              ))
        ],
      ),
      body: Stack(
        children: [
          //backgroundimage
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimension.popularFoodImgSize,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/momo.png"),
                ),
              ),
            ),
          ),
          // for icons
          // Positioned(
          //   top: Dimension.height20,
          //   left: Dimension.width20,
          //   right: Dimension.width20,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       // this should route to home page
          //       GestureDetector(
          //         onTap: () {
          //           // NavigationBar
          //           Navigator.pushNamed(context, Routes.homeScreen);
          //         },
          //         child: AppIcon(
          //           icon: Icons.arrow_back_ios,
          //           background: AppColors.primaryColor,
          //           iconSize: Dimension.iconSize16,
          //         ),
          //       ),
          //       // this should route to cart page
          //       GestureDetector(
          //         onTap: () {
          //           // this should route to cart page
          //           Navigator.pushNamed(context, Routes.cartPage);
          //         },
          //         child: AppIcon(
          //           icon: Icons.add_shopping_cart_outlined,
          //           background: AppColors.primaryColor,
          //           iconSize: Dimension.iconSize16,
          //           iconColor: AppColors.kAccentColor,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // for cloumn and introduction
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimension.popularFoodImgSize - 20,
            child: Container(
              padding: EdgeInsets.only(
                left: Dimension.width20,
                right: Dimension.width20,
                top: Dimension.height20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimension.radius20),
                  topLeft: Radius.circular(Dimension.radius20),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppColumn(text: "Chines side"),
                  SizedBox(
                    height: Dimension.height20,
                  ),
                  BigText(
                    text: "Introduction",
                  ),
                  const Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(
                        text: AppStrings.aboutMomo,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: Dimension.bottomHeightBar,
        padding: EdgeInsets.only(
          top: Dimension.height30,
          bottom: Dimension.height30,
          left: Dimension.width20,
          right: Dimension.width20,
        ),
        decoration: BoxDecoration(
          color: AppColors.greyShade200,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimension.radius40),
            topRight: Radius.circular(Dimension.radius40),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: Dimension.height20,
                  bottom: Dimension.height20,
                  left: Dimension.width20,
                  right: Dimension.width20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimension.radius20),
                  color: Colors.white),
              child: Row(
                children: [
                  const Icon(
                    Icons.remove,
                    color: AppColors.backgroundColor,
                  ),
                  SizedBox(
                    width: Dimension.width5,
                  ),
                  BigText(
                    text: "0",
                    // String: null,
                  ),
                  SizedBox(
                    width: Dimension.width5,
                  ),
                  const Icon(
                    Icons.add,
                    color: AppColors.backgroundColor,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: Dimension.height20,
                  bottom: Dimension.height20,
                  left: Dimension.width20,
                  right: Dimension.width20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimension.radius20),
                color: AppColors.colorBlue,
              ),
              child: BigText(
                text: "Rs.250 | Add to cart",
                color: Colors.white,
                // String: null,
              ),
            )
          ],
        ),
      ),
    );
  }
}
